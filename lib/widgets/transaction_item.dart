import 'dart:math';

import 'package:expenses_manager/models/transation.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
   Key key,
    @required this.tx,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction tx;
  final Function deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    // TODO: implement initState

    const colors = [
      Colors.red,
      Colors.blue,
      Colors.yellow,
      Colors.green,
    ];

    _bgColor = colors[Random().nextInt(4)];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'MT ${widget.tx.amount.toStringAsFixed(2)}',
                style: TextStyle(),
              ),
            ),
          ),
        ),
        title: Text(
          widget.tx.title,
        ),
        subtitle: Text(
          widget.tx.formatedDate,
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                textColor: Theme.of(context).errorColor,
                onPressed: () => this.widget.deleteTransaction(widget.tx),
                icon: const Icon(Icons.delete),
                label: const Text('Delete'))
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => this.widget.deleteTransaction(widget.tx),
              ),
      ),
    );
  }
}
