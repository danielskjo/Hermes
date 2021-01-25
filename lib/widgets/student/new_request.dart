import 'package:flutter/material.dart';

class NewRequest extends StatefulWidget {
  final Function createNewRequest;

  NewRequest(this.createNewRequest);

  @override
  _NewRequestState createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredDesc = _descController.text;

    if (enteredTitle.isEmpty || enteredDesc.isEmpty) {
      return;
    }

    widget.createNewRequest(enteredTitle, enteredDesc, DateTime.now());

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title (Required)'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Description (Required)'),
                controller: _descController,
                onSubmitted: (_) => _submitData(),
              ),
              RaisedButton(
                child: Text('Make Request'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
