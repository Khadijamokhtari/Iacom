    import 'dart:async';
    import 'package:flutter/material.dart';
    import 'package:google_maps_flutter/google_maps_flutter.dart';
    import 'package:font_awesome_flutter/font_awesome_flutter.dart';

    class PlanAcces extends StatefulWidget {
      @override
      PlanAccesState createState() => PlanAccesState();
    }

    class PlanAccesState extends State<PlanAcces> with AutomaticKeepAliveClientMixin{
      Completer<GoogleMapController> _controller = Completer();

      @override
      void initState() {
        super.initState();
      }
      double zoomVal=5.0;
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              _buildGoogleMap(context),
              _zoomminusfunction(),
              _zoomplusfunction(),
              _buildContainer(),
            ],
          ),
        );
      }

      Widget _zoomminusfunction() {

        return Align(
          alignment: Alignment.topLeft,
          child: IconButton(
              icon: Icon(FontAwesomeIcons.searchMinus,color:Colors.pink),
              onPressed: () {
                zoomVal--;
                _minus( zoomVal);
              }),
        );
      }
      Widget _zoomplusfunction() {

        return Align(
          alignment: Alignment.topRight,
          child: IconButton(
              icon: Icon(FontAwesomeIcons.searchPlus,color:Colors.pink),
              onPressed: () {
                zoomVal++;
                _plus(zoomVal);
              }),
        );
      }

      Future<void> _minus(double zoomVal) async {
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(46.701670698482715, 2.128639565478065), zoom: zoomVal)));
      }
      Future<void> _plus(double zoomVal) async {
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(46.701670698482715, 2.128639565478065), zoom: zoomVal)));
      }


      Widget _buildContainer() {
        return Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            height: 100.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                SizedBox(width: 5.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _boxes(48.801308915425516, 2.3251443269208645,"Agence Île de France"),
                ),
                SizedBox(width: 10.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _boxes(44.83014568690042, -0.6745221520505057,"Agence Sud Ouest"),
                ),
              ],
            ),
          ),
        );
      }

      Widget _boxes(double lat,double long,String restaurantName) {
        return  GestureDetector(
          onTap: () {
            _gotoLocation(lat,long);
          },
          child:Container(
            child: new FittedBox(
              child: Material(
                  color: Colors.white,
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Color(0x802196F3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height:100,
                        width: 190,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: myDetailsContainer1(restaurantName),
                        ),
                      ),

                    ],)
              ),
            ),
          ),
        );
      }

      Widget myDetailsContainer1(String restaurantName) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                  child: Text(restaurantName,
                    style: TextStyle(
                        color: Colors.pink,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Champagne&LimousinesBold"
                    ),
                  )),
            ),
          ],
        );
      }

      Widget _buildGoogleMap(BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition:  CameraPosition(target: LatLng(46, 2), zoom: 5),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
              agencesudouestMarker,agenceiledefranceMarker
            },
          ),
        );
      }

      Future<void> _gotoLocation(double lat,double long) async {
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
          bearing: 45.0,)));
      }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
    }

    Marker agenceiledefranceMarker = Marker(
      markerId: MarkerId('agenceiledefrance'),
      position: LatLng(48.801308915425516, 2.3251443269208645),
      infoWindow: InfoWindow(title: 'Agence Île de France'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRose,
      ),
    );

    Marker agencesudouestMarker = Marker(
      markerId: MarkerId('agencesudouest'),
      position: LatLng(44.83014568690042, -0.6745221520505057),
      infoWindow: InfoWindow(title: 'Agence Sud Ouest'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRose,
      ),
    );