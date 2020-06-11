import 'package:flutter/material.dart';
import 'package:note/widgets/HomeNoteitem.dart';

import 'Workspace.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Text(
                      'Notes',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                 Padding(
                   padding: const EdgeInsets.only(right: 15.0),
                   child: Text('10 notes'),
                 ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 30),
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
              SizedBox(height: 10,),
              Container(
                height: 600,
                child: GridView.builder(
                  primary: false,
                  shrinkWrap: false,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return HomeNoteItem();
                  },
                ),
              ),
            ],
          ),
        ),
        // child: Column(

        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[

        //   ],
        // ),
      ),
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
        child: Icon(Icons.add),
      ),
    );
  }
}
