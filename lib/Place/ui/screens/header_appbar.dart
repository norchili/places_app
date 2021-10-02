import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:places_app/User/bloc/bloc_user.dart';
import 'package:places_app/User/model/user.dart' as modelUser;
import 'package:places_app/widgets/gradient_back.dart';
import '../widgets/card_image_list.dart';

class HeaderAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of(context);
    return StreamBuilder(
        stream: userBloc.authStatus,
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              return showPlacesData(snapshot);
            case ConnectionState.done:
              return showPlacesData(snapshot);
          }
        });

    /*Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        GradientBack(title: "Bienvenido", height: 250.0),
        CardImageList()
      ],
    );*/
  }

  Widget showPlacesData(AsyncSnapshot<User?> snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      return Stack(children: [
        GradientBack(height: 250.0),
        Text("Usuario no logueado. Haz login.")
      ]);
    } else {
      modelUser.User user = modelUser.User(
          userId: snapshot.data!.uid,
          name: snapshot.data!.displayName!,
          email: snapshot.data!.email!,
          photoURL: snapshot.data!.photoURL!);

      return Stack(
        children: [GradientBack(height: 250.0), CardImageList(user: user)],
      );
    }
  }
}
