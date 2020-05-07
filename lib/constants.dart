import 'package:flutter/material.dart';

const kBigButtonTextStyle = TextStyle(
    fontFamily: 'Muli',
    fontSize: 25.0,
    color: Colors.white,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.0);

const kBigButtonColor = Colors.green;

const kHomeInputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 2),
  ),
  hintText: 'Find a food or chef',
  hintStyle: TextStyle(fontFamily: 'Muli', fontSize: 20),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 3),
  ),
  prefixIcon: Padding(
    padding: const EdgeInsets.only(left: 5),
    child: Icon(
      Icons.search,
      size: 40,
      color: Colors.green,
    ),
  ),
  // suffixIcon: Icon(
  //   Icons.arrow_downward,
  //   size: 40,
  //   color: Colors.green,
  // ),
);
