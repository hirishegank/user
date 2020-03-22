import 'package:flutter/material.dart';
import 'package:user/screens/walkthrough.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.green,
          textTheme: TextTheme(
              body1: TextStyle(
            fontFamily: 'Muli',
            fontSize: 20.0,
            color: Colors.black,
          )),
          appBarTheme: AppBarTheme(
              color: Colors.white,
              textTheme: TextTheme(
                  title: TextStyle(
                fontFamily: 'Muli',
                color: Colors.black,
                fontSize: 20.0,
              )))),
      home: Walkthrough(),
    );
  }
}
