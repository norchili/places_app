import 'dart:io';

import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:places_app/Place/model/place.dart';
import 'package:places_app/Place/ui/widgets/card_image.dart';
import 'package:places_app/Place/ui/widgets/title_input_location.dart';
import 'package:places_app/User/bloc/bloc_user.dart';
import 'package:places_app/widgets/button_purple.dart';
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
  final _controllerTitlePlace = TextEditingController();
  final _controlleDescriptionPlace = TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack(height: 300.0),
          //App Bar
          Row(
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
          //Widgets debajo del AppBar
          Container(
            margin: EdgeInsets.only(top: 100.0, bottom: 20.0),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    child: CardImageWithFabIcon(
                        pathImage:
                            "assets/img/bacalar.jpg", //widget.image.path,
                        height: 250.0,
                        width: 350,
                        onPressedFabIcon: () {},
                        iconData:
                            Icons.camera_enhance_outlined)), // Foto del Place
                Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextInput(
                    fontSize: 16.0,
                    hintText: "Title",
                    inputType: null,
                    controller: _controllerTitlePlace,
                    maxLines: 1,
                  ),
                ),
                TextInput(
                  fontSize: 14.0,
                  hintText: "Description",
                  inputType: TextInputType.multiline,
                  controller: _controlleDescriptionPlace,
                  maxLines: 4,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: TextInputLocation(
                      hintText: "Add Location",
                      fontSize: 14.0,
                      iconData: Icons.location_on_outlined),
                ),
                Container(
                  //width: 70.0,
                  height: 90.0,
                  child: ButtonPurple(
                      buttonText: "Add Place",
                      onPressed: () {
                        //1. FirebaseStorage
                        //Nos devuelve una Url
                        //2. Enviamos la url, el titulo, descripcion, userOwner, likes al CloudFirestore
                        userBloc
                            .updateUserPlaceData(Place(
                                name: _controllerTitlePlace.text,
                                description: _controlleDescriptionPlace.text,
                                likes: 0))
                            .whenComplete(() {
                          print(
                              "Terminó de agregar datos de Place en CloudFirestore");
                          Navigator.pop(context);
                        });
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
