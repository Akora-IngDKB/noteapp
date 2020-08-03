import 'package:flutter/material.dart';
import 'package:note/models/Note.dart';
import 'package:note/providers/NotesProvider.dart';
import 'package:provider/provider.dart';

class WorkSpace extends StatefulWidget {
  @override
  _WorkSpaceState createState() => _WorkSpaceState();
}

class _WorkSpaceState extends State<WorkSpace> {
  bool active = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();

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
                  onPressed: () {})),
          Tooltip(
              message: 'Delete',
              child: IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                  })),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Theme.of(context).buttonColor,
              child: Text(
                "SAVE",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
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
              controller: titleController,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                hintText: 'Title',
                hintStyle: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).primaryColor,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
            TextField(
              controller: textController,
              style: TextStyle(color: Theme.of(context).primaryColor),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                hintText: 'Type here',
                hintStyle: TextStyle(
                    fontSize: 20, color: Theme.of(context).primaryColor),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          items: [
            BottomNavigationBarItem(
              title: Text(''),
              icon: IconButton(
                  icon: Image(
                    width: 15,
                    image: AssetImage(
                      'images/bold.png',
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {}),
            ),
            BottomNavigationBarItem(
              title: Text(''),
              icon: IconButton(
                  icon: Image(
                    width: 15,
                    image: AssetImage(
                      'images/italic.png',
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {}),
            ),
            BottomNavigationBarItem(
              title: Text(''),
              icon: IconButton(
                  icon: Image(
                    width: 15,
                    image: AssetImage(
                      'images/underline.png',
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {}),
            ),
            BottomNavigationBarItem(
              title: Text(''),
              icon: IconButton(
                  icon: Image(
                    width: 20,
                    image: AssetImage(
                      'images/microphone.png',
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  color: active ? Colors.blue : Theme.of(context).primaryColor,
                  onPressed: () {
                    setState(() {
                      active = !active;
                    });
                  }),
            ),
          ]),
    );
  }
}
