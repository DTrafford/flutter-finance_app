import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final entredAmount = _amountController.text.isNotEmpty
        ? double.parse(_amountController.text)
        : 0;
    if (enteredTitle.isEmpty || entredAmount <= 0) {
      return;
    }
    widget.addTx(enteredTitle, entredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2018),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                autocorrect: true,
                controller: _titleController,
                // onChanged: (value) {
                //   titleInput = value;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                autocorrect: true,
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate != null
                          ? "Date: ${DateFormat.yMd().format(_selectedDate)}"
                          : 'No Date Chosen!'),
                    ),
                    FlatButton(
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _showDatePicker,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: _submitData,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ));
  }
}
