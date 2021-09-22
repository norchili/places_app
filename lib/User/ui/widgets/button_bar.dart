import 'dart:io';

import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:places_app/Place/ui/screens/add_place_screen.dart';
import 'package:places_app/User/bloc/bloc_user.dart';
import 'circle_button.dart';

class ButtonsBar extends StatelessWidget {
  late final UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            //CircleButton(true, Icons.turned_in_not, 20.0, Color.fromRGBO(255, 255, 255, 1)),
            CircleButton(
                mini: true,
                icon: Icons.vpn_key,
                iconSize: 20.0,
                color: Color.fromRGBO(255, 255, 255, 0.6),
                onPressed: () => {}),
            CircleButton(
                mini: false,
                icon: Icons.add,
                iconSize: 40.0,
                color: Color.fromRGBO(255, 255, 255, 1),
                onPressed: () {
                  File? image;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AddPlaceScreen(image: image)));
                }),
            CircleButton(
                mini: true,
                icon: Icons.exit_to_app,
                iconSize: 20.0,
                color: Color.fromRGBO(255, 255, 255, 0.6),
                onPressed: () {
                  userBloc.signOut();
                }),
            //CircleButton(true, Icons.person, 20.0, Color.fromRGBO(255, 255, 255, 0.6))
          ],
        ));
  }
}
