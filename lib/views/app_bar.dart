import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar homeAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, // Don't show the leading button
        title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
      //IconButton(icon: Icon(Icons.menu), color: Colors.white),
          Text(
            "IΛCOM",
            style: TextStyle(fontSize: 30, fontFamily: "Champagne&LimousinesBold", color: Colors.pink, fontWeight: FontWeight.w900),
          ),
  ],
        ),
    );
}