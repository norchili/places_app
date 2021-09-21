import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:places_app/User/model/user.dart';

class CloudFirestoreApi {
  static const String USERS =
      "users"; //nombre de la coleccion de usuarios en Firebase
  static const String PLACES =
      "places"; //nombre de la coleccion de lugares (Places) en Firebase

  final FirebaseFirestore _dataBase = FirebaseFirestore.instance;

  //primer metodo Actualizar datos de usuario
  void updateUserData(User user) async {
    DocumentReference reference = _dataBase.collection(USERS).doc(user.userId);
    return reference.set({
      'userID': user.userId,
      'name': user.name,
      'email': user.email,
      'photoUrl': user.photoURL,
      'myPlaces': user.myPlaces,
      'myFavoritePlaces': user.myFavoritePlaces,
      'lastSigIn': DateTime.now()
    }, SetOptions(merge: true));
  }
}
