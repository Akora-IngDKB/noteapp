import 'package:flutter/material.dart';
import 'package:note/models/Note.dart';

class HomeNoteItem extends StatefulWidget {
  final Note note;
  const HomeNoteItem({@required this.note});

  @override
  _HomeNoteItemState createState() => _HomeNoteItemState();
}

class _HomeNoteItemState extends State<HomeNoteItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).unselectedWidgetColor.withOpacity(0.3),
        border: Border.all(color: Theme.of(context).disabledColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.note.title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            widget.note.text,
            overflow: TextOverflow.ellipsis,
            maxLines: 6,
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
