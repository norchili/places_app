import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:places_app/User/bloc/bloc_user.dart';
import 'package:places_app/User/model/user.dart';
import 'package:places_app/platzi_trips_cupertino.dart';
import 'package:places_app/widgets/button_green.dart';
import 'package:places_app/widgets/gradient_back.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInScreen();
  }
}

class _SignInScreen extends State<SignInScreen> {
  late double screenWidht;
  UserBloc? userBloc;
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    screenWidht = MediaQuery.of(context)
        .size
        .width; //Obtenemos el tamaño exacto de la pantalla del movil
    return _handleCurrentSession();
  }

  //Metodo para establecer la pantalla de inicio
  //en base a si está o no autenticado con google
  Widget _handleCurrentSession() {
    return StreamBuilder(
        stream: userBloc!
            .authStatus, //Solicitamos conocer el estatus de la sesion de Firebase
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //snapshot contiene nuestro objeto User de Firebase
          if (!snapshot.hasData || snapshot.hasError) {
            return signInGoogleUI(); //Si no hay datos en User pide que se autentique
          } else {
            return PlatziTripsCupertino(); //Si hay datos de Usuario autenticado pasa a la pantalla principal de la app de viajes
          }
        });
  }

  Widget signInGoogleUI() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack(height: null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  child: Container(
                      width: screenWidht,
                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text("Welcome. \nThis is your Travel App",
                          style: TextStyle(
                              fontSize: 30.0,
                              fontFamily: "Lato",
                              color: Colors.white,
                              fontWeight: FontWeight.bold)))),
              ButtonGreen(
                text: "Login with Gmail",
                onPressed: () {
                  userBloc!.signOut();
                  userBloc!.signIn().then((value) {
                    userBloc!.updateUserData(User(
                        userId: value!.user!.uid.toString(),
                        name: value.user!.displayName.toString(),
                        email: value.user!.email.toString(),
                        photoURL: value.user!.photoURL.toString()));
                  }); //El codigo se termina hasta antes del .then, pero esto se hace para depuracion en caso de falla
                },
                width: 300.0,
                height: 50.0,
              ),
            ],
          )
        ],
      ),
    );
  }
}
