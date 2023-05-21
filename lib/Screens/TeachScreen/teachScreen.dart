import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class teachScreen extends StatelessWidget {
  const teachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan[100],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
              child: Text("Teach Screen",
                  style: GoogleFonts.arvo(
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 3, 66, 102),
                          fontSize: 30)))),
          backgroundColor: const Color.fromARGB(255, 139, 193, 238),
          // actions: const [
          //   Padding(
          //     padding: EdgeInsets.only(left: 25),
          //     child: Opacity(
          //       opacity: 0,
          //       child: Icon(Icons.transform_sharp),
          //     ),
          //   )
          // ],
        ));
  }
}
