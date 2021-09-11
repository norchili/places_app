import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:places_app/User/repository/auth_repository.dart';

class UserBloc implements Bloc {
  final _authRepository = AuthRepository();

  //Flujo de datos - Stream
  //Stream - Firebase

  Stream<User?> streamFirebase = FirebaseAuth.instance
      .authStateChanges(); //Establece o instancia que se requiere conocer el estado de la sesion en Firebase

  Stream<User?> get authStatus =>
      streamFirebase; //Devuelve el estado de la sesion

  //Caso de uso
  // Sign In a la aplicacion de Goolge
  Future<UserCredential?> signIn() {
    return _authRepository.signInFirebase();
  }

  signOut() {
    _authRepository.signOut();
  }

  @override
  void dispose() {}
}
