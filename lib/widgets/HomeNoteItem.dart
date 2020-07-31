import 'package:flutter/material.dart';
import 'package:note/models/Note.dart';

class HomeNoteItem extends StatelessWidget {
  final Note note;
  const HomeNoteItem({@required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).unselectedWidgetColor.withOpacity(0.3),
        border: Border.all(color: Theme.of(context).disabledColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            note.title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            note.text,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                height: 1.2,
                fontSize: 13),
          ),
        ],
      ),
    );
  }
}
