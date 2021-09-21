import 'package:flutter/material.dart';
import 'package:places_app/Place/model/place.dart';
import 'profile_place.dart';

class ProfilePlacesList extends StatelessWidget {
  final Place bacalar = new Place(
      urlImage: "assets/img/bacalar.jpg",
      name: "Bacalar, Quintana Roo",
      description:
          "Lagoon, stories of pirates, temples and architecture of Mayan, Blue Cenote, snorkeling, diving, boat ride and swimming await you.",
      likes: 345,
      category: "Beach");

  final Place creel = new Place(
      urlImage: "assets/img/creel.jpg",
      name: "Creel, Chihuahua",
      description:
          "Sierra Tarahumara. Forests, waterfalls, caves, nature, cable car, Rarámuri culture, magical town, wood art, the copper canyons.",
      likes: 4586,
      category: "Mountains");

  final Place sanCristobalDeLasCasas = new Place(
      urlImage: "assets/img/san_cristobal_de_las_casas.jpg",
      name: "San Cristobal de las Casas, Chiapas",
      description:
          "It is among trees and dense evils and fresh mist, colonial buildings, traditions and festivals, squares, temples and buildings, Huitepec Reserve, El Arcotete, ecotourism park, Chanfaina and amaranth are part of its typical foods.",
      likes: 978563,
      category: "Selva");

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: Column(
        children: <Widget>[
          ProfilePlace(creel),
          ProfilePlace(bacalar),
          ProfilePlace(sanCristobalDeLasCasas)
        ],
      ),
    );
  }
}
