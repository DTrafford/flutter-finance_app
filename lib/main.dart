import 'package:finance_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
// import './widgets/user_transactions.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spend Smart',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    // color: Colors.white,
                    fontSize: 20)),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: "New Shoes", amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: "Protein", amount: 39.99, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: date,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: null,
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      // centerTitle: false,
      title: Text(
        'Spend Smart',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => _startNewTransaction(context),
        )
      ],
      // backgroundColor: Colors.purple,
    );
    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  height: (MediaQuery.of(context).size.height -
                          _appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      .2,
                  child: Chart(_recentTransactions)),
              Container(
                height: (MediaQuery.of(context).size.height -
                        _appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    .7,
                child: TransactionList(
                    transactions: _userTransactions,
                    deleteTransaction: _deleteTransaction),
              ),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Colors.purple,
        child: Icon(Icons.add),
        onPressed: () => _startNewTransaction(context),
      ),
    );
  }
}
