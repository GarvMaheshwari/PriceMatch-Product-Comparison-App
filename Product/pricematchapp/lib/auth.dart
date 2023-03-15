import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'user.dart' as userClass;
import 'constants.dart' as constants;

class Auth {
  final FirebaseAuth authService = FirebaseAuth.instance;

  late BuildContext context;

  Future registerUser(
      email, password, String firstName, String lastName) async {
    await authService.createUserWithEmailAndPassword(
        email: email, password: password);
    userClass.User tempUser =
        userClass.User(firstName, lastName, authService.currentUser!.uid);
    constants.UserStack.user = tempUser;
  }

  Future loginUser(String email, String password, BuildContext context) async {
    try {
      await authService.signInWithEmailAndPassword(
          email: email, password: password);
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/mainMenu');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return _showErrorDialog(
            context: context,
            titleText: "Error",
            messageText: 'Whoops user doesn\'t exist');
      } else if (e.code == 'wrong-password') {
        return _showErrorDialog(
            context: context,
            titleText: "Error",
            messageText: 'Incorrect Password. Please try again.');
      }
      return;
    }
  }

//To build this function with AlertDialog I referenced an online resource. See Appendix for workscited page.
  Future<Future> _showErrorDialog({
    required BuildContext context,
    required String titleText,
    required String messageText,
  }) async {
    final Widget acknowledgeButton = FloatingActionButton(
        onPressed: () => Navigator.pop(context, 'Okay'),
        child: const Text('Okay'));

    // Alert Dialog text that notifies the error to user
    final alert = AlertDialog(
      title: Text(titleText),
      content: Text(messageText),
      actions: [
        acknowledgeButton,
      ],
    );

    // Shows the Alert Dialog to user.
    return showDialog(
      context: context,
      builder: (context) => alert,
    );
  }
}
