import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:QRScanner/models/service.dart';
import 'package:QRScanner/views/app_bar_icons.dart';
import 'package:url_launcher/url_launcher.dart';


class ServiceDetailsScreen extends StatelessWidget {
  final Service service;

  ServiceDetailsScreen(this.service);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBarIcon(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network('https://iacomapps.fr/data/fr.iacom.apps/drawable/${service.image_art}', fit: BoxFit.cover, width: 300, height: 200,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${service.nom_art}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 22.0, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${service.description}',
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
