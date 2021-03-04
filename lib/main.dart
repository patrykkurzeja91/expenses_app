import 'package:flutter/material.dart';

import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:expenses_app/widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Expenses App',
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.amber,
          visualDensity: VisualDensity.comfortable,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline5: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                  ),
                ),
          )),
      home: MyHomePage(title: 'Flutter Expenses Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'new shoes',
      amount: 45.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly groceries',
      amount: 15.99,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    final week = DateTime.now().subtract(Duration(days: 7));
    return _userTransactions.where((trx) {
      return trx.date.isAfter(week);
    }).toList();
  }

  void _addNewTransaction(
      String trxTitle, double trxAmount, DateTime chosenDate) {
    final newTrx = Transaction(
      title: trxTitle,
      amount: trxAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTrx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((i) => i.id == id);
    });
  }

  void _openModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () => _openModal(context),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Column(
          children: [
            Chart(_recentTransactions),
            Expanded(
              child: TransactionList(_userTransactions, _deleteTransaction),
            ), // This should not work but it works - maybe something is fixed
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openModal(context),
        tooltip: 'Add Transaction',
        child: Icon(Icons.add),
      ),
    );
  }
}
