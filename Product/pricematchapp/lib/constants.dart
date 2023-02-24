import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        // validator: (String ) {
        //   if (value.isEmpty) {
        //     return errorMessage;
        //   }
        //   return null;
        // },
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
