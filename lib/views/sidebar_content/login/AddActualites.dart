import 'package:flutter/material.dart';
import 'package:QRScanner/views/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:QRScanner/views/sidebar_content/login/FadeAnimation.dart';

class AddActualites extends StatefulWidget {
  @override
  _AddActualitesState createState() => _AddActualitesState();
}

class _AddActualitesState extends State<AddActualites> {
  String titre, act, description,morelink,moreTextlink;
  final _key = new GlobalKey<FormState>();
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }



  /*sentToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.pink,
        textColor: Colors.white);
  }*/

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      //sendOTP();
    }
  }
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.pink),
      home: SingleChildScrollView(
        child: Container(
          height: data.size.height,
          color: Colors.pink,
          child: Center(
            child: ListView(
              //shrinkWrap: true,
              //padding: EdgeInsets.all(15.0),
              children: <Widget>[
                Center(
                  child: Container(
                    //padding: const EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Form(
                      key: _key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 300,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/background.png'),
                                    fit: BoxFit.fill)),
                            child: Stack(children: <Widget>[
                              Positioned(
                                child: FadeAnimation(
                                    1.6,
                                    Container(
                                      //margin: EdgeInsets.only(top: 70),
                                      height: 200,
                                      child: Center(
                                        child: Text(
                                          "IΛCOM",
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 40,
                                              fontFamily:
                                              "Champagne&LimousinesBold",
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    )),
                              ),
                              Positioned(
                                child: FadeAnimation(
                                    1.6,
                                    Container(
                                      //margin: EdgeInsets.only(top: 70),
                                      //height: 300,
                                      child: Center(
                                        child: Text(
                                          "Expert en stratégie digitale",
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 12,
                                              fontFamily:
                                              "Champagne&LimousinesBold",
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    )),
                              )
                            ]),
                          ),

                          SizedBox(
                            height: 25,
                          ),

                          //card for Fullname TextFormField
                          Card(
                            margin: const EdgeInsets.only(
                                right: 20, left: 25, bottom: 10),
                            elevation: 6.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: TextFormField(
                              /*validator: (e) {
                                if (e.isEmpty) {
                                  return "Veuillez entrer votre nom et prénom";
                                }
                              },*/
                              //onSaved: (e) => name = e,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Champagne&LimousinesBold"),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding:
                                    EdgeInsets.only(left: 20, right: 15),
                                    child:
                                    Icon(Icons.person, color: Colors.black),
                                  ),
                                  contentPadding: EdgeInsets.all(18),
                                  labelText: "titre d'actualités"),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.only(
                                right: 20, left: 25, bottom: 10),
                            elevation: 6.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: TextFormField(
                              /*validator: (e) {
                                if (e.isEmpty) {
                                  return "Veuillez entrer votre nom et prénom";
                                }
                              },*/
                              //onSaved: (e) => name = e,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Champagne&LimousinesBold"),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding:
                                    EdgeInsets.only(left: 20, right: 15),
                                    child:
                                    Icon(Icons.person, color: Colors.black),
                                  ),
                                  contentPadding: EdgeInsets.all(18),
                                  labelText: "description d'actualités"),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.only(
                                right: 20, left: 25, bottom: 10),
                            elevation: 6.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: TextFormField(
                              /*validator: (e) {
                                if (e.isEmpty) {
                                  return "Veuillez entrer votre nom et prénom";
                                }
                              },*/
                              //onSaved: (e) => name = e,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Champagne&LimousinesBold"),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding:
                                    EdgeInsets.only(left: 20, right: 15),
                                    child:
                                    Icon(Icons.person, color: Colors.black),
                                  ),
                                  contentPadding: EdgeInsets.all(18),
                                  labelText: "image d'actualités"),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.only(
                                right: 20, left: 25, bottom: 10),
                            elevation: 6.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: TextFormField(
                              /*validator: (e) {
                                if (e.isEmpty) {
                                  return "Veuillez entrer votre nom et prénom";
                                }
                              },*/
                              //onSaved: (e) => name = e,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Champagne&LimousinesBold"),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding:
                                    EdgeInsets.only(left: 20, right: 15),
                                    child:
                                    Icon(Icons.person, color: Colors.black),
                                  ),
                                  contentPadding: EdgeInsets.all(18),
                                  labelText: "morelink"),
                            ),
                          ),

                          //card for Email TextFormField


                          Padding(
                            padding: EdgeInsets.all(12.0),
                          ),

                          SizedBox(
                            height: 44.0,
                            width: 250,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Text(
                                  "Publier",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Champagne&LimousinesBold",
                                      color: Colors.white),
                                ),
                                textColor: Colors.white,
                                color: Colors.pink,
                                onPressed: () {
                                  //showNotification();
                                  check();
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),



                          SizedBox(
                            height: 44,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}



