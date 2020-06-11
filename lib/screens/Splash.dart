import 'package:flutter/material.dart';
import 'package:note/screens/home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double endSize = 2.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() => endSize = 1000);
      Future.delayed(Duration(milliseconds: 300), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        alignment: Alignment.center,
        child: TweenAnimationBuilder(
          curve: Curves.ease,
          tween: Tween<double>(begin: 2, end: endSize),
          duration: Duration(milliseconds: 1500),
          builder: (context, size, child) {
            return Transform.scale(scale: size, child: child);
          },
          child: Text.rich(
            TextSpan(
              text: "My",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor),
              children: [
                TextSpan(
                  text: "Note",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
