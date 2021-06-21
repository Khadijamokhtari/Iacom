import 'dart:async';
import 'package:flutter/material.dart';
import 'package:QRScanner/views/MyHomePage.dart';
import 'package:QRScanner/views/Loader.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'IACOM',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}
class SplashState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  startTime() async {
    var duration = new Duration(seconds: 4);
    return new Timer(duration, route);
  }
  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => MyHomePage()
    )
    );
  }
  initScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("image/logo.png"),
                  fit: BoxFit.cover)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Text(
                'Expert en stratégie digitale',
                style: TextStyle(color: Colors.white, fontSize: 11,fontStyle: FontStyle.normal),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Container(child: Loader(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

