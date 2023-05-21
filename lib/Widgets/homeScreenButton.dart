import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class homeScreenButton extends StatelessWidget {
  final String text;
  const homeScreenButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 5,
        color: Colors.cyan,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: SizedBox(
          height: 100,
          width: 180,
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.arvo(
                textStyle: const TextStyle(
                    color: Color.fromARGB(255, 3, 66, 102), fontSize: 50),
              ),
            ),
          ),
        ),
      ),
      onTap: () {},
    );
  }
}
