import 'package:csulb_dsc_2021/services/database.dart';
import 'package:flutter/material.dart';

class EditRequest extends StatefulWidget {
  static const routeName = '/edit-request';

  @override
  _EditRequestState createState() => _EditRequestState();
}

class _EditRequestState extends State<EditRequest> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.blue,
          title: Text(
            "Edit Request",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Colors.white // add custom icons also
                ),
            onPressed: () {
              // Add "Are you sure you want to discard changes?" Alert Dialog
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 26.0,
                ),
                onPressed: () {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(
                        'Are you sure?',
                      ),
                      content: Text(
                        'Do you want to delete this request?',
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            'No',
                          ),
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                        ),
                        FlatButton(
                          child: Text(
                            'Yes',
                          ),
                          onPressed: () {
                            DatabaseService().deleteRequestData(
                                ModalRoute.of(context).settings.arguments
                                    as String);

                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 26.0,
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.blue,
                            // backgroundImage: NetworkImage(),
                            // backgroundColor: Colors.transparent,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Username",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Title",
                        ),
                        controller: _titleController,
                        validator: (val) =>
                            val.isEmpty ? 'Please enter a title' : null,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: TextFormField(
                        decoration:
                            InputDecoration.collapsed(hintText: "Description"),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        controller: _descController,
                        validator: (val) =>
                            val.isEmpty ? 'Please enter a description' : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
