import 'package:flutter/material.dart';
import 'package:QRScanner/views/informations/launchBrowser.dart';

class InfoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Container(
        margin: EdgeInsets.only(left: 20, right: 15, top: 5, bottom: 4),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2,2),
                    blurRadius: 5,
                    spreadRadius: 1.0,
                    color: Color(0xFFB0CCE1).withOpacity(0.15),
                  ),
                ],),
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.white,onPressed: () =>makeCall('tel:+33970445545'),
                child: Text('Appeler', style: TextStyle(fontSize: 15, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w900),),
          ),

              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2,2),
                      blurRadius: 5,
                      spreadRadius: 1.0,
                      color: Color(0xFFB0CCE1).withOpacity(0.15),
                    ),
                  ],),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,onPressed: () => makeMail("mailto:info@iacom.fr"),
                  child: Text('Email', style: TextStyle(fontSize: 15, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w900),),
                ),

              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2,2),
                      blurRadius: 5,
                      spreadRadius: 1.0,
                      color: Color(0xFFB0CCE1).withOpacity(0.15),
                    ),
                  ],),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,onPressed: () => launchBrowser('https://www.iacom.fr'),
                  child: Text('Site Web', style: TextStyle(fontSize: 15, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w900),),
                ),

              ),

            ]

        )

    );
  }
}