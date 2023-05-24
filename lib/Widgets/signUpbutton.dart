import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Auth.dart';

class signUp_button extends StatelessWidget {
  final GlobalKey<FormState> formkey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final String imagePath;
  final auth = Auth();

  signUp_button(
      {super.key,
      required this.formkey,
      required this.emailController,
      required this.passwordController,
      required this.firstNameController,
      required this.lastNameController,
      required this.imagePath});

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
            auth.signUp(
                context,
                emailController.text.trim(),
                passwordController.text.trim(),
                firstNameController.text.trim(),
                lastNameController.text.toString(),
                imagePath);
          }
          else{
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
          //Navigator.pop(context);
        },
        child: Text(
          "Sign Up",
          style: GoogleFonts.arvo(
            textStyle: const TextStyle(
                color: Color.fromARGB(255, 3, 66, 102), fontSize: 18),
          ),
        ),
      ),
    );
  }
}
