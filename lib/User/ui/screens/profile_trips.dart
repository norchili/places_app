import 'package:flutter/material.dart';
import 'package:places_app/User/ui/screens/profile_header.dart';
import 'package:places_app/User/ui/widgets/profile_places_list.dart';
import 'package:places_app/widgets/gradient_back.dart';

class ProfileTrips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*return Container(
      color: Colors.indigo,
    );*/
    return Stack(
      children: <Widget>[
        GradientBack(height: 250.0), //ProfileBackground(),
        ListView(
          children: <Widget>[ProfileHeader(), ProfilePlacesList()],
        ),
      ],
    );
  }
}
