import 'dart:convert';
import 'package:QRScanner/views/app_bar_icons.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ScanQR extends StatefulWidget {
  ScanQR({Key key}) : super(key: key);

  @override
  _ScanQRState createState() => _ScanQRState();
}

String qrData = "Donnée non trouvée!";
var data;
bool hasdata = false;

class _ScanQRState extends State<ScanQR> {

 String points;
 String email;
 int counter=0;
 point() async {
   final response = await http
       .post("http://192.168.1.87/iacomappiuapp/points.php", body: {
     "email": email,
   });

   final data = jsonDecode(response.body);
   int value = data['value'];
   String message = data['message'];
   //String emailAPI = data['email'];
   String pointsAPInew = data['points'];
   if (value == 1) {

     print(message);
     pointToast(message);
     print(pointsAPInew);
     points= pointsAPInew;
     counter = int.parse(points);
     counter = counter +1;
     points= counter.toString();
     submit();
   } else {
     print("fail");
     print(message);
     pointToast(message);
   }
 }
 pointToast(String toast) {
   return Fluttertoast.showToast(
       msg: toast,
       toastLength: Toast.LENGTH_SHORT,
       gravity: ToastGravity.BOTTOM,
       timeInSecForIos: 1,
       backgroundColor: Colors.pink,
       textColor: Colors.white);
 }
 submit() async {
   final response = await http.post("http://192.168.1.87/iacomappiuapp/editpoints.php", body: {
     "email": email,
     "points": points,
   });

   final data = jsonDecode(response.body);
   int value = data['value'];
   String message = data['message'];
   if (value == 1) {
     print(message);
     pointToast(message);
   } else {
     print(message);
     pointToast(message);
   }
 }

 @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "Scan QR",
      child: Scaffold(
        appBar: homeAppBarIcon(context),
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      "Résultat de votre scan:  ${(qrData)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  /*IconButton(
                    icon: Icon(Icons.launch),
                    onPressed: hasdata
                        ? () async {
                      if (await canLaunch(qrData)) {
                        print(qrData);
                        await launch(qrData);
                      } else {
                        throw 'Could not launch ';
                      }
                    }
                        : null,
                  ),*/
                ],
              ),
              SizedBox(height: 15),
              Container(
                width: ((MediaQuery.of(context).size.width) / 2) - 30,
                height: 35,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(15.0)),
                  child: Text(
                    "Scanner code QR",
                    style: TextStyle(fontSize: 15, fontFamily: "Champagne&LimousinesBold", color: Colors.white),
                  ),
                  textColor: Colors.white,
                  color: Colors.pink,
                  onPressed: () async {
                    var options = ScanOptions(
                      autoEnableFlash: false,
                    );

                    var data = await BarcodeScanner.scan(options: options);
                    setState(() {

                      qrData = data.rawContent.toString();
                      hasdata = true;

                    });
                    email = qrData;
                  point();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
