import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:places_app/Place/model/place.dart';
import 'package:places_app/User/model/user.dart' as modelUser;

class CloudFirestoreApi {
  static const String USERS =
      "users"; //nombre de la coleccion de usuarios en Firebase
  static const String PLACES =
      "places"; //nombre de la coleccion de lugares (Places) en Firebase

  final FirebaseFirestore _dataBase = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //primer metodo Actualizar datos de usuario
  void updateUserData(modelUser.User user) async {
    DocumentReference reference = _dataBase.collection(USERS).doc(user.userId);
    return await reference.set({
      'userID': user.userId,
      'name': user.name,
      'email': user.email,
      'photoUrl': user.photoURL,
      'myPlaces': user.myPlaces,
      'myFavoritePlaces': user.myFavoritePlaces,
      'lastSigIn': DateTime.now()
    }, SetOptions(merge: true));
  }

  Future<void> updateUserPlaceData(Place place) async {
    CollectionReference referencePlaces = _dataBase.collection(PLACES);

    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      await referencePlaces.add({
        'name': place.name,
        'description': place.description,
        'likes': place.likes,
        'userOwner': "$USERS/${currentUser.uid}"
      });
    } else
      print("No hay usuario logueado");
  }
}
