import 'dart:async';

import 'package:flutter/material.dart';
import 'package:user/screens/profile_creation.dart';

class SuccessRegistrationPage extends StatefulWidget {
  final String phoneNo;
  const SuccessRegistrationPage({@required this.phoneNo});

  @override
  _SuccessRegistrationPageState createState() =>
      _SuccessRegistrationPageState();
}

class _SuccessRegistrationPageState extends State<SuccessRegistrationPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ProfilePage(
                phoneNo: widget.phoneNo,
              )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Center(
              child: Image.asset('assets/img/success.png'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Registered Successfully',
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    ));
  }
}
