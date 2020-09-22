import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note/models/Note.dart';

class Options extends StatelessWidget {
  final Note note;

  Options({this.note});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      height: MediaQuery.of(context).size.height / 3.5,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(color: Theme.of(context).disabledColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 5,
            width: 50,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                ),
                SizedBox(width: 15),
                Text(
                  'Share',
                  style: TextStyle(),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              final data = ClipboardData(
                text: '${note.title.toString()}\n ${note.text.toString()}',
              );
              Clipboard.setData(data);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Copy To ClipBoard',
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
