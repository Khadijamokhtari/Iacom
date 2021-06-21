import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:QRScanner/views/sidebar_content/login/editProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:QRScanner/views/sidebar_content/login/FadeAnimation.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MonEspace extends StatefulWidget {
  final VoidCallback signOut;
  String name, email, mobile, password;
  MonEspace(this.signOut, this.name, this.email, this.mobile, this.password);
  @override
  _MonEspaceState createState() => _MonEspaceState();
}

class _MonEspaceState extends State<MonEspace> {
  final _key = new GlobalKey<FormState>();
  signOut() {
    setState(() {
      widget.signOut();
    });
  }
  int currentIndex = 0;
  String selectedIndex = 'TAB: 0';
  String email="", name="", id="", mobile="", password="";
  TabController tabController;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.reload();
      id = preferences.getString("id");
      email = preferences.getString("email");
      name = preferences.getString("name");
      password = preferences.getString("password");
      mobile = preferences.getString("mobile");

      print("id " + id);
      print("email " + email);
      print("name " + name);
      print("password " + password);
      print("mobile " + mobile);
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill
                          )
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              child: FadeAnimation(1.6,
                                Container(
                                  //margin: EdgeInsets.only(top: 70),
                                  height: 200,
                                  child: Center(
                                    child: Text("MON PROFILE",style: TextStyle(fontSize: 40, fontFamily: "Champagne&LimousinesBold", color: Colors.white, fontWeight: FontWeight.w500),),
                                  ),
                                )
                              ),
                            )
                          ]
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      QrImage(
                        data: email,
                        version: QrVersions.auto,
                        size: 250.0,
                        gapless: false,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 40,
                        width: 250,
                        child: Text(name,
                          style: TextStyle(fontSize: 16, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w400),
                        ),),
                      Container(
                        height: 40,
                        width: 250,
                        child: Text('$email', style: TextStyle(fontSize: 16, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w300),
                        ),),
                      Container(
                        height: 40,
                        width: 250,
                        child: Text('$mobile', style: TextStyle(fontSize: 16, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w300),),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        height: 44.0,

                        width: 250,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Text("Modifier profil", style: TextStyle(fontSize: 15, fontFamily: "Champagne&LimousinesBold", color: Colors.white),),
                          textColor: Colors.white,
                          color: Colors.pink,
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Edit(id, email, name, mobile, password,signOut)),
                            );
                          }
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}