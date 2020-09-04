import 'package:flutter/material.dart';
import 'package:note/models/Note.dart';
import 'package:note/providers/NotesProvider.dart';
import 'package:note/screens/Search.dart';
import 'package:note/screens/Workspace.dart';
import 'package:note/widgets/HomeNoteItem.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NotesProvider get provider {
    return Provider.of<NotesProvider>(context);
  }

  Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Notes',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
            child: Text(
              '${provider.notes.length} notes',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
          child: provider.notes.length > 0
              ? SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 30, top: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPage()));
                          },
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: Theme.of(context).unselectedWidgetColor,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 15),
                            itemCount: provider.notes.length,
                            itemBuilder: (context, index) {
                              return HomeNoteItem(note: provider.notes[index]);
                            }),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text(
                    'No notes yet',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey //.of(context).primaryColor,
                        ),
                  ),
                )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).buttonColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return WorkSpace();
            }),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.edit),
      ),
    );
  }
}
