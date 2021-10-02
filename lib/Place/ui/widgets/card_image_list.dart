import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:places_app/Place/model/place.dart';
import 'package:places_app/User/bloc/bloc_user.dart';
import 'package:places_app/User/model/user.dart';
import 'card_image.dart';

class CardImageList extends StatefulWidget {
  final User user;

  CardImageList({Key? key, required this.user});

  @override
  State<StatefulWidget> createState() {
    return _CardImageList();
  }
}

class _CardImageList extends State<CardImageList> {
  UserBloc? userBloc;
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);

    return Container(
        //margin: EdgeInsets.only(top: 10.0),
        height: 350.0,
        child: StreamBuilder(
            stream: userBloc!.placesStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  return listViewPlaces(
                      userBloc!.buildPlaces(snapshot.data!.docs, widget.user));
                case ConnectionState.done:
                  return listViewPlaces(
                      userBloc!.buildPlaces(snapshot.data!.docs, widget.user));
              }
            }));
  }

  Widget listViewPlaces(List<Place> places) {
    //Metodo para desencadenar las acciones al dar like o dislike con el boton del Heart
    void setLiked(Place place) {
      setState(() {
        place.liked = !place.liked;
        userBloc!.likePlace(place, widget.user.userId!);
        place.likes = place.liked ? place.likes + 1 : place.likes - 1;
        userBloc!.placeSelectedSink.add(place);
      });
    }

    IconData iconDataLiked = Icons.favorite;
    IconData iconDataLike = Icons.favorite_border;
    return ListView(
        padding: EdgeInsets.all(25.0),
        scrollDirection: Axis.horizontal,
        children: places.map((place) {
          return GestureDetector(
              onTap: () {
                userBloc!.placeSelectedSink.add(place);
              },
              child: CardImageWithFabIcon(
                  pathImage: place.urlImage,
                  height: 200.0,
                  width: 300.0,
                  onPressedFabIcon: () {
                    setLiked(place);
                  },
                  iconData: place.liked ? iconDataLiked : iconDataLike,
                  internet: true));
        }).toList());
  }
}
