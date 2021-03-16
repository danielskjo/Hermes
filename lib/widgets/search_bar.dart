import 'package:flutter/material.dart';

import '../services/database.dart';

class SearchBar extends StatefulWidget {
  bool isSearching;
  TextEditingController searchField;
  Stream results;

  SearchBar(this.isSearching, this.searchField, this.results);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  onSearchButtonClicked() async {
    await DatabaseService()
        .getRequestsByTitle(widget.searchField.text)
        .then((value) {
      widget.results = value;
      setState(() {
        widget.isSearching = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          /// Only display arrow back icon when user is searching
          widget.isSearching
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.isSearching = false;
                      widget.searchField.text = "";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 12.0,
                    ),
                    child: Icon(Icons.arrow_back),
                  ),
                )
              : Container(),

          /// Textfield for searching for a user
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 16,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  /// Search by UserName textfield
                  Expanded(
                    child: TextField(
                      controller: widget.searchField,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search by username',
                      ),
                    ),
                  ),

                  /// Gesture Detection logic when search icon is tapped
                  IconButton(
                    onPressed: () async {
                      if (widget.searchField.text.isNotEmpty) {
                        onSearchButtonClicked();
                      } else {
                        /// TODO: Display snackbar notifying user to input text to search for a user
                        print('Textfield is empty');
                      }
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
