import 'dart:convert';
import 'package:QRScanner/views/sidebar_content/login/ScanQR.dart';
import 'package:QRScanner/views/sidebar_content/login/editPassword.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:QRScanner/views/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:QRScanner/views/sidebar_content/login/mon_espace.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:QRScanner/views/sidebar_content/login/FadeAnimation.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:QRScanner/views/sidebar_content/login/AddActualites.dart';

class Login extends StatefulWidget with NavigationStates {
  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginState extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email, name, mobile, password, status;
  final _key = new GlobalKey<FormState>();

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
      login();
    }
  }

  login() async {
    final response = await http
        .post("http://192.168.1.4/iacomappiuapp/api_verification.php", body: {
      "flag": 1.toString(),
      "email": email,
      "password": password,
      "fcm_token": "test_fcm_token",
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String emailAPI = data['email'];
    String nameAPI = data['name'];
    String mobileAPI = data['mobile'];
    String passwordAPI = data['password'];
    String id = data['id'];
    String statusAPI = data['status'];
    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, emailAPI, nameAPI, password, mobileAPI, id, statusAPI);
      });
      print(message);
      loginToast(message);
    } else {
      print("fail");
      print(message);
      loginToast(message);
    }
  }

  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.pink,
        textColor: Colors.white);
  }

  savePref(int value, String email, String name, String password, String mobile,
      String id, String status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("name", name);
      preferences.setString("mobile", mobile);
      preferences.setString("email", email);
      preferences.setString("password", password);
      preferences.setString("id", id);
      preferences.setString("status", status);
      preferences.commit();
    });
  }

  var value;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.setString("name", null);
      preferences.setString("email", null);
      preferences.setString("id", null);

      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return SingleChildScrollView(
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
                      //color: Colors.grey.withAlpha(20),
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
                            //card for Email TextFormField
                            Card(
                              elevation: 6.0,
                              margin: const EdgeInsets.only(
                                  right: 20, left: 25, bottom: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                validator: (e) {
                                  if (e.isEmpty) {
                                    return "Veuillez entrer votre mail";
                                  } else if (!EmailValidator.validate(e)) {
                                    return "Votre mail est invalide";
                                  }
                                },
                                onSaved: (e) => email = e,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    //decoration: TextDecoration.none,
                                    fontFamily: "Champagne&LimousinesBold"),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 15),
                                      child: Icon(Icons.person,
                                          color: Colors.black),
                                    ),
                                    contentPadding: EdgeInsets.all(18),
                                    labelText: "Email"),
                              ),
                            ),

                            // Card for password TextFormField
                            Card(
                              elevation: 6.0,
                              margin: const EdgeInsets.only(
                                  right: 20, left: 25, bottom: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: TextFormField(
                                onSaved: (e) => password = e,
                                validator: (e) {
                                  if (e.isEmpty) {
                                    return "Veuillez entrer votre mot de passe";
                                  } else if (e.length < 9) {
                                    return "Votre mot de passe est invalide";
                                  }
                                },
                                obscureText: _secureText,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Champagne&LimousinesBold"),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Mot de passe",
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 15),
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

                            SizedBox(
                              height: 8,
                            ),
                            new Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: null,
                                    child: Text(
                                      "Mot de passe oublié ?",
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontFamily:
                                              "Champagne&LimousinesBold",
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                ]),

                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 44.0,
                              width: 250,
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Text(
                                    "Se connecter",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Champagne&LimousinesBold",
                                        color: Colors.white),
                                  ),
                                  textColor: Colors.white,
                                  color: Colors.pink,
                                  onPressed: () {
                                    check();
                                  }),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 50.0,
                              child: Text(
                                "______________________ Ou ______________________",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 11,
                                    fontFamily: "Champagne&LimousinesBold",
                                    color: Color(0XFFD6CFC7),
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 13.0,
                                  //width: 200,
                                  child: Text(
                                    "Vous n’avez pas de compte  ?",
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 11,
                                        fontFamily: "Champagne&LimousinesBold",
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                                SizedBox(
                                  height: 50.0,
                                  child: FlatButton(
                                      child: Text(
                                        "Inscrivez-vous",
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily:
                                                "Champagne&LimousinesBold",
                                            color: Colors.pink,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      textColor: Colors.pink,
                                      color: Colors.white,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Register()),
                                        );
                                      }),
                                ),
                              ],
                            ),
                            SizedBox(height: 44),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        break;

      case LoginStatus.signIn:
        return MainMenu(signOut, name, email, mobile, password, status);
//        return ProfilePage(signOut);
        break;
    }
  }
}

