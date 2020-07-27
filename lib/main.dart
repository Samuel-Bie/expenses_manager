import 'package:expenses_manager/widgets/chart.dart';
import 'package:expenses_manager/widgets/new_transation.dart';
import 'package:expenses_manager/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'models/transation.dart';
import 'dart:io';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
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
              button: TextStyle(color: Colors.white),
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      var date = DateTime.now().subtract(Duration(days: 7));
      return element.date.isAfter(date);
    }).toList();
  }

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

  void _deleteTransaction(Transaction tx) {
    setState(() {
      this._transactions.remove(tx);
    });
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final tx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );
    setState(() {
      this._transactions.add(tx);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mdQuery = MediaQuery.of(context);
    final bool isLandscape = mdQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'Personal Expenses',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape) ..._buildLandscape(mdQuery, appBar, _showChart),
            if (!isLandscape) ..._buildPortrait(mdQuery, appBar),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isAndroid
          ? FloatingActionButton(
              onPressed: () => _startAddNewTransaction(context),
              child: Icon(Icons.add),
            )
          : Container(),
    );
  }

  List<Widget> _buildLandscape(
      MediaQueryData mdQuery, AppBar appBar, bool _showChart) {
    final txList = Container(
      height: (mdQuery.size.height * 0.6 -
          appBar.preferredSize.height -
          mdQuery.padding.top),
      child: TransactionList(_transactions, _deleteTransaction),
    );

    final chartLand = Container(
      height: (mdQuery.size.height * 0.6 -
          appBar.preferredSize.height -
          mdQuery.padding.top),
      child: Chart(
        recentTransactions: _recentTransactions,
      ),
    );

    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Show chart'),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (value) {
              setState(() {
                _showChart = value;
              });
            },
          ),
        ],
      ),
      _showChart ? chartLand : txList,
    ];
  }

  List<Widget> _buildPortrait(MediaQueryData mdQuery, AppBar appBar) {
    return [
      Container(
        height: (mdQuery.size.height * 0.4 -
            appBar.preferredSize.height -
            mdQuery.padding.top),
        child: Chart(
          recentTransactions: _recentTransactions,
        ),
      ),
      Container(
        height: (mdQuery.size.height * 0.6 -
            appBar.preferredSize.height -
            mdQuery.padding.top),
        child: TransactionList(_transactions, _deleteTransaction),
      )
    ];
  }
}
