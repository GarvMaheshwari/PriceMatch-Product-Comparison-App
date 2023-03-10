import 'package:firebase_auth/firebase_auth.dart';
import 'User.dart' as userClass;

class Auth {
  final FirebaseAuth authService = FirebaseAuth.instance;

  Future registerUser(
      email, password, String firstName, String lastName) async {
    await authService.createUserWithEmailAndPassword(
        email: email, password: password);
    userClass.User tempUser =
        userClass.User(firstName, lastName, authService.currentUser!.uid);
  }
}
