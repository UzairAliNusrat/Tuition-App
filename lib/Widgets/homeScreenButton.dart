import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Screens/HomeScreen/bloc/home_bloc.dart';

class homeScreenButton extends StatelessWidget {
  final String text;
  final String studentId;
  final String studentName;
  final String imagepath;
  final HomeBloc homeBloc;
  final String? meetingId;

  const homeScreenButton({
    super.key,
    required this.text,
    required this.homeBloc,
    required this.studentId,
    required this.studentName,
    required this.imagepath,
    this.meetingId,
  });

  @override
  Widget build(BuildContext context) {
    if (text == "Learn") {
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
              homeBloc.add(LearnButtonClickedEvent(
                studentId: studentId,
                studentName: studentName,
                imagepath: imagepath,
              ));
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
    } else {
      return SizedBox(
          width: 150,
          height: 30,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Delete Confirmation'),
                    content: const Text('Are you sure you want to delete?'),
                    actions: [
                      ElevatedButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      ElevatedButton(
                        child: const Text('End'),
                        onPressed: () {
                          // Call the delete callback
                          homeBloc.add(EndMeetingButtonClickedEvent(
                              meetingId: meetingId!));
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Center(
              child: Text(
                text,
                style: GoogleFonts.arvo(
                  textStyle: const TextStyle(
                      color: Color.fromARGB(255, 3, 66, 102), fontSize: 18),
                ),
              ),
            ),
          ));
    }
  }
}
