import 'package:flutter/material.dart';
import '../../models/request.dart';

class RequestFunction extends StatefulWidget {
  final Function requestFunction;
  final Request request;
  int index;
  bool isNewRequest;

  RequestFunction.edit(this.requestFunction, this.request, this.index) {this.isNewRequest = false;}
  RequestFunction.create(this.requestFunction, this.request) {this.index = 0; this.isNewRequest = true;}

  @override
  _RequestFunctionState createState() => _RequestFunctionState();
}

class _RequestFunctionState extends State<RequestFunction> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String requestTitle;

  @override
  void initState() {
    if (widget.isNewRequest == false) {
      requestTitle = "Edit Request";
      _titleController.text = widget.request.title;
      _descController.text = widget.request.desc;
    }
    else {
      requestTitle = "New Request";
    }
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredDesc = _descController.text;

    if (enteredTitle.isEmpty || enteredDesc.isEmpty) {
      _inputError();
      return;
    }

    widget.requestFunction(enteredTitle, enteredDesc, DateTime.now(), widget.index, widget.isNewRequest);

    Navigator.of(context).pop();
  }

  void _inputError() {
    String message;

    if (_titleController.text.isEmpty && _descController.text.isEmpty) {
      message = "You must enter both a title and a description";
    }
    else if (_titleController.text.isEmpty) {
      message = "You must enter a title";
    }
    else {
      message = "You must enter a description";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => _buildPopupDialog(context, message),
    );
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
                    Row(
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
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            requestTitle,
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    //when pressed, request is sent
                    IconButton(
                      icon: Icon(Icons.send),
                      color: Colors.blue,
                      onPressed: () {
                        _submitData();
                      }
                    ),
                  ],
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Title',
                    ),
                    controller: _titleController,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: 'Description',
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
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

  Widget _buildPopupDialog(BuildContext context, String message) {
  return new AlertDialog(
    title: const Text('Error'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(message),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('OK'),
      ),
    ],
  );
}
}
