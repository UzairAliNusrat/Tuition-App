import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuition_app_project/Screens/signUp/bloc/sign_up_bloc.dart';
import 'package:tuition_app_project/Screens/signUp/signup.dart';

import '../Auth.dart';

class signUp_button extends StatelessWidget {
  final GlobalKey<FormState> formkey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final String imagePath;
  final String userType;
  final auth = Auth();
  final SignUpBloc signUpBloc;

  signUp_button(
      {super.key,
      required this.formkey,
      required this.emailController,
      required this.passwordController,
      required this.firstNameController,
      required this.lastNameController,
      required this.imagePath,
      required this.userType,
      required this.signUpBloc});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        onPressed: () {
          if (formkey.currentState!.validate() && imagePath != "") {
            signUpBloc.add(SignUpButtonClickedEvent(
                context: context,
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
                firstName: firstNameController.text.trim(),
                lastName: lastNameController.text.trim(),
                imagePath: imagePath,
                userType: userType));
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Error"),
                    content: const Text("Please complete the form"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"))
                    ],
                  );
                });
          }
        },
        child: Text(
          "Next",
          style: GoogleFonts.arvo(
            textStyle: const TextStyle(
                color: Color.fromARGB(255, 3, 66, 102), fontSize: 18),
          ),
        ),
      ),
    );
  }
}
