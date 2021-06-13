import 'package:flutter/material.dart';
import 'package:infomusic2/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "INFOMUSIC",
      theme: ThemeData(
        primaryColor: Color(0xFF7476f7),
        accentColor: Color(0xFF74b7f7),
        //scaffoldBackgroundColor: Colors.grey[900],
        fontFamily: 'Roboto',
        // primaryTextTheme: TextTheme(
        //   bodyText1: TextStyle(color: Colors.white), 
        //   bodyText2: TextStyle(color: Colors.white), 
        // ),
      ),
      home: Home(),
    );
  }
}