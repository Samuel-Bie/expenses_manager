import 'package:expenses_manager/models/transation.dart';
import 'package:expenses_manager/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Container(
                    height: constraints.maxHeight * 0.2,
                    child: Text(
                      'No Transactions',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.7,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : _MainList(
              transactions: transactions,
              deleteTransaction: this.deleteTransaction,
            ),
    );
  }
}

class _MainList extends StatelessWidget {
  const _MainList(
      {Key key, @required this.transactions, @required this.deleteTransaction})
      : super(key: key);

  final List<Transaction> transactions;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ...transactions
            .map((e) => TransactionItem(
                key: ValueKey(e.id),
                tx: e,
                deleteTransaction: deleteTransaction))
            .toList()
      ],
    );
  }
}