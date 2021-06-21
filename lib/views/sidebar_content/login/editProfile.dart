import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:QRScanner/views/sidebar_content/login/mon_espace.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:QRScanner/views/sidebar_content/login/FadeAnimation.dart';

class Edit extends StatefulWidget {
  final String id, email, name, mobile, password;
  final VoidCallback signOut;
  Edit(this.id, this.email, this.name, this.mobile, this.password, this.signOut);
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  String id, name="", email="", mobile="", password="";
  final _key = new GlobalKey<FormState>();

  TextEditingController txtname, txtmobile, txtpassword, txtnewpassword, txtconfirmnewpassword;

  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  setup(){
    txtname = TextEditingController(text: widget.name);
    txtmobile = TextEditingController(text: widget.mobile);
    txtpassword = TextEditingController();
    txtnewpassword = TextEditingController();
    txtconfirmnewpassword = TextEditingController();
  }

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    }
  }

  submit() async {
    final response = await http.post("http://192.168.1.87/iacomappiuapp/edit.php", body: {
      "id": widget.id,
      "name": name,
      "mobile": mobile,
      "password": password,
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      print(message);
      editToast(message);
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => MonEspace(signOut, name, email, mobile, password)),
      );
    } else {
      print(message);
      editToast(message);
    }
  }
  editToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.pink,
        textColor: Colors.white);
  }
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.reload();
      name = preferences.getString("name");
      mobile = preferences.getString("mobile");
      password = preferences.getString("password");

    });
  }

  @override
  void initState(){
    super.initState();
    setup();
  }
  savePref(String name, String mobile, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("name", name);
      preferences.setString("mobile", mobile);
      preferences.setString("password", password);
      preferences.commit();
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.pink
        ),
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
                                      image: AssetImage('assets/images/background.png'),
                                      fit: BoxFit.fill
                                  )
                              ),
                              child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      child: FadeAnimation(1.6, Container(
                                        //margin: EdgeInsets.only(top: 70),
                                        height: 200,
                                        child: Center(
                                          child: Text("IΛCOM",
                                            style: TextStyle(decoration: TextDecoration.none, fontSize: 40, fontFamily: "Champagne&LimousinesBold", color: Colors.white, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      )
                                      ),
                                    ),
                                    Positioned(
                                      child: FadeAnimation(1.6,
                                          Container(
                                            //margin: EdgeInsets.only(top: 70),
                                            //height: 300,
                                            child: Center(
                                              child: Text("Expert en stratégie digitale",
                                                style: TextStyle(decoration: TextDecoration.none, fontSize: 12, fontFamily: "Champagne&LimousinesBold", color: Colors.white, fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          )),
                                    )
                                  ]
                              ),
                            ),

                            SizedBox(
                              height: 25,
                            ),

                            //card for Fullname TextFormField
                            Card(
                              margin: const EdgeInsets.only(right: 20, left: 25, bottom:10),
                              elevation: 6.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: TextFormField(
                                controller: txtname,
                                onSaved: (e) => name = e,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Champagne&LimousinesBold"
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(left: 20, right: 15),
                                      child: Icon(Icons.person, color: Colors.black),
                                    ),
                                    contentPadding: EdgeInsets.all(18),
                                    labelText: "Nom et Prénom"
                                 ),
                              ),
                            ),

                            Card(
                              elevation: 6.0,
                              margin: const EdgeInsets.only(right: 20, left: 25, bottom:10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: TextFormField(
                                controller: txtmobile,
                                validator: (e) {
                                  if (e.isEmpty) {
                                    return "Veuillez entrer votre numéro de téléphone";
                                  }
                                  else if(e.length < 10){
                                    return "Votre numéro de téléphone est invalide";
                                  }
                                },
                                onSaved: (e) => mobile = e,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Champagne&LimousinesBold"
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 20, right: 15),
                                    child: Icon(Icons.phone, color: Colors.black),
                                  ),
                                  contentPadding: EdgeInsets.all(18),
                                  labelText: "Numéro de téléphone",
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                            ),

                            SizedBox(
                              height: 44.0,
                              width: 250,
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15.0)),
                                  child: Text(
                                    "Confirmer",
                                    style: TextStyle(fontSize: 15, fontFamily: "Champagne&LimousinesBold", color: Colors.white),
                                  ),
                                  textColor: Colors.white,
                                  color: Colors.pink,
                                  onPressed: () {
                                    check();
                                    savePref(name, mobile, password);

                                    //name = txtname.text.toString();
                                    print(name);
                                    print(mobile);
                                    print(password);

                                  }),
                            ),
                            SizedBox(
                              height: data.size.height/3,
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