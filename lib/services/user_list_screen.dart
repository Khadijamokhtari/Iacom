import 'package:flutter/material.dart';
import 'package:QRScanner/models/user.dart';
import 'package:QRScanner/services/user_details_screen.dart';
import 'package:QRScanner/services/user-api.dart';
import 'package:QRScanner/views/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatelessWidget with NavigationStates{


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //padding: EdgeInsets.only(left: 10, right: 50),
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 150,
        width: 350,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: fetchUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index) {
                        User user = snapshot.data[index];
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
                                MaterialPageRoute(builder: (context) => UserDetailsScreen(user)),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 5),
                                Flexible(
                                  child:SizedBox(
                                    height: 90,
                                    width: 200,
                                    child:Container(
                                      padding: new EdgeInsets.only(right: 5.0, left:5),
                                      child: Align(
                                        alignment: Alignment.center,child: Text('${user.Name}', style: TextStyle(fontSize: 12, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w900),textAlign: TextAlign.center,),),),),),
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