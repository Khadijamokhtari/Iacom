import 'package:flutter/material.dart';
import 'package:QRScanner/models/actualite.dart';
import 'package:QRScanner/views/actualite_details_screen.dart';
import 'package:QRScanner/views/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:QRScanner/services/actualite-api.dart';
import 'package:QRScanner/views/sidebar/sidebar_layout.dart';

class ActualiteListScreen extends StatelessWidget  with NavigationStates{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(9.0),
            child: Container(
              child: FutureBuilder(
                  future: fetchActualite(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            Actualite actualite = snapshot.data[index];
                            return Card(
                              child: ListTile(
                                title: Text('${actualite.titre_act}', style: TextStyle(fontSize: 15, fontFamily: "Champagne&LimousinesBold", color: Colors.black, fontWeight: FontWeight.w900),),
                                subtitle: Text('${actualite.description_act}', overflow: TextOverflow.ellipsis, maxLines: 2, style: TextStyle(fontSize: 10, fontFamily: "Champagne&LimousinesBold", color: Colors.black),),
                                leading: Image.network('https://iacomapps.fr/data/fr.iacom.app/drawable/${actualite.image_act}', fit: BoxFit.cover, width: 100,),
                                //leading: Image(image: FileImage('https://iacomapps.fr/data/fr.iacom.app/drawable/${actualite.image_act}')),
                                //leading: Image.asset('${actualite.image_act}'),
                                trailing: Icon(Icons.arrow_forward),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ActualiteDetailsScreen(actualite)),
                                    );
                                  },
                              ),
                            );
                          }
                      );
                    }
                    return CircularProgressIndicator(
                            valueColor:AlwaysStoppedAnimation<Color>(Colors.pink), strokeWidth:5,
                    );
                    },
              ),
            ),
        ),
    );
  }
}