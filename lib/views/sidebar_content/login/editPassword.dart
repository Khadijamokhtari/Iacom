import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:QRScanner/views/sidebar_content/login/mon_espace.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:QRScanner/views/sidebar_content/login/FadeAnimation.dart';

class EditPassword extends StatefulWidget {
  final String id, email, name, mobile, password;
  final VoidCallback signOut;
  EditPassword(this.id, this.email, this.name, this.mobile, this.password, this.signOut);
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  String id, name="", email="", mobile="", password="";
  final _key = new GlobalKey<FormState>();

  TextEditingController txtpassword, txtnewpassword, txtconfirmnewpassword;

  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  setup(){
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
    final response = await http.post("http://192.168.1.87/iacomappiuapp/editpassword.php", body: {
      "id": widget.id,
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
      password = preferences.getString("password");

    });
  }

  @override
  void initState(){
    super.initState();
    setup();
  }
  savePref(String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
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

                            Card(
                              elevation: 6.0,
                              margin: const EdgeInsets.only(right: 20, left: 25, bottom:10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: TextFormField(
                                controller: txtpassword,
                                validator: (e) {
                                  if (e.isEmpty) {
                                    return "Veuillez entrer votre mot de passe";
                                  }
                                  else if(e.length < 9){
                                    return "Votre mot de passe est invalide";
                                  }
                                  else if(widget.password != txtpassword.text){
                                    return "Entrer votre mot de passe actuel";
                                  }
                                },
                                obscureText: _secureText,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Champagne&LimousinesBold"
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Mot de passe",
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 20, right: 15),
                                    child: Icon(Icons.phonelink_lock,
                                        color: Colors.black),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: showHide,
                                    icon: Icon(_secureText
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                  ),
                                  contentPadding: EdgeInsets.all(18),
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
                                controller: txtnewpassword,
                                validator: (e) {
                                  if (e.isEmpty) {
                                    return "Veuillez entrer votre mot de passe";
                                  }
                                  else if(e.length < 9){
                                    return "Votre mot de passe est invalide";
                                  }
                                  else if(txtnewpassword.text != txtconfirmnewpassword.text){
                                    return "les mots de passe ne sont pas identiques!";
                                  }
                                },
                                obscureText: _secureText,

                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Champagne&LimousinesBold"
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Nouveau mot de passe",
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 20, right: 15),
                                    child: Icon(Icons.phonelink_lock,
                                        color: Colors.black),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: showHide,
                                    icon: Icon(_secureText
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                  ),
                                  contentPadding: EdgeInsets.all(18),
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
                                controller: txtconfirmnewpassword,
                                onSaved: (e) => password = e,
                                validator: (e) {
                                  if (e.isEmpty) {
                                    return "Veuillez entrer votre mot de passe";
                                  }
                                  else if(e.length < 9){
                                    return "Votre mot de passe est invalide";
                                  }
                                  else if(txtnewpassword.text != txtconfirmnewpassword.text){
                                    return "les mots de passe ne sont pas identiques!";
                                  }
                                },
                                obscureText: _secureText,

                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Champagne&LimousinesBold"
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Confirmer le nouveau mot de passe",
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 20, right: 15),
                                    child: Icon(Icons.phonelink_lock,
                                        color: Colors.black),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: showHide,
                                    icon: Icon(_secureText
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                  ),
                                  contentPadding: EdgeInsets.all(18),
                                ),
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
                                    savePref(password);

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