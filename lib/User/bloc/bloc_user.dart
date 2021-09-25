import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:places_app/Place/model/place.dart';
import 'package:places_app/Place/repository/firebase_storage_repository.dart';
import 'package:places_app/User/model/user.dart' as userModel;
import 'package:places_app/User/repository/auth_repository.dart';
import 'package:places_app/User/repository/cloud_firestore_repository.dart';

class UserBloc implements Bloc {
  final _authRepository = AuthRepository();
  final _firebaseStorageRepository = FirebaseStorageRepository();

  //Flujo de datos - Stream
  //Stream - Firebase

  Stream<User?> streamFirebase = FirebaseAuth.instance
      .authStateChanges(); //Establece o instancia que se requiere conocer el estado de la sesion en Firebase

  Stream<User?> get authStatus =>
      streamFirebase; //Devuelve el estado de la sesion

  Future<User?> currentUser() {
    return _authRepository.currentUser();
  }

  //Caso de uso
  // Sign In en Firebase con las credenciales de Goolge
  Future<UserCredential?> signIn() {
    return _authRepository.signInFirebase();
  }

  signOut() {
    _authRepository.signOut();
  }

  //Caso de uso
  //Registrar Usuario si no existe o actualizar Usuario si existe en Base de datos de Firestore
  final _cloudFirestoreRepository = CloudFirestoreRepository();

  void updateUserData(userModel.User user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);

  Future<void> updateUserPlaceData(Place place) =>
      _cloudFirestoreRepository.updateUserPlaceData(place);

  //Guardar imagen en la FirebaseStorage
  Future<UploadTask> uploadFile(String path, File image) =>
      _firebaseStorageRepository.uploadFile(path, image);

  @override
  void dispose() {}
}
