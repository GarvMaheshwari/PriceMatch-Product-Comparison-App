import 'package:flutter/material.dart';
import 'main.dart';
import 'signup.dart';
import 'package:pricematchapp/mainMenu.dart';
import 'user.dart';

class customTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String errorMessage;
  final IconData name;

  customTextFormField({
    required this.controller,
    required this.hintText,
    required this.errorMessage,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(name),
          hintText: hintText,
          contentPadding: EdgeInsets.all(10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          fillColor: Color(0xFAFFFFFF),
        ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => Login(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/signup': (context) => SignUp(),
        '/mainMenu': (context) => MainMenu(),
      },
    );
  }
}

class UserStack {
  static late User user;
  static String AmazonProductAPI =
      "https://api.rainforestapi.com/request?api_key=5C0DA93CDB0B4890A388CA240A615086&type=search&amazon_domain=amazon.com";
}
