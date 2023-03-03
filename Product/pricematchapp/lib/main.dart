import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'constants.dart' as constants;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final TextEditingController username =
      TextEditingController(); //Creating the text editing controller objects - allows me to store whatever input is typed into the textfields.
  final TextEditingController password = TextEditingController();
  final _userFormKey = GlobalKey<FormState>();

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
              title: Text("Welcome"),
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
                                //Username field:
                                child: constants.customTextFormField(
                                    controller: username,
                                    hintText: "email",
                                    errorMessage: "Invalid Email",
                                    name: Icons.mail),
                              ),
                              SizedBox(height: 20.0),
                              //Password field
                              Container(
                                child: constants.customTextFormField(
                                  controller: password,
                                  hintText: "password",
                                  errorMessage: "Incorrect Password",
                                  name: CupertinoIcons.lock_fill,
                                ),

                                // child: TextFormField(
                                //     controller: password,
                                //     obscureText: true,
                                //     // validator: (String value) {
                                //     //   if (value.isEmpty) {
                                //     //     return "Invalid Password";
                                //     //   }
                                //     //   return null;
                                //     // },
                                //     decoration: InputDecoration(
                                //       prefixIcon:
                                //           Icon(CupertinoIcons.lock_fill),
                                //       hintText: "password",
                                //       contentPadding: EdgeInsets.all(10.0),
                                //       border: OutlineInputBorder(
                                //         borderRadius:
                                //             BorderRadius.circular(25),
                                //       ),
                                //     ),)
                              ),
                              SizedBox(height: 10.0),
                              CupertinoButton(
                                  onPressed: () async {
                                    // if (_userFormKey.currentState
                                    //     .validate()) {
                                    //   //Calls login method created in Auth_Service
                                    //   viewModel.loginauth.loginUser(
                                    //       username.text, password.text);
                                    // }
                                  },
                                  // onPressed:viewModel.loginButton,
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
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // viewModel.routeToSignUpView();
                                          }),
                                  )
                                ],
                              ),
                              SizedBox(height: 50),
                            ] //Children
                            ))))));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}