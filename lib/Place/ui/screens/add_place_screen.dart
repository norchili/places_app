import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/widgets/gradient_back.dart';
import 'package:places_app/widgets/text_input.dart';
import 'package:places_app/widgets/title_header.dart';

class AddPlaceScreen extends StatefulWidget {
  final File?
      image; //Se declara imagen de tipo File para agregar imagenes o abrir camara.

  AddPlaceScreen({Key? key, this.image}); //Constructor
  @override
  State<StatefulWidget> createState() {
    return _AddPlaceScreen();
  }
}

class _AddPlaceScreen extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    final _controllerTitlePlace = TextEditingController();
    final _controlleDescriptionPlace = TextEditingController();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack(height: 300.0),
          Row(
            //App Bar
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 25.0, left: 5.0),
                  child: SizedBox(
                      //delimita el espacio para hacer click y regresar a la pantalla anterior
                      width: 45.0, //Espacio establecido
                      height: 45.0,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.keyboard_arrow_left,
                              color: Colors.white, size: 45.0)))),
              Flexible(
                  child: Container(
                padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 10.0),
                child: TitleHeader(title: "Add a new Place"),
              ))
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 120.0, bottom: 20.0),
            child: ListView(
              children: <Widget>[
                Container(), // Foto del Place
                Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: TextInput(
                    fontSize: 15.0,
                    hintText: "Title",
                    inputType: null,
                    controller: _controllerTitlePlace,
                    maxLines: 1,
                  ),
                ),
                TextInput(
                  fontSize: 12.0,
                  hintText: "Description",
                  inputType: TextInputType.multiline,
                  controller: _controlleDescriptionPlace,
                  maxLines: 4,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
