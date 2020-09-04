import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                disabledBorder: InputBorder.none,
                filled: true,
                fillColor: Theme.of(context).unselectedWidgetColor,
                contentPadding: EdgeInsets.only(left: 20),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.search, color: Colors.grey, size: 15),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Search notes',
                hintStyle: TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
