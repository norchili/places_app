import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:places_app/Place/model/place.dart';
import 'package:places_app/User/model/user.dart' as modelUser;
import 'package:places_app/User/ui/widgets/profile_place.dart';

class CloudFirestoreApi {
  static const String USERS =
      "users"; //nombre de la coleccion de usuarios en Firebase
  static const String PLACES =
      "places"; //nombre de la coleccion de lugares (Places) en Firebase

  String getUSERS() {
    return USERS;
  }

  String getPLACES() {
    return PLACES;
  }

  final FirebaseFirestore _dataBase = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //primer metodo Actualizar datos de usuario
  void updateUserData(modelUser.User user) async {
    CollectionReference referenceUsers = _dataBase.collection(USERS);
    referenceUsers
        .where('userID', isEqualTo: user.userId)
        .get()
        .then((snapshot) async {
      //Comparamos si el usuario se ha logueado anteriormente
      //En dado caso que sea su primer inicio de sesion
      //Setear los datos 'myPlaces' y 'myFavouritePlaces'
      if (snapshot.docs.isNotEmpty) {
        DocumentReference reference =
            _dataBase.collection(USERS).doc(user.userId);
        return await reference.set({
          'userID': user.userId,
          'name': user.name,
          'email': user.email,
          'photoUrl': user.photoURL,
          'lastSigIn': DateTime.now()
        }, SetOptions(merge: true));
      } else {
        DocumentReference reference =
            _dataBase.collection(USERS).doc(user.userId);
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
    });
    /*DocumentReference reference = _dataBase.collection(USERS).doc(user.userId);
    return await reference.set({
      'userID': user.userId,
      'name': user.name,
      'email': user.email,
      'photoUrl': user.photoURL,
      'myPlaces': user.myPlaces,
      'myFavoritePlaces': user.myFavoritePlaces,
      'lastSigIn': DateTime.now()
    }, SetOptions(merge: true));*/
  }

  Future<void> updateUserPlaceData(Place place) async {
    CollectionReference referencePlaces = _dataBase.collection(PLACES);

    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      await referencePlaces.add({
        'name': place.name,
        'description': place.description,
        'likes': place.likes,
        'userOwner': _dataBase.doc(
            "$USERS/${currentUser.uid}"), //Se guarda referencia del usuario logueado
        'urlImage': place.urlImage
      }).then((_documentReference) {
        //despues de agregar el Place, obtenemos el id de ese Place y lo agregamos a myPlaces del usuario como referencia
        _documentReference.get().then((_documentSnapshot) {
          DocumentReference refUsers = _dataBase.collection(USERS).doc(currentUser
              .uid); //Obtenemos o apuntamos a la referencia del usuario logueado
          refUsers.update({
            //Actualiza el campo myPlaces del usuario logueado con la refeerencia del Place que se guardo previamente
            //FieldValue.arrayUnion -> Agrega un elemento al final del array sin sobreescribir el elemnto anterior
            'myPlaces': FieldValue.arrayUnion(
                [_dataBase.doc("$PLACES/${_documentSnapshot.id}")])
          });
        });
      });
    } else
      print("No hay usuario logueado");
  }

  //Creamos la lista de Places con los datos obtenidos previamente de CloudFirebase
  List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot) {
    List<ProfilePlace> profilePlaces = [];
    placesListSnapshot.forEach((DocumentSnapshot place) {
      Map<String, dynamic> data = place.data()! as Map<String, dynamic>;
      profilePlaces.add(ProfilePlace(Place(
          name: data['name'],
          description: data['description'],
          urlImage: data['urlImage'],
          likes: data['likes'])));
    });
    return profilePlaces;
  }

  //Metodo para seleccionar solo los PLaces del usuario logueado
  //Se compara de acuerdo al campo 'userOwner' de la coleccion Places y
  //la refernecia del documento de 'users.uid'
  Stream<QuerySnapshot<Map<String, dynamic>>> myPlacesListStream(String uid) =>
      _dataBase
          .collection(PLACES)
          .where("userOwner", isEqualTo: _dataBase.doc("$USERS/$uid"))
          .snapshots();
}
