import 'package:expenses_manager/widgets/new_transation.dart';
import 'package:expenses_manager/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'models/transation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeData.light().textTheme.copyWith(
          subtitle1: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //     id: 't1', title: "New Shoes", amount: 15.55, date: DateTime.now()),
    // Transaction(
    //     id: 't1', title: "New Shoes", amount: 15.55, date: DateTime.now()),
    // Transaction(
    //     id: 't1', title: "New Shoes", amount: 15.55, date: DateTime.now()),
    // Transaction(
    //     id: 't1', title: "New Shoes", amount: 15.55, date: DateTime.now()),
    // Transaction(
    //     id: 't1', title: "New Shoes", amount: 15.55, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: "New Book", amount: 152.02, date: DateTime.now()),
    // Transaction(
    //     id: 't3', title: "New MBP", amount: 15.22, date: DateTime.now()),
    // Transaction(id: 't4', title: "Party", amount: 15.26, date: DateTime.now()),
  ];

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(this._addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _addNewTransaction(String title, double amount) {
    final tx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());
    setState(() {
      this._transactions.add(tx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                elevation: 5,
                child: Text('CHART'),
              ),
            ),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
