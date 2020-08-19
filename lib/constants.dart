import 'package:flutter/material.dart';

InputDecoration kTextFieldDecoration = InputDecoration(
  //  labelText: 'PASSWORD',
  errorStyle: TextStyle(color: Colors.red),
  focusedErrorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
    ),
  ),
  labelStyle: TextStyle(
    fontWeight: FontWeight.bold,
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
  ),
);

TextStyle kTextStyle = TextStyle(color: Colors.black);

final Color kPrimaryColor = Color(0xff136a8a);
final Color kSecondaryColor = Color(0xff267871);

final List<Color> kAuthGradient = [
  Color(0xff136a8a),
  Color(0xff267871),
];

InputDecoration kAddProductInputDecoration = InputDecoration(
  hintText: 'Ex:- Mango',
  filled: true,
  fillColor: Colors.grey[200],
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(20),
  ),
);

TextStyle kAddProductTextStyle = TextStyle(
  fontSize: 18,
);
