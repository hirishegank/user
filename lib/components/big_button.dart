import 'package:flutter/material.dart';

import '../constants.dart';

class BigButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const BigButton({@required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: kBigButtonColor,
      minWidth: 200.0,
      elevation: 0,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 100.0),
      child: Text(text, style: kBigButtonTextStyle),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
}
