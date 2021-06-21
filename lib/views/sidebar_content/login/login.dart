import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:QRScanner/views/app_bar.dart';
import 'package:QRScanner/views/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:QRScanner/views/sidebar_content/login/sharedloginregister.dart';

class RegisterLogin extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.pink
      ),
      home: SingleChildScrollView(
        child: Container(height: data.size.height,
            child:Login()
        ),
      )
    );
  }
}