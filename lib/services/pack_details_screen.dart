import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:QRScanner/models/pack.dart';
import 'package:QRScanner/views/app_bar_icons.dart';

class PackDetailsScreen extends StatelessWidget {
  final Pack pack;

  PackDetailsScreen(this.pack);

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
                  child: Image.network('https://iacomapps.fr/data/fr.iacom.apps/drawable/${pack.image_art}', fit: BoxFit.cover, width: 300, height: 200,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${pack.nom_art}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 22.0, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${pack.description}',
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
