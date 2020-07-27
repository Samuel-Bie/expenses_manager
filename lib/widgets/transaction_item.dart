import 'package:expenses_manager/models/transation.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.tx,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction tx;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
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
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                textColor: Theme.of(context).errorColor,
                onPressed: () => this.deleteTransaction(tx),
                icon: const Icon(Icons.delete),
                label: const Text('Delete'))
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => this.deleteTransaction(tx),
              ),
      ),
    );
  }
}
