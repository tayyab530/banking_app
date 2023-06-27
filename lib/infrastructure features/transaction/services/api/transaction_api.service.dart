import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../models/transaction.model.dart';
import '../../interfaces/transaction_service.interface.dart';

class TransactionApiService implements TransactionService {
  @override
  Future<List<Transaction>> fetchTransactions() async {
    try {
      final response = await http.get(Uri.parse(
          'https://64677d7f2ea3cae8dc3091e7.mockapi.io/api/v1/transactions'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        return responseData
            .map((transaction) => Transaction.fromJson(transaction))
            .toList();
      } else {
        throw Exception('Failed to fetch transactions');
      }
    } catch (e) {
      throw Exception('An error occurred');
    }
  }
}