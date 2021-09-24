import 'package:flutter/material.dart';
import 'card_image.dart';

class CardImageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = 200.0;
    double _width = 300.0;
    void onPressedFav() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Agregaste a tus Favoritos"),
      ));
    }

    return Container(
      //margin: EdgeInsets.only(top: 10.0),
      height: 350.0,
      child: ListView(
        padding: EdgeInsets.all(25.0),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CardImageWithFabIcon(
              pathImage: "assets/img/beach_palm.jpeg",
              height: _height,
              width: _width,
              iconData: Icons.favorite_border,
              onPressedFabIcon: onPressedFav),
          CardImageWithFabIcon(
              pathImage: "assets/img/mountain.jpeg",
              height: _height,
              width: _width,
              iconData: Icons.favorite_border,
              onPressedFabIcon: onPressedFav),
          CardImageWithFabIcon(
              pathImage: "assets/img/mountain_stars.jpeg",
              height: _height,
              width: _width,
              iconData: Icons.favorite_border,
              onPressedFabIcon: onPressedFav),
          CardImageWithFabIcon(
              pathImage: "assets/img/river.jpeg",
              height: _height,
              width: _width,
              iconData: Icons.favorite_border,
              onPressedFabIcon: onPressedFav),
          CardImageWithFabIcon(
              pathImage: "assets/img/sunset.jpeg",
              height: _height,
              width: _width,
              iconData: Icons.favorite_border,
              onPressedFabIcon: onPressedFav),
        ],
      ),
    );
  }
}
