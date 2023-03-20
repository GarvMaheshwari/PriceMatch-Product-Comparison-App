import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart' as constants;

import 'auth.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final _userFormKey = GlobalKey<FormState>();
  final firebaseAuth = Auth();
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmPass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register for an Account'),
          centerTitle: true,
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF185E83),
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
                          //First Name Field
                          Container(
                            width: 400,
                            child: constants.customTextFormField(
                                controller: firstName,
                                hintText: "First Name",
                                errorMessage: "Name",
                                name: CupertinoIcons.person),
                          ),
                          SizedBox(height: 20.0),
                          //LastName Field
                          Container(
                            width: 400,
                            child: constants.customTextFormField(
                              controller: lastName,
                              hintText: "Last Name",
                              errorMessage: "Name",
                              name: CupertinoIcons.person,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          //Password field
                          Container(
                            width: 400,
                            child: constants.customTextFormField(
                              controller: email,
                              hintText: "Email",
                              errorMessage: "Enter valid Email",
                              name: CupertinoIcons.mail_solid,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          //Password field
                          Container(
                            width: 400,
                            child: constants.customTextFormField(
                              controller: password,
                              hintText: "Password",
                              errorMessage: "Enter a strong password!",
                              name: CupertinoIcons.lock_fill,
                            ),
                          ),

                          const SizedBox(height: 10.0),
                          CupertinoButton(
                              onPressed: () async {
                                //calling method to register users with parameters being the textformfield inputs.
                                firebaseAuth.registerUser(
                                    email.text,
                                    password.text,
                                    firstName.text,
                                    lastName.text);

                                //disposing of contents inside the text editing controller
                                // name.dispose();
                                // lastName.dispose();
                                // email.dispose();
                                // password.dispose();

                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Create!',
                              ),
                              padding: EdgeInsets.all(15),
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromRGBO(194, 119, 20, 0.988)),
                          SizedBox(height: 50),
                        ] //Children
                        )))));
  }
}
