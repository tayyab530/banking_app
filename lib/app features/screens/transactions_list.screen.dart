import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../infrastructure features/services/transaction_service.interface.dart';
import '../../infrastructure features/viewmodels/transaction_viewmodel.vm.dart';
import 'transaction_detail.screen.dart';

class TransactionListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionProvider =
    Provider.of<TransactionListViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Transactions'),
      ),
      body: FutureBuilder(
        future: transactionProvider.fetchTransactions(),
        builder: (context,ss) {
          if(transactionProvider.loading){
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<TransactionListViewModel>(
                  builder: (context, viewModel, _) {
                    return TextField(
                      onChanged: (value) {
                        viewModel.filterTransactions(value);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Consumer<TransactionListViewModel>(
                  builder: (context, viewModel, _) {
                    if (viewModel.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (viewModel.error.isNotEmpty) {
                      return Center(child: Text(viewModel.error));
                    } else {
                      return ListView.builder(
                        itemCount: viewModel.filteredTransactions.length,
                        itemBuilder: (context, index) {
                          final transaction = viewModel.filteredTransactions[index];
                          return ListTile(
                            title: Text(
                              transaction.formattedDate,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Amount: ${transaction.amount} Currency: ${transaction.currency}  Type: ${transaction.type}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TransactionDetailsScreen(transaction: transaction),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
