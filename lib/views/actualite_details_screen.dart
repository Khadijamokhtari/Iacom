import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:QRScanner/models/actualite.dart';
import 'package:QRScanner/views/app_bar_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bloc.navigation_bloc/navigation_bloc.dart';

class ActualiteDetailsScreen extends StatelessWidget with NavigationStates{
  final Actualite actualite;
  ActualiteDetailsScreen(this.actualite);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                    child: Image.network('https://iacomapps.fr/data/fr.iacom.app/drawable/${actualite.image_act}',
                      fit: BoxFit.cover, width: 300, height: 200,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${actualite.titre_act}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 22.0, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${actualite.description_act}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15, fontFamily: "Champagne&LimousinesBold", color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: Text('${actualite.moreLink}' != null ? '${actualite.moreLink}': Container(),
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15, fontFamily: "Champagne&LimousinesBold", color: Colors.indigo, decoration: TextDecoration.underline, fontWeight: FontWeight.w900),
                  ),
                  onTap: () {
                    launch('${actualite.moreLink}');
                  }
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      child: Text('${actualite.moreTextLink}' != null ? '${actualite.moreTextLink}': Container(),
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 15, fontFamily: "Champagne&LimousinesBold", color: Colors.indigo, decoration: TextDecoration.underline, fontWeight: FontWeight.w900),
                      ),
                      onTap: () {
                        launch('${actualite.moreLink}');
                      }
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
