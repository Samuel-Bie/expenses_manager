import 'package:expenses_manager/models/transation.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No Transactions',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : _MainList(transactions: transactions),
    );
  }
}

class _MainList extends StatelessWidget {
  const _MainList({
    Key key,
    @required this.transactions,
  }) : super(key: key);

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        Transaction tx = transactions[index];
        return Card(
          margin: EdgeInsets.all(5),
          elevation: 5,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'MT ${tx.amount.toStringAsFixed(2)}',
                    style: TextStyle(),
                  ),
                ),
              ),
            ),
            title: Text(
              tx.title,
            ),
            subtitle: Text(
              tx.formatedDate,
            ),
          ),
        );
      },
      itemCount: this.transactions.length,
    );
  }
}
