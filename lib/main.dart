import 'package:expenses_manager/transation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(id:'t1', title: "New Shoes",          amount:15.55, date: DateTime.now()),
    Transaction(id:'t2', title: "New Book",           amount:152.02, date: DateTime.now()),
    Transaction(id:'t3', title: "New MBP",            amount:15.22, date: DateTime.now()),
    Transaction(id:'t4', title: "Party",              amount:15.26, date: DateTime.now()),
    Transaction(id:'t5', title: "Chill with friends", amount:95, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses manager'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              elevation: 5,
              child: Text('CHART'),
            ),
          ),

          Column(
            children: transactions.map(
              (transaction) {
                return Card(child: Text(transaction.title),);
              }
            ).toList(),
          )
        ],
      ),
    );
  }
}
