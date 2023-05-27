import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Screens/HomeScreen/bloc/home_bloc.dart';

class homeScreenButton extends StatelessWidget {
  final String text;
  final String studentId;
  final HomeBloc homeBloc;
  const homeScreenButton(
      {super.key, required this.text, required this.homeBloc, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 170,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            if (text == "Learn") {
              homeBloc.add(LearnButtonClickedEvent(studentId));
            }
            else if(text == "Teach"){
              homeBloc.add(TeachButtonClickedEvent());
            }
          },
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.arvo(
                textStyle: const TextStyle(
                    color: Color.fromARGB(255, 3, 66, 102), fontSize: 30),
              ),
            ),
          ),
        ));
  }
}
