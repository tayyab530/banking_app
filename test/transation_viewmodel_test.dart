import 'package:banking_app/infrastructure%20features/transaction/interfaces/transaction_service.interface.dart';
import 'package:banking_app/infrastructure%20features/transaction/models/transaction.model.dart';
import 'package:banking_app/infrastructure%20features/transaction/viewmodels/transaction_viewmodel.vm.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'transation_viewmodel_test.mocks.dart';

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks([MockSpec<TransactionService>()])

void main() {
  group('TransactionListViewModel', () {
    late TransactionListViewModel viewModel;
    late MockTransactionService mockTransactionService;

    final testTransactions = [
      Transaction(
        id: '1',
        date: DateTime(2023, 4, 15, 5, 57, 47),
        amount: 281.28,
        currency: 'ILS',
        type: 'deposit',
        description:
        'invoice transaction at Block, Skiles and Herman using card ending with ***(...4033) for HTG 161.74 in account ***20234535',
      ),
      Transaction(
        id: '2',
        date: DateTime(2023, 2, 27, 0, 7, 53),
        amount: 409.51,
        currency: 'BDT',
        type: 'payment',
        description:
        'invoice transaction at Rice, Roberts and Stamm using card ending with ***(...2597) for MDL 659.22 in account ***44595562',
      ),
    ];

    setUp(() {
      mockTransactionService = MockTransactionService();
      viewModel = TransactionListViewModel(mockTransactionService);
    });

    test('fetchTransactions - success (positive test case)', () async {
      // Arrange
      when(mockTransactionService.fetchTransactions())
          .thenAnswer((_) async => testTransactions);

      // Act
      await viewModel.fetchTransactions();

      // Assert
      expect(viewModel.loading, false);
      expect(viewModel.error, '');
      expect(viewModel.filteredTransactions, testTransactions);
    });

    test('fetchTransactions - failure (negative test case)', () async {
      // Arrange
      when(mockTransactionService.fetchTransactions())
          .thenThrow(Exception('Failed to fetch transactions'));

      // Act
      await viewModel.fetchTransactions();

      // Assert
      expect(viewModel.loading, false);
      expect(viewModel.error, 'Exception: Failed to fetch transactions');
      expect(viewModel.filteredTransactions, []);
    });

    test('filterTransactions', () {
      // Arrange
      const searchTerm = 'Hello';

      // Act
      viewModel.filterTransactions(searchTerm);

      // Assert
      expect(viewModel.filteredTransactions.length, 0);
    });

  });
}
