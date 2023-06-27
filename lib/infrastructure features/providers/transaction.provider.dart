import '../models/transaction.model.dart';

abstract class TransactionProvider {
  Future<void> fetchTransactions();
  List<Transaction> get filteredTransactions;
  bool get loading;
  String get error;
}