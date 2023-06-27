import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app features/transaction/screens/transactions_list.screen.dart';
import 'infrastructure features/transaction/services/api/transaction_api.service.dart';
import 'infrastructure features/transaction/viewmodels/transaction_viewmodel.vm.dart';

void main() {
  runApp(TransactionApp());
}

class TransactionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TransactionListViewModel>(
      create: (_) => TransactionListViewModel(TransactionApiService()),
      child: MaterialApp(
        title: 'Bank Transactions',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TransactionListScreen(),
      ),
    );
  }
}

