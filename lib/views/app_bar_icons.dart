import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar homeAppBarIcon(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false, // Don't show the leading button
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(icon: Icon(Icons.keyboard_backspace), iconSize: 30, color: Colors.pink,  onPressed:(){Navigator.pop(context);}),
        SizedBox(width: 80,),
        Text(
          "IΛCOM",
          style: TextStyle(fontSize: 30, fontFamily: "Champagne&LimousinesBold", color: Colors.pink, fontWeight: FontWeight.w900),
        ),
      ],
    ),
  );
}