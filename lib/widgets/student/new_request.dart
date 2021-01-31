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
                      "New Request",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    //when pressed, request is sent
                    IconButton(
                        icon: Icon(Icons.send),
                        color: Colors.blue,
                        onPressed: () {})
                  ],
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
  }
}
