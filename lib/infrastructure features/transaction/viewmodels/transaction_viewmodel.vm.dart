import 'package:flutter/material.dart';
import '../models/transaction.model.dart';
import '../providers/transaction.provider.dart';
import '../interfaces/transaction_service.interface.dart';

class TransactionListViewModel extends ChangeNotifier
    implements TransactionProvider {
  final TransactionService _transactionService;
  List<Transaction> _transactions = [];
  List<Transaction> _filteredTransactions = [];
  bool _loading = false;
  String _error = '';

  TransactionListViewModel(this._transactionService);

  @override
  List<Transaction> get filteredTransactions => _filteredTransactions;

  @override
  bool get loading => _loading;
  @override
  String get error => _error;

  @override
  Future<void> fetchTransactions() async {
    try {
      _loading = true;
      _transactions = await _transactionService.fetchTransactions();
      _transactions.sort(_sortByDateTime); // Sort transactions by date and time
      _filteredTransactions = _transactions;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void filterTransactions(String searchTerm) {
    _filteredTransactions = _transactions
        .where((transaction) =>
    transaction.description.contains(searchTerm) ||
        transaction.type.contains(searchTerm) ||
        transaction.formattedDate.contains(searchTerm)
    )
        .toList();
    notifyListeners();
  }

  // Comparator to sort transactions by date and time in ascending order
  int _sortByDateTime(Transaction a, Transaction b) {
    return a.date.compareTo(b.date);
  }
}
