import 'package:flutter/material.dart';
import '../../models/request.dart';

class EditRequest extends StatefulWidget {
  final Function editRequest;
  final Request request;
  final int index;

  EditRequest(this.editRequest, this.request, this.index);

  @override
  _EditRequestState createState() => _EditRequestState();
}

class _EditRequestState extends State<EditRequest> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String requestTitle = "";

  @override
  void initState() {
    _titleController.text = widget.request.title;
    _descController.text = widget.request.desc;
    if (widget.request.title == "") {
      requestTitle = "New Request";
    }
    else {
      requestTitle = "Edit Request";
    }
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredDesc = _descController.text;

    if (enteredTitle.isEmpty || enteredDesc.isEmpty) {
      return;
    }

    widget.editRequest(enteredTitle, enteredDesc, DateTime.now(), widget.index);

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                      requestTitle,
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    //when pressed, request is sent
                    IconButton(
                      icon: Icon(Icons.send),
                      color: Colors.blue,
                      onPressed: () => _submitData(),
                    ),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Title (Required)'),
                  controller: _titleController,
                ),
                SizedBox(height: 20),
                Container(
                  child: TextField(
                    maxLines: 14,
                    decoration: InputDecoration( hintText: "Description...",),
                    controller: _descController,
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
