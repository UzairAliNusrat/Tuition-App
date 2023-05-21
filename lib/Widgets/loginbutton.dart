import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Auth.dart';

class login_button extends StatelessWidget {
  final String type;
  final GlobalKey<FormState> formkey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final auth = Auth();

  login_button({
    super.key,
    required this.type,
    required this.formkey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    if (type == "Login") {
      return SizedBox(
        width: 450,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          onPressed: () {
            if (formkey.currentState!.validate()) {
              auth.signIn(context, emailController.text.trim(),
                  passwordController.text.trim());
            }
          },
          child: Text(
            "Login",
            style: GoogleFonts.arvo(
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 3, 66, 102), fontSize: 18),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: 450,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.red, foregroundColor: Colors.white
            // primary: Colors.white,
            // onPrimary: Colors.black,
          ),
          onPressed: () {
            auth.signInWithGoogle(context);
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: SvgPicture.asset(
                          'assets/icons/google-plus.svg',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text('Sign In with Google', style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),
      );
    }
  }
}
