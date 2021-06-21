import 'package:flutter/material.dart';
import 'package:QRScanner/views/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:QRScanner/views/sidebar/sidebar_layout.dart';
import 'package:QRScanner/views/app_bar.dart';
import 'package:QRScanner/views/body.dart';
import '../actualite_details_screen.dart';

class MyHomePage extends StatelessWidget with NavigationStates {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IACOM App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SideBarLayout(),
    );
  }
}

class MyAcceuil extends StatelessWidget with NavigationStates {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                Container(child: SideBarLayout()),
              ]
          ),
        ),
      ),
    );
  }
}