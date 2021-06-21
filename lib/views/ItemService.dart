import 'package:flutter/material.dart';

class ItemService extends StatelessWidget {
  final String title, shopName, svgSrc;
  final Function press;
  const ItemService({
    Key key,
    this.title,
    this.shopName,
    this.svgSrc,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 20, right: 15, top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(2,2),
            blurRadius: 5,
        spreadRadius: 1.0,
            color: Color(0xFFB0CCE1).withOpacity(0.32),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(svgSrc,
                    width: size.width * 0.6,
                      fit:BoxFit.fill,
                ),
                ),
                Text(title),
                SizedBox(height: 10),

              ],
            ),
          ),
        ),
      ),
    );
  }
}