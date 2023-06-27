import '../models/transaction.model.dart';

abstract class TransactionService {
  Future<List<Transaction>> fetchTransactions();
}



