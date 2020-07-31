import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList({this.transactions, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: MediaQuery.of(context).size.height * .6,
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'No transactions found',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : ListView.builder(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                itemBuilder: (ctx, index) {
                  return Card(
                      margin: EdgeInsets.all(5),
                      elevation: 5,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: FittedBox(
                                child: Text('\$${transactions[index].amount}')),
                          ),
                        ),
                        title: Text(
                          transactions[index].title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle: Text(DateFormat.yMMMEd()
                            .format(transactions[index].date)),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                        ),
                      ));
                },
                itemCount: transactions.length,
              ));
  }
}
