import 'package:flutter/material.dart';
import 'bloc.navigation_bloc/navigation_bloc.dart';
import 'package:QRScanner/views/app_bar.dart';
import 'package:QRScanner/views/body.dart';
import 'sidebar/sidebar_layout.dart';

class MyHomePage extends StatelessWidget with NavigationStates {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IACOM App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
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
                  Container(child: Body()),
              ]
              ),
            ),
          ),
      );
  }
}