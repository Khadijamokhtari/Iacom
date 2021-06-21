import 'package:flutter/material.dart';

class Propos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        child: SingleChildScrollView(
        child: Column(
      children: [
          //Container(
            //height: 100,
            //decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(10),
              //color: Colors.white,
              //boxShadow: [
                //BoxShadow(
                  //offset: Offset(2,2),
                  //blurRadius: 5,
                  //spreadRadius: 1.0,
                  //color: Color(0xFFB0CCE1).withOpacity(0.15),
                //),
              //],
            //),
            //margin: EdgeInsets.only(top: 20, left: 50, right: 50),
            //padding: EdgeInsets.only(top: 10, left: 20, right: 15),
            //child: Center(
                //child: Text("Du Lundi au Vendredi de 8h à 12h et de 14h à 18h", style: TextStyle(fontSize: 15, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w900),),
            //),
          //),
        SizedBox(height: 10),
          Container(
            height: 580,
            width: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(2,2),
                  blurRadius: 5,
                  spreadRadius: 1.0,
                  color: Color(0xFFB0CCE1).withOpacity(0.15),
                ),
              ],
            ),
            margin: EdgeInsets.only(top: 10, left: 30, right: 30),
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
              //Nous sommes IACOM, une agence web qui vous accompagne dans la création de votre
              child: Text("NOUS SOMMES IACOM, UNE AGENCE WEB QUI VOUS ACCOMPAGNE DANS LA CRÉATION DE VOTRE SITE INTERNET, IMAGE DE MARQUE, MARKETING DIGITAL ET VOTRE RÉFÉRENCEMENT. \n"
                  "\n NOUS APPORTONS AUX PETITES ENTREPRISES LA COMMUNICATION DES GRANDES ! ARTISANS, COMMERÇANTS, PME, TPE NOUS VOUS OFFRONS LA NOTORIÉTÉ ET LA VISIBILITÉ NÉCESSAIRES AU DÉVELOPPEMENT DE VOS VENTES. \n"
                  "\n NOTRE AGENCE WEB CRÉE VOTRE SITE INTERNET VITRINE OU E-COMMERCE, L'ERGONOMIE, LE DESIGN, LE CONTENU ET VOUS PERMET D'ÊTRE BIEN RÉFÉRENCÉ. \n"
                  "\n NOTRE AGENCE WEB RÉALISE VOTRE IDENTITÉ VISUELLE (MARQUE, COULEURS,CHARTE GRAPHIQUE, DESIGN ... ) \n"
                  "\n NOTRE AGENCE WEB CONÇOIT VOTRE APPLICATION MOBILE POUR ÊTRE ENCORE PLUS PROCHE DE VOS CLIENTS.", style: TextStyle(fontSize: 16, fontFamily: "Champagne&LimousinesBold", color: Colors.black),textAlign: TextAlign.justify),
          ),
          SizedBox(height: 10),
      ],
        ),
        ),
        ),
    );
  }
}