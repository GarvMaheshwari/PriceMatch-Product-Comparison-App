import 'package:flutter/material.dart';
import 'main.dart';
import 'signup.dart';
import 'package:pricematchapp/mainMenu.dart';
import 'user.dart';

class customTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String errorMessage;
  final IconData? name;
  final Color? textColor;

  customTextFormField({
    required this.controller,
    required this.hintText,
    required this.errorMessage,
    this.name,
    this.textColor,
  });

  //custom formField widget that simplifies the calling of the customformfield
  //widget in the other files.
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

//Houses the important static variables used by most of the other classes.
class UserStack {
  static late User user;
  static String AmazonProductAPI =
      "https://api.rainforestapi.com/request?api_key=A5E0E234821C45968357BB158E4F67FD&type=search&amazon_domain=amazon.com";
  static String WalmartProductAPI =
      "https://api.bluecartapi.com/request?api_key=FE30BB06594B41229F17F6C50CA80208&search_term=";
}
