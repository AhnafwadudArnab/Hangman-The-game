import 'package:flutter/material.dart';
import 'package:hangman/const/consts.dart';

Widget hiddenLetters(String char, bool visible) {
  return Container(
    alignment: Alignment.center,
    height: 50,
    width: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.white,
    ),
    child: Visibility(
      visible: !visible,
      child: Text(
        char,
        style: TextStyle(
         // fontWeight: FontWeight.bold,
          fontSize: 23,
          color: Appcolor.bgColor,
        ),
      ),
    ),
  );
}
