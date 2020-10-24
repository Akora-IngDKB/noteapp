import 'package:flutter/material.dart';
import 'package:note/screens/home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration(seconds: 1),
      () {
        setState(() {
          visible = true;
        });
        Future.delayed(
            Duration(
              seconds: 5,
            ), () {
          setState(() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) {
                return MyHomePage();
              }),
            );
          });
        });
      },
    );
  }

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: AnimatedOpacity(
          curve: Curves.linear,
          opacity: visible ? 1 : 0,
          duration: Duration(seconds: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  'images/notes_icon.png',
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  text: "My",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).primaryColor),
                  children: [
                    TextSpan(
                      text: "Note",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
