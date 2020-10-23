import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  bool isChanged = false;
  stt.SpeechToText _speech;

  @override
  void initState() {
    _speech = stt.SpeechToText();
    if (widget.existingNote != null) note = widget.existingNote;
    super.initState();
  }

  prompt(bool isSaved) {
    if (isSaved == null)
      return;
    else
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Exit without saving?'),
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ),
                  );
                },
                child: Text('Yes'),
              ),
            ],
          );
        },
      );
  }

  NotesProvider get provider {
    return Provider.of<NotesProvider>(context, listen: false);
  }

  Future<bool> _showDialog() async {
    return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Do you want to delete this note?'),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text('No'),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () {
                  provider.deleteNote(note);
                  Navigator.pop(context, true);
                },
                child: Text('Delete'),
              ),
            ],
          );
        });
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
          Tooltip(
            message: 'Delete',
            child: IconButton(
                disabledColor: Colors.grey,
                icon: Icon(CupertinoIcons.delete_solid),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (note.title.isNotEmpty || note.text.isNotEmpty) {
                    final delete = await _showDialog();
                    if (delete ?? false) Navigator.pop(context);
                  }
                }),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: Colors.blue,
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
                isChanged = !isChanged;
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
                isChanged = !isChanged;
              },
              controller: TextEditingController(text: note.text.trim()),
              style: TextStyle(
                fontSize: 17,
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
      floatingActionButton: FloatingActionButton(
        onPressed: record,
        child: Image.asset(
          isRecording ? 'images/record.gif' : 'images/microphone.png',
          color: Colors.white,
          width: 18,
        ),
      ),
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
                  image: AssetImage('images/italic.png'),
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
                  image: AssetImage('images/underline.png'),
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
