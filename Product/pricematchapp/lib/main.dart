import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'signup.dart';
import 'constants.dart' as constants;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'auth.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const constants.MyApp());
}

class Login extends StatelessWidget {
  final TextEditingController username = TextEditingController();
  //Creating the text editing controller objects
  //allows me to store whatever input is typed into the textfields.
  final TextEditingController password = TextEditingController();
  final _userFormKey = GlobalKey<FormState>();
  final firebaseAuth = new Auth();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              toolbarHeight: 60,
              automaticallyImplyLeading: false,
              backgroundColor: Color(0xFF185E83),
              title: Text("Welcome to PriceMatch"),
            ),
            body: Container(
                height: double.infinity,
                width: double.infinity,
                color: Color.fromARGB(255, 159, 215, 206),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                        key: _userFormKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 400,
                                //Email field:
                                child: constants.customTextFormField(
                                    controller: username,
                                    hintText: "email",
                                    errorMessage: "Invalid Email",
                                    name: Icons.mail),
                              ),
                              SizedBox(height: 20.0),
                              //Password field - made use of a textformfield instead of custom
                              //in order to enable obscure text
                              Container(
                                  width: 400,
                                  child: TextFormField(
                                    controller: password,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(CupertinoIcons.lock_fill),
                                      hintText: "password",
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  )),
                              SizedBox(height: 10.0),
                              CupertinoButton(
                                  onPressed: () async {
                                    firebaseAuth.loginUser(
                                        username.text, password.text, context);
                                  },
                                  child: const Text(
                                    'Log-in',
                                  ),
                                  padding: EdgeInsets.all(15),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color.fromRGBO(194, 119, 20, 0.988)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 50, 0, 0)),
                                  RichText(
                                    text: TextSpan(
                                        text: "Create Account",
                                        style: TextStyle(
                                          color: Color.fromRGBO(24, 94, 131, 1),
                                        ),
                                        //On tap routes to the signup page.
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushNamed(
                                                context, '/signup');
                                            // MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         const SignUp()),
                                          }),
                                  ),
                                ],
                              ),
                              SizedBox(height: 50),
                            ] //Children
                            ))))));
  }
}
