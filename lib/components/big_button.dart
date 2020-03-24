import 'package:flutter/material.dart';

import '../constants.dart';

class BigButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double fontsize;
  const BigButton({@required this.text, this.onPressed, this.fontsize = 25});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: kBigButtonColor,
      minWidth: 200.0,
      elevation: 0,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 100.0),
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
