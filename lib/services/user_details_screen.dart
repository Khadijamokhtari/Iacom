import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:QRScanner/models/user.dart';
import 'package:QRScanner/views/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';


class UserDetailsScreen extends StatelessWidget {
  final User user;

  UserDetailsScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${user.Name}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 22.0, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${user.Email}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 15, fontFamily: "Champagne&LimousinesBold", color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
