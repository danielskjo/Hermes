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
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.blue,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Title (Required)'),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                ),
                SizedBox(height: 20),
                Container(
                  child: TextField(
                    maxLines: 14,
                    decoration: InputDecoration(
                      hintText: "Description...",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    /*SingleChildScrollView(
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
    );*/
  }
}
