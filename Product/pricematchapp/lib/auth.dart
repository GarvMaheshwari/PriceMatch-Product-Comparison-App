import 'package:firebase_auth/firebase_auth.dart';
import 'User.dart';

class Auth {
  final FirebaseAuth authService = FirebaseAuth.instance;

  Future registerUser(
      email, password, String firstName, String lastName) async {
    await authService.createUserWithEmailAndPassword(
        email: email, password: password);
    // User tempUser = User(firstName, lastName, authService.currentUser.uid);
  }
}
