import 'package:flutter/material.dart';
import 'package:places_app/User/model/user.dart';

class Place {
  final String? id;
  final String name;
  final String description;
  final String urlImage;
  int likes;
  final String? category;
  final List<User>? usersLiked;
  bool liked;

  //final User? userOwner;

  Place(
      {Key? key,
      this.id,
      this.likes = 0,
      this.category,
      required this.name,
      required this.description,
      this.urlImage = "https://imgur.com/eJsTDCs",
      this.liked = false,
      this.usersLiked
      //this.userOwner
      });
}
