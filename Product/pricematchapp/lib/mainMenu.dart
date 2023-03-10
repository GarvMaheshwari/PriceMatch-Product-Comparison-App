import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
        centerTitle: true,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF185E83),
      ),
    );
  }
}
