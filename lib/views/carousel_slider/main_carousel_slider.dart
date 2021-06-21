import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselDemo extends StatefulWidget {
  CarouselDemo() : super();
  final String title = "Carousel Demo";
  @override
  CarouselDemoState createState() => CarouselDemoState();
}

class CarouselDemoState extends State<CarouselDemo> {
  CarouselSlider carouselSlider;
  int _current = 0;
  List imgList = [
    'https://iacomapps.fr/data/fr.iacom.app/drawable/mobilemit.jpg',
    'https://iacomapps.fr/data/fr.iacom.app/drawable/erpmit.jpg',
    'https://iacomapps.fr/data/fr.iacom.app/drawable/sitemit.jpg',
    'https://iacomapps.fr/data/fr.iacom.app/drawable/image4.jpg',
    'https://iacomapps.fr/data/fr.iacom.app/drawable/seomit.jpg'
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            carouselSlider = CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                initialPage: 0,
                enlargeCenterPage: true,
                autoPlay: true,
                reverse: false,
                enableInfiniteScroll: true,
                autoPlayInterval: Duration(seconds: 2),
                autoPlayAnimationDuration: Duration(milliseconds: 2000),
                //pauseAutoPlayOnTouch: Duration(seconds: 10),
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },),

              items: imgList.map((imgUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 0.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill, image: NetworkImage(imgUrl),
                        ),
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            
          ],
        ),
      ),
    ),
    );
  }
}
