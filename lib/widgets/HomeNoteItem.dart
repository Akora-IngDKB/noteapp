import 'package:flutter/material.dart';
import 'package:note/models/Note.dart';

class HomeNoteItem extends StatelessWidget {
  final Note note;
  const HomeNoteItem({@required this.note});

  // String formatText(String t) {
  //   final chunks = t?.split("\n");
  //   int lines = chunks.length;
  //   if (lines < 5) return t;
  //   return chunks[0] +
  //       "\n" +
  //       chunks[1] +
  //       "\n" +
  //       chunks[2] +
  //       "\n" +
  //       chunks[3] +
  //       "...";
  // }

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
          //if ((note.title != null) && (note.title.isNotEmpty)) ...[
          Text(
            //"${note.title}",
            note.title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          // Divider(
          //   thickness: 1,
          //   indent: 2,
          //   endIndent: 2,
          //   color: Colors.grey,
          //),
          SizedBox(height: 10),
          //],
          //  if ((note.text != null) && (note.text.isNotEmpty)) ...[
          Text(
            //  "${formatText(note.text)}",
            // "Text tile is the best thing that ever happened to me aswertugahd bro " +
            //     "Text tile is the best thing that ever happened to me aswertugahd bro " +
            //     "Text tile is the best thing that ever ha" +
            //     " Title, tile is the best thing that ever happened to me...",
            note.text,

            style: TextStyle(
                color: Theme.of(context).primaryColor,
                height: 1.2,
                fontSize: 13),
          ),

          // ],
        ],
      ),
    );
  }
}
