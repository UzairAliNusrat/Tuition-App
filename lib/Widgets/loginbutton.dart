import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Screens/login/bloc/login_bloc.dart';

class login_button extends StatelessWidget {
  final GlobalKey<FormState> formkey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final LoginBloc loginBloc;

  login_button(
      {required this.formkey,
      required this.emailController,
      required this.passwordController,
      required this.loginBloc});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        key: key,
        width: 450,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          onPressed: () {
            if (formkey.currentState!.validate()) {
              loginBloc.add(LoginButtonClickedEvent(
                  context: context,
                  email: emailController.text.trim(),
                  password: passwordController.text.trim()));
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
    
    //else {
      // return SizedBox(
      //   width: 450,
      //   height: 50,
      //   child: ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(30),
      //         ),
      //         backgroundColor: Colors.red,
      //         foregroundColor: Colors.white
      //         // primary: Colors.white,
      //         // onPrimary: Colors.black,
      //         ),
      //     onPressed: () {
      //       loginBloc.add(GoogleLoginButtonClickedEvent(context: context));
      //     },
      //     child: Row(
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.only(left: 35),
      //           child: SvgPicture.asset(
      //             'assets/icons/google-plus.svg',
      //             height: 20,
      //             width: 20,
      //             color: Colors.white,
      //           ),
      //         ),
      //         const Padding(
      //           padding: EdgeInsets.only(left: 20),
      //           child: Text(
      //             'Sign In with Google',
      //             style: TextStyle(fontWeight: FontWeight.bold),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // );
    //}
  }
}
