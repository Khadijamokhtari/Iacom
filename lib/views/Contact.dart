import 'package:QRScanner/views/MyHomePage.dart';
import 'package:QRScanner/views/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bloc.navigation_bloc/navigation_bloc.dart';
import 'package:QRScanner/views/contact_option_pages/a_propos.dart';
import 'package:QRScanner/views/contact_option_pages/horaires.dart';
import 'package:QRScanner/views/contact_option_pages/gps.dart';

class Contact extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              elevation: 5,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.keyboard_backspace), iconSize: 30, color: Colors.pink,
                      onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()),);
                    }
                  ),
                  SizedBox(width: 80,),
                  Text(
                    "IΛCOM",
                    style: TextStyle(fontSize: 30, fontFamily: "Champagne&LimousinesBold", color: Colors.pink, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size(100,50),
                child: Container(
                  width: 318,
                  child: TabBar(
                      indicatorColor: Colors.pink,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: <Widget>[
                        Tab(child: Align(
                            alignment: Alignment.center,
                            child: Text("A PROPOS",
                              style: TextStyle(fontSize: 12, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w900),)),
                        ),
                        Tab(child: Align(
                            alignment: Alignment.center,
                            child: Text("HORAIRES",
                              style: TextStyle(fontSize: 12, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w900),)),
                        ),
                        Tab(child: Container(
                            width:180,

                            child: Text("PLAN D'ACCES",
                              style: TextStyle(fontSize: 12, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w900),)),
                        ),
                      ]
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Propos(),
                Horaires(),
                PlanAcces(),
              ],
            ),
          ),
          length: 3,
          initialIndex: 0,
        ),
    );
  }
}