class Register extends StatefulWidget with NavigationStates {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name, email, mobile, password;
  final _key = new GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  void sendOTP() async {
    EmailAuth.sessionName = "IΛCOM";
    var res = await (EmailAuth.sendOtp(receiverMail: _emailController.text));
    if (res) {
      print('Mail envoyé. Vérifiez votre boite e-mail');
      sentToast('Mail envoyé. Vérifiez votre boite e-mail');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Verify(
                mail: _emailController,
                email: email,
                name: name,
                password: password,
                mobile: mobile)),
      );
    } else
      print('Adresse mail non valide!');
  }

  sentToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.pink,
        textColor: Colors.white);
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      sendOTP();
    }
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
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Veuillez entrer votre nom et prénom";
                                }
                              },
                              onSaved: (e) => name = e,
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
                                  labelText: "Nom et Prénom"),
                            ),
                          ),

                          //card for Email TextFormField
                          Card(
                            elevation: 6.0,
                            margin: const EdgeInsets.only(
                                right: 20, left: 25, bottom: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Veuillez entrer votre mail";
                                } else if (!EmailValidator.validate(e)) {
                                  return "Votre mail est invalide";
                                }
                              },
                              onSaved: (e) => email = e,
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
                                        Icon(Icons.email, color: Colors.black),
                                  ),
                                  contentPadding: EdgeInsets.all(18),
                                  labelText: "Email"),
                            ),
                          ),
                          //card for Mobile TextFormField
                          Card(
                            elevation: 6.0,
                            margin: const EdgeInsets.only(
                                right: 20, left: 25, bottom: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: TextFormField(
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Veuillez entrer votre numéro de téléphone";
                                } else if (e.length < 10) {
                                  return "Votre numéro de téléphone est invalide";
                                }
                              },
                              onSaved: (e) => mobile = e,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Champagne&LimousinesBold"),
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

                          //card for Password TextFormField
                          Card(
                            elevation: 6.0,
                            margin: const EdgeInsets.only(
                                right: 20, left: 25, bottom: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: TextFormField(
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Veuillez entrer votre mot de passe";
                                } else if (e.length < 9) {
                                  return "Votre mot de passe doit contenir au minimum 8 caractères.";
                                }
                              },
                              obscureText: _secureText,
                              onSaved: (e) => password = e,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Champagne&LimousinesBold"),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    onPressed: showHide,
                                    icon: Icon(_secureText
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                  ),
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 15),
                                    child: Icon(Icons.phonelink_lock,
                                        color: Colors.black),
                                  ),
                                  contentPadding: EdgeInsets.all(18),
                                  labelText: "Mot de passe"),
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
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Text(
                                  "S'inscrire",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Champagne&LimousinesBold",
                                      color: Colors.white),
                                ),
                                textColor: Colors.white,
                                color: Colors.pink,
                                onPressed: () {
                                  check();
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 50.0,
                            child: Text(
                              "______________________ Ou ______________________",
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 11,
                                  fontFamily: "Champagne&LimousinesBold",
                                  color: Color(0XFFD6CFC7),
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 13.0,
                                //width: 200,
                                child: Text(
                                  "Vous avez déjà un compte  ?",
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 11,
                                      fontFamily: "Champagne&LimousinesBold",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              SizedBox(
                                height: 50.0,
                                child: FlatButton(
                                    child: Text(
                                      "Connectez-vous",
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontFamily:
                                              "Champagne&LimousinesBold",
                                          color: Colors.pink,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    textColor: Colors.pink,
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()),
                                      );
                                    }),
                              ),
                            ],
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

class MainMenu extends StatefulWidget {
  final VoidCallback signOut;
  String id, name, email, mobile, password, status;
  MainMenu(this.signOut, this.name, this.email, this.mobile, this.password,
      this.status);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String id, name, email, mobile, password, status;
  FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin;
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.reload();
      id = preferences.getString("id");
      email = preferences.getString("email");
      name = preferences.getString("name");
      password = preferences.getString("password");
      mobile = preferences.getString("mobile");
      status = preferences.getString("status");

      print("id " + id);
      print("email " + email);
      print("name " + name);
      print("password " + password);
      print("mobile " + mobile);
      print("status " + status);
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    flutterLocalNotificationPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings("@mipmap/ic_launcher");
    var ios = new IOSInitializationSettings();
    var initSetting = new InitializationSettings(android: android, iOS: ios);

