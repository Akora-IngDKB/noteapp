import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:note/providers/NotesProvider.dart';
import 'package:note/screens/Splash.dart';
import 'package:note/services/sl.dart';

void main() async {
  //setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyNote',
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.white,
          buttonColor: Color.fromRGBO(112, 237, 238, 5),
          unselectedWidgetColor: Color.fromRGBO(46, 46, 46, 6),
          disabledColor: Color.fromRGBO(182, 182, 182, 50),
          brightness: Brightness.light,
        ),
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.black,
          unselectedWidgetColor: Color.fromRGBO(235, 235, 235, 6),
          buttonColor: Colors.lightBlueAccent,
          disabledColor: Colors.grey.shade300,
        ),
        home: Splash(),
      ),
    );
  }
}
