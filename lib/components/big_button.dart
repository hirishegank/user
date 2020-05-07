import 'package:flutter/material.dart';

import '../constants.dart';

class BigButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double fontsize;
  final Color bgColor;
  const BigButton(
      {@required this.text,
      this.onPressed,
      this.fontsize = 25,
      this.bgColor = kBigButtonColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: bgColor,
      minWidth: 200.0,
      elevation: 0,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 80.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: kBigButtonTextStyle.copyWith(fontSize: fontsize),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
}
