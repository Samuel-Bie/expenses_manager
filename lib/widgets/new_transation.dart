import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) return;
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);
    final date = _selectedDate;

    if (amount <= 0 || title.isEmpty || date == null) return;

    this.widget.addTransaction(title, amount, date);
    Navigator.pop(context);
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              onSubmitted: (_) => this._submitData(),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => this._submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date choosens'
                          : 'Date picked ${DateFormat.yMd().format(this._selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    onPressed: _showDatePicker,
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: _submitData,
              child: Text(
                'Add',
                style:
                    TextStyle(color: Theme.of(context).textTheme.button.color),
              ),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
