import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) return;
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop(); // close the topmost item
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        _selectedDate = pickedDate;
      });
    }); // execute this function once this future (return type) holds a value
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(), // i accept it but i dont plan on using the argument.
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null ? 'No Date Chosen!' : 'Picked Date: ${DateFormat.yMd().format(_selectedDate as DateTime)}',
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    onPressed: _presentDatePicker,
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              // style: TextButton.styleFrom(
              // primary: Theme.of(context).primaryColor,
              // textStyle:
              // ),
              child: const Text('Add Transaction'),
            )
          ],
        ),
      ),
    );
  }
}
