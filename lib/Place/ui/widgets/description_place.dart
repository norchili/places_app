import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:places_app/Place/model/place.dart';
import 'package:places_app/User/bloc/bloc_user.dart';
import 'package:places_app/widgets/button_purple.dart';

class DescriptionPlace extends StatelessWidget {
  //late final String namePlace;
  //late final int stars;
  //late final String descriptionPlace;

  //DescriptionPlace(this.namePlace, this.stars, this.descriptionPlace);

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of(context);

    Widget titleStarsWidget(Place? place) {
      return Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 350.0, left: 20.0, right: 20.0),
            child: Text(
              place == null ? "Error de conexión" : place.name,
              style: TextStyle(
                  fontFamily: "Lato",
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 370.0),
              child: Text(
                place == null ? "Error de conexión" : "Likes: ${place.likes}",
                style: TextStyle(
                    fontFamily: "Lato",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.amber),
                textAlign: TextAlign.left,
              ))
        ],
      );
    }

    Widget descriptionWidget(String description) {
      return Container(
        margin: new EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: new Text(
          description,
          style: const TextStyle(
              fontFamily: "Lato",
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF56575a)),
        ),
      );
    }

    return StreamBuilder(
        stream: userBloc.placeSelectedStream,
        builder: (BuildContext context, AsyncSnapshot<Place> snapshot) {
          if (snapshot.hasData) {
            Place? place = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                titleStarsWidget(place),
                descriptionWidget(place == null
                    ? "Null: Error al cargar la descripcion"
                    : place.description),
                ButtonPurple(
                  buttonText: "Navigate",
                  onPressed: () {},
                  width: 200.0,
                  height: 50.0,
                )
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 400.0, left: 20.0, right: 20.0),
                  child: Text(
                    "Selecciona un lugar",
                    style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            );
          }
        });
  }
}
