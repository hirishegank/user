import 'package:flutter/material.dart';

class CategoryIconButton extends StatelessWidget {
  final String image;
  final String lable;
  final Function onTap;
  const CategoryIconButton({this.image, this.lable, this.onTap});

//only use inside row or column
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            Image.asset(image),
            SizedBox(
              height: 8,
            ),
            Text(
              lable,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
