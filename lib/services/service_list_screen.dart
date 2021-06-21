import 'package:flutter/material.dart';
import 'package:QRScanner/models/service.dart';
import 'package:QRScanner/services/service_details_screen.dart';
import 'package:QRScanner/services/service-api.dart';
import 'package:QRScanner/views/bloc.navigation_bloc/navigation_bloc.dart';

class ServiceScreen extends StatelessWidget with NavigationStates{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 10, right: 10),
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 150,
        width: 400,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: FutureBuilder(
                  future: fetchService(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            Service service = snapshot.data[index];
                            return Container(
                              width: 200,
                              margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(2,2),
                                    blurRadius: 5,
                                    spreadRadius: 1.0,
                                    color: Color(0xFFB0CCE1).withOpacity(0.32),
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ServiceDetailsScreen(service)),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[

                                 ClipRRect(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),),
                                        child: Image.network('https://iacomapps.fr/data/fr.iacom.apps/drawable/${service.image_art}', height: 100, fit: BoxFit.cover, width: 200,),
                                    ),
                                    SizedBox(height: 5),
                            Flexible(
                            child:SizedBox(
                              height: 90,
                              width: 200,
                              child:Container(
                                padding: new EdgeInsets.only(right: 5.0, left:5),
                                child: Align(
                            alignment: Alignment.center,child: Text('${service.nom_art}', style: TextStyle(fontSize: 12, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w900),textAlign: TextAlign.center,),),),),),
                                    //Container(child: Text('${service.sous_titre}', style: TextStyle(fontSize: 10, fontFamily: "Champagne&LimousinesBold", color: Colors.black),),),
                                  ],
                                ),
                              ),
                            );
                          },
                      );
                    }
                    return SizedBox(
                        height: 16,
                        width: 16,
                      child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.pink), strokeWidth:5,),);
                    },
                ),
              ),
            ],
          ),
      ),
    );
  }
}