    flutterLocalNotificationPlugin.initialize(initSetting,
        onSelectNotification: SelectNotification);
    getPref();
  }

  Future SelectNotification(String payload) {
    print("Hello");
  }

  void showNotification() {
    var android = AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription",
        priority: Priority.high);
    var ios = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: ios);
    flutterLocalNotificationPlugin.show(0, "Iacom", "Hello", platform,
        payload: "SendMessage");
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
                  //key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/background.png'),
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
                                      "MON ESPACE",
                                      style: TextStyle(
                                          fontSize: 40,
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
                        height: 40,
                      ),
                      SizedBox(
                        height: 44.0,
                        width: 250,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.person),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    "Informations personnelles",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Champagne&LimousinesBold",
                                        color: Colors.pink),
                                  ),
                                ]),
                            textColor: Colors.pink,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MonEspace(signOut,
                                        name, email, mobile, password)),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 44.0,
                        width: 250,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.phonelink_lock),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    "Changer mot de passe",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Champagne&LimousinesBold",
                                        color: Colors.pink),
                                  ),
                                ]),
                            textColor: Colors.pink,
                            color: Colors.white,
                            onPressed: () {
                              print(password);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditPassword(
                                        id,
                                        email,
                                        name,
                                        mobile,
                                        password,
                                        signOut)),
                              );
                            }),
                      ),


                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 44.0,
                        width: 250,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.format_list_bulleted),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    "Mes services",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Champagne&LimousinesBold",
                                        color: Colors.pink),
                                  ),
                                ]),
                            textColor: Colors.pink,
                            color: Colors.white,
                            onPressed: () {
                              /*Navigator.push(
                                context,

                                MaterialPageRoute(builder: (context) => MonEspace(signOut)),
                              );*/
                            }),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 44.0,
                        width: 250,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.work),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    "Mes packs",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Champagne&LimousinesBold",
                                        color: Colors.pink),
                                  ),
                                ]),
                            textColor: Colors.pink,
                            color: Colors.white,
                            onPressed: () {
                              /*Navigator.push(
                                context,

                                MaterialPageRoute(builder: (context) => MonEspace(signOut)),
                              );*/
                            }),
                      ),
                      if (status == 'admin')
                        SizedBox(
                          height: 40,
                        ),
                      if (status == 'admin')
                        Offstage(
                          child: SizedBox(
                            height: 44.0,
                            width: 250,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(Icons.qr_code_scanner),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text(
                                        "Scanner Code QR",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily:
                                                "Champagne&LimousinesBold",
                                            color: Colors.pink),
                                      ),
                                    ]),
                                textColor: Colors.pink,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScanQR()));
                                  showNotification();
                                }),
                          ),
                          offstage: false,
                        ),
                      if (status == 'admin')
                        SizedBox(
                          height: 40,
                        ),
                      if (status == 'admin')
                        Offstage(
                          child: SizedBox(
                            height: 44.0,
                            width: 250,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(Icons.list_alt),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text(
                                        "Ajouter des Actualités",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily:
                                            "Champagne&LimousinesBold",
                                            color: Colors.pink),
                                      ),
                                    ]),
                                textColor: Colors.pink,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddActualites())
                                  );
                                  showNotification();
                                }),
                          ),
                          offstage: false,
                        ),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 44.0,
                        width: 250,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.lock_open),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    "Se déconnecter",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Champagne&LimousinesBold",
                                        color: Colors.pink),
                                  ),
                                ]),
                            textColor: Colors.pink,
                            color: Colors.white,
                            onPressed: () {
                              signOut();
                            }),
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

class Verify extends StatefulWidget {
  TextEditingController mail = TextEditingController();
  String name, email, mobile, password;
  Verify(
      {Key key,
      @required this.mail,
      @required this.email,
      @required this.name,
      @required this.mobile,
      @required this.password});
  @override
  _VerifyState createState() => _VerifyState(
      mail: mail, email: email, name: name, password: password, mobile: mobile);
}

class _VerifyState extends State<Verify> {
  final _key = new GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  TextEditingController mail = TextEditingController();
  String name, email, mobile, password;
  _VerifyState(
      {Key key,
      @required this.mail,
      @required this.email,
      @required this.name,
      @required this.mobile,
      @required this.password});

  save() async {
    final response = await http
        .post("http://192.168.1.4/iacomappiuapp/api_verification.php", body: {
      "flag": 2.toString(),
      "name": name,
      "email": email,
      "mobile": mobile,
      "password": password,
      "fcm_token": "test_fcm_token",
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      setState(() {
        //Navigator.pop(context);
      });
      print(message);
      registerToast(message);
    } else if (value == 2) {
      print(message);
      registerToast(message);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } else {
      print(message);
      registerToast(message);
    }
  }

  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.pink,
        textColor: Colors.white);
  }

  void validateOTP() {
    var res = EmailAuth.validate(
        receiverMail: mail.text, userOTP: _otpController.text);
    if (res) {
      print('Code vérifier');
      Navigator.pop(context);
      validateToast('Code vérifier');
      save();
    } else {
      print('Code invalide! Réessayez à nouveau.');
      validateToast('Code invalide! Réessayez à nouveau.');
    }
  }

  validateToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.pink,
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.pink),
      home: SingleChildScrollView(
        child: Container(
          height: 800,
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
                            height: 40,
                          ),
                          Card(
                            elevation: 6.0,
                            margin: const EdgeInsets.only(
                                right: 20, left: 25, bottom: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Veuillez entrer le code";
                                }
                              },
                              controller: _otpController,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Champagne&LimousinesBold"),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 15),
                                    child: Icon(Icons.phonelink_lock,
                                        color: Colors.black),
                                  ),
                                  contentPadding: EdgeInsets.all(18),
                                  labelText: "Code"),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            height: 44.0,
                            width: 250,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Text(
                                  "Verifier code",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Champagne&LimousinesBold",
                                      color: Colors.white),
                                ),
                                textColor: Colors.white,
                                color: Colors.pink,
                                onPressed: () {
                                  validateOTP();
                                }),
                          ),
                          SizedBox(
                            height: data.size.height,
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
