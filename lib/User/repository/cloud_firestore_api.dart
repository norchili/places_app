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
  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) {
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

  //Metodo para mostrar todos los Places en la pantalla de home
  //Asi como definir que Places ya se le ha dado like por parte
  //del usuario loguado
  List<Place> buildPlaces(
      List<DocumentSnapshot> placesListSnapshot, modelUser.User user) {
    List<Place> places = [];

    placesListSnapshot.forEach((DocumentSnapshot place) {
      bool isLiked = false;
      //Obtenemos referencia del usuario
      //DocumentReference refUser = _dataBase.doc("$USERS/${user.userId}");

      Map<String, dynamic> data = place.data()! as Map<String, dynamic>;

      //Guardamos la lista de usuarios que les gusta el lugar
      List<dynamic>? usersLiked = data['usersLiked'];

      if (usersLiked != null) {
        usersLiked.forEach((userLiked) {
          //Guardamos cada elemento y lo seteamos como de tipo DocumentReference
          DocumentReference userReference = userLiked;

          //Comparamos id del usuario que le dio like con el id del usuario que se encuentra logueado
          //Si es igual seteamos la variable isLiked = true para controlar el boton de corazon se rellene para este usuario
          if (userReference.id == user.userId) {
            isLiked = true;
          } else {
            isLiked = false;
          }
        });
      } else {
        isLiked = false;
        print("No hay likes de ningun usuario");
      }

      places.add(Place(
          id: place.id,
          likes: data['likes'],
          name: data['name'],
          description: data['description'],
          urlImage: data['urlImage'],
          liked: isLiked));
    });
    return places;
  }

  //Metodo para incrementar en 1 los likes de un PLACE
  //Primero se obtiene los likes que tiene actualmente el PLACE utilizando el "idPlace"
  //Despues se le incrementa en 1 y se guarda en la Base de datos de CloudFirebase
  Future likePlace(Place place, String userId) async {
    await _dataBase.collection(PLACES).doc(place.id).get().then((snapshot) {
      int likes = snapshot.data()!['likes']; //Se obtinen de la BD los likes

      _dataBase.collection(PLACES).doc(place.id).update({
        //Si se le dio like se incrementa, si se le dio dislike se decrementa
        'likes': place.liked ? likes + 1 : likes - 1,
        //Si se le dio like el usuario se guarda su referencia, si le dio dislike el usuario se eleimina la referencia de la lista
        'usersLiked': place.liked
            ? FieldValue.arrayUnion([_dataBase.doc("$USERS/$userId")])
            : FieldValue.arrayRemove([_dataBase.doc("$USERS/$userId")])
      }); //Se incrementa un like y se guarda en la BD
    });
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
