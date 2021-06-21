import 'package:flutter/material.dart';
import 'package:QRScanner/views/informations/InfoList.dart';
import 'package:QRScanner/services/actualite_list_screen.dart';
import 'bloc.navigation_bloc/navigation_bloc.dart';
import 'package:QRScanner/services/service_list_screen.dart';
import 'package:QRScanner/views/app_bar.dart';
import 'package:QRScanner/views/carousel_slider/main_carousel_slider.dart';

class Body extends StatelessWidget with NavigationStates{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IACOM',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
        home: Scaffold(

      appBar: homeAppBar(context),
      body: Container(
        height: 700,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 5),
              Container(height: 180, margin: const EdgeInsets.only(left: 5), child: CarouselDemo()),
              //Container(child: Image.asset("image/AppBar.png")),
              Container(child: InfoList()),
              Container(child: Text("Nos services",
                style: TextStyle(fontSize: 20, fontFamily: "Champagne&LimousinesBold", color: Colors.pink, fontWeight: FontWeight.w900),
              )),
              //Container(child: NosServices()),
              Container(height: 170, child: ServiceScreen()),
              Container(child: Text("Dérnières infos",
                style: TextStyle(fontSize: 20, fontFamily: "Champagne&LimousinesBold", color: Colors.pink, fontWeight: FontWeight.w900),
              )),
              Container(height: 350, child: ActualiteListScreen(),),
              //News(),
            ],
        ),
      ),
      ),),
    );
  }
}