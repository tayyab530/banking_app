import 'package:banking_app/infrastructure%20features/transaction/models/transaction.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../infrastructure features/transaction/viewmodels/transaction_viewmodel.vm.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/text.dart';
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
          builder: (context, ss) {
            if (transactionProvider.loading) {
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
                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                          itemBuilder: (context, index) {
                            final transaction =
                                viewModel.filteredTransactions[index];
                            return _buildTile(transaction,context);
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget _buildTile(Transaction transaction,BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_,__,___)=>TransactionDetailsScreen(transaction: transaction)));
      },
      child: Container(
        height: 80,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: const BoxDecoration(
          color: AppColors.secondaryAndroid,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 19.0, right: 19),
              child: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.check),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    transaction.amount.toString(),
                    style: AppText.taskListTileHeadingTextStyle,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(transaction.formattedDate),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Chip(label: Text(transaction.type)),
            )
          ],
        ),
      ),
    );
  }
}
