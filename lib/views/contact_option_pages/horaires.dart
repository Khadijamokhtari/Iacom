import 'package:flutter/material.dart';

class Horaires extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2,2),
                      blurRadius: 5,
                      spreadRadius: 1.0,
                      color: Color(0xFFB0CCE1).withOpacity(0.15),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(top: 20, left: 50, right: 50),
                padding: EdgeInsets.only(top: 10, left: 20, right: 15),
                child: Center(
                  child: Text("Du Lundi au Vendredi de 8h à 12h et de 14h à 18h", style: TextStyle(fontSize: 16, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w900),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}