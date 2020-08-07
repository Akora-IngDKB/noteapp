import 'package:flutter/material.dart';
import 'package:note/models/Note.dart';
import 'package:note/providers/NotesProvider.dart';
import 'package:provider/provider.dart';

class WorkSpace extends StatefulWidget {
  final Note existingNote;

  WorkSpace({this.existingNote});

  @override
  _WorkSpaceState createState() => _WorkSpaceState();
}

class _WorkSpaceState extends State<WorkSpace> {
  bool isBold = false;
  bool isItalic = false;
  bool isUnderlined = false;
  Note note = Note();

  @override
  void initState() {
    if (widget.existingNote != null) note = widget.existingNote;
    super.initState();
  }

  NotesProvider get provider {
    return Provider.of<NotesProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Tooltip(
            message: 'Pick color',
            child: IconButton(
                icon: Image(
                  width: 20,
                  image: AssetImage('images/color-wheel.png'),
                ),
                color: Colors.black,
                onPressed: () {}),
          ),
          Tooltip(
            message: 'Delete',
            child: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  provider.deleteNote(note);
                  Navigator.pop(context);
                }),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: Theme.of(context).buttonColor,
              child: Text(
                "SAVE",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                // note.title = titleController.text;
                // note.text = textController.text;
                if (widget.existingNote != null) {
                  provider.update(widget.existingNote, note);
                } else {
                  provider.addNote(note);
                }
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (val) {
                note.title = val;
              },
              controller: TextEditingController(text: note.title),
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                hintText: 'Title',
                hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
            TextField(
              onChanged: (val) {
                note.text = val;
              },
              controller: TextEditingController(text: note.text),
              style: TextStyle(color: Theme.of(context).primaryColor),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                hintText: 'Type here',
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 50,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isBold ? Colors.blue : Colors.white,
              ),
              child: IconButton(
                  icon: Image(
                    width: 15,
                    image: AssetImage(
                      'images/bold.png',
                    ),
                    color:
                        isBold ? Colors.white : Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      isBold = !isBold;
                    });
                  }),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isItalic ? Colors.blue : Colors.white,
              ),
              child: IconButton(
                  icon: Image(
                    width: 15,
                    image: AssetImage(
                      'images/italic.png',
                    ),
                    color: isItalic
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    setState(() {
                      isItalic = !isItalic;
                    });
                  }),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isUnderlined ? Colors.blue : Colors.white,
              ),
              child: IconButton(
                  icon: Image(
                    width: 15,
                    image: AssetImage(
                      'images/underline.png',
                    ),
                    color: isUnderlined
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    setState(() {
                      isUnderlined = !isUnderlined;
                    });
                  }),
            ),
            IconButton(
                icon: Image(
                  width: 20,
                  image: AssetImage(
                    'images/microphone.png',
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
