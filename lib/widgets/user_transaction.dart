import 'package:expenses_manager/models/transation.dart';
import 'package:expenses_manager/widgets/new_transation.dart';
import 'package:expenses_manager/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(
        id: 't1', title: "New Shoes", amount: 15.55, date: DateTime.now()),
   Transaction(
        id: 't1', title: "New Shoes", amount: 15.55, date: DateTime.now()),
   Transaction(
        id: 't1', title: "New Shoes", amount: 15.55, date: DateTime.now()),
   Transaction(
        id: 't1', title: "New Shoes", amount: 15.55, date: DateTime.now()),
   Transaction(
        id: 't1', title: "New Shoes", amount: 15.55, date: DateTime.now()),
    Transaction(
        id: 't2', title: "New Book", amount: 152.02, date: DateTime.now()),
    Transaction(
        id: 't3', title: "New MBP", amount: 15.22, date: DateTime.now()),
    Transaction(id: 't4', title: "Party", amount: 15.26, date: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount){
    final tx = Transaction(id: DateTime.now().toString(), title: title, amount: amount, date: DateTime.now());
    setState(() {
      this._transactions.add(tx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_transactions),
      ],
    );
  }
}
