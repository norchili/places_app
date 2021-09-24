import 'package:places_app/User/model/user.dart';
import 'package:flutter/material.dart';

class Place {
  final String? id;
  final String name;
  final String description;
  final String urlImage;
  final int? likes;
  final String? category;

  final User? userOwner;

  Place(
      {Key? key,
      this.id,
      this.likes,
      this.category,
      required this.name,
      required this.description,
      this.urlImage = "https://imgur.com/eJsTDCs",
      this.userOwner});
}
