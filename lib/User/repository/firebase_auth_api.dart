import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //Metodo para inciar sesion primero en Google y luego en firebase
  Future<UserCredential?> signIn() async {
    GoogleSignInAccount? googleSignInAccount;

    //Primera autenticacion con Google
    // Trigger the authentication flow
    try {
      googleSignInAccount = await googleSignIn
          .signIn(); //aparece ventana o cuadro de dialogo para seleccionar cuenta de Google
    } catch (error) {
      print("Error al mostrar la ventana de cuentas de Google: error: $error");
    }
    // Obtain the auth details from the request
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication? googleAuthentication;
      try {
        googleAuthentication = await googleSignInAccount
            .authentication; //Obtenemos las credenciales de la cuenta de Goolge seleccionada
      } catch (error) {
        print(
            "Error al obtener las credenciales de la cuenta de Google: error: $error");
      }

      OAuthCredential? credential;
      // Create a new credential
      if (googleAuthentication != null) {
        credential = GoogleAuthProvider.credential(
            accessToken: googleAuthentication.accessToken,
            idToken: googleAuthentication.idToken);
      } else {
        print("Objeto credentials vacio");
      }

      //Segunda autenticacion con Firebase
      // Once signed in on Google, return the UserCredential of Firebase
      if (credential != null) {
        try {
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          return userCredential;
        } catch (e) {
          print("Error al autenticar con firebase: error: $e");
        }
      }
    } else
      return null;
  }

  //Metodo para cerrar la sesion en Firebase y Google
  signOut() async {
    await googleSignIn
        .signOut()
        .then((value) => print("Sesion de Google cerrada"));
    await _auth.signOut().then((value) => print("Sesión de Firebase Cerrada"));
  }
}
