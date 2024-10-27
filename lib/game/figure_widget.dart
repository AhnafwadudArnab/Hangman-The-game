import 'package:flutter/material.dart';

Widget figure(String path,bool visible){
  return SizedBox(
      height: 250,
      width: 250,
      child: Visibility(
      visible: visible,
          child:Image.asset(path)),

  );

}