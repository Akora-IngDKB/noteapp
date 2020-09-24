import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note/models/Note.dart';
import 'package:note/providers/NotesProvider.dart';
import 'package:note/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

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
  bool isRecording = false;
  Note note = Note();
  stt.SpeechToText _speech;
  Box<String> notesBox;

  @override
  void initState() {
    notesBox = Hive.box<String>('notes');
    //  _speech = stt.SpeechToText();
    if (widget.existingNote != null) note = widget.existingNote;
    super.initState();
  }

  NotesProvider get provider {
    return Provider.of<NotesProvider>(context, listen: false);
  }

  _showDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you want to delete this note?'),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('No'),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onPressed: () {
              provider.deleteNote(note);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  void record() async {
    if (!isRecording) {
      bool available = await _speech.initialize(
        onError: (val) => print('Sorry : $val'),
        onStatus: (val) => print('onstatus : $val'),
      );
      if (available) {
        setState(() => isRecording = true);
        _speech.listen(onResult: (val) {
          note.text = val.recognizedWords;
        });
      }
    } else {
      _speech.stop();
      setState(() {
        isRecording = false;
      });
    }
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
          // Tooltip(
          //   message: 'Pick color',
          //   child: IconButton(
          //     icon: Image(
          //       width: 20,
          //       image: AssetImage('images/color-wheel.png'),
          //     ),
          //     color: Colors.black,
          //     onPressed: () {},
          //   ),
          // ),
          Tooltip(
            message: 'Delete',
            child: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  _showDialog();
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
                "Save",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (note.text.isEmpty) {
                  return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('You can\'t save an empty note'),
                      actions: [
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    ),
                  );
                } else if (widget.existingNote != null) {
                  notesBox.put(note.title, note.text);
                  provider.update(widget.existingNote, note);
                } else {
                  notesBox.put(note.title, note.text);
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
              controller: TextEditingController(text: note.title.trim()),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 23,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                hintText: 'Title',
                hintStyle: TextStyle(
                  fontSize: 19,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
            TextField(
              onChanged: (val) {
                note.text = val;
              },
              controller: TextEditingController(text: note.text.trim()),
              style: TextStyle(
                fontSize: 17,
                // decoration: isUnderlined
                //     ? TextDecoration.underline
                //     : TextDecoration.none,
                // fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: Theme.of(context).primaryColor,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                hintText: 'Type here',
                hintStyle: TextStyle(
                  fontSize: 19,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
      //  bottomSheet: buildFormatButtons(context),
    );
  }

  Widget buildFormatButtons(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 5),
      height: 60,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isBold
                  ? Colors.blue
                  : Theme.of(context).scaffoldBackgroundColor,
            ),
            child: IconButton(
                icon: Image(
                  width: 15,
                  image: AssetImage(
                    'images/bold.png',
                  ),
                  color: isBold ? Colors.white : Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    isBold = !isBold;
                  });
                }),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isItalic
                  ? Colors.blue
                  : Theme.of(context).scaffoldBackgroundColor,
            ),
            child: IconButton(
                icon: Image(
                  width: 15,
                  image: AssetImage(
                    'images/italic.png',
                  ),
                  color:
                      isItalic ? Colors.white : Theme.of(context).primaryColor,
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  setState(() {
                    isItalic = !isItalic;
                  });
                }),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isUnderlined
                  ? Colors.blue
                  : Theme.of(context).scaffoldBackgroundColor,
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
          Container(
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isUnderlined
                  ? Colors.blue
                  : Theme.of(context).scaffoldBackgroundColor,
            ),
            child: IconButton(
                icon: Image(
                  width: 20,
                  image: AssetImage(
                    isRecording ? 'images/record.gif' : 'images/microphone.png',
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  record();
                }),
          ),
        ],
      ),
    );
  }
}
