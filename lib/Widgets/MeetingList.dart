import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuition_app_project/Models/meetingAcceptedModel.dart';

class meetingList extends StatelessWidget {
  List<meetingAcceptedModel> acceptedMeetings;
  final String userType;
  meetingList(
      {super.key, required this.acceptedMeetings, required this.userType});

  @override
  Widget build(BuildContext context) {
    if (userType == "Student") {
      return Container(
        width: double.infinity,
        height: 280,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent[100],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: acceptedMeetings.isNotEmpty ? ListView.builder(
            itemCount: acceptedMeetings.length,
            itemBuilder: (context, index) {
              return Card(
                  color: Colors.cyan,
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          title: Text(
                        "Teacher: " + acceptedMeetings[index].teacherName,
                        style: GoogleFonts.arvo(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 3, 66, 102),
                              fontSize: 20),
                        ),
                      )),
                      ListTile(
                        title:
                            Text("Subject: " + acceptedMeetings[index].subject,
                                style: GoogleFonts.arvo(
                                  textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 3, 66, 102),
                                      fontSize: 20),
                                )),
                        subtitle:
                            Text("Topic: " + acceptedMeetings[index].topic,
                                style: GoogleFonts.arvo(
                                  textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 3, 66, 102),
                                      fontSize: 20),
                                )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text("Date: " + acceptedMeetings[index].date,
                            style: GoogleFonts.arvo(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 3, 66, 102),
                                  fontSize: 20),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text("Time: " + acceptedMeetings[index].time,
                            style: GoogleFonts.arvo(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 3, 66, 102),
                                  fontSize: 20),
                            )),
                      ),
                      ListTile(
                        title: Text("Additional Information:",
                            style: GoogleFonts.arvo(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 3, 66, 102),
                                  fontSize: 20),
                            )),
                        subtitle: Text(acceptedMeetings[index].note,
                            style: GoogleFonts.arvo(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 3, 66, 102),
                                  fontSize: 20),
                            )),
                      ),
                    ],
                  ));
            },
          )
          : Center(
            child: Text("No Meetings", style: GoogleFonts.arvo(
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 3, 66, 102),
                  fontSize: 20),
            ),),
          ),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: 450,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent[100],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: acceptedMeetings.isNotEmpty ? ListView.builder(
            itemCount: acceptedMeetings.length,
            itemBuilder: (context, index) {
              return Card(
                  color: Colors.cyan,
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          title: Text(
                        "Student: " + acceptedMeetings[index].studentName,
                        style: GoogleFonts.arvo(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 3, 66, 102),
                              fontSize: 22),
                        ),
                      )),
                      ListTile(
                        title:
                            Text("Subject: " + acceptedMeetings[index].subject,
                                style: GoogleFonts.arvo(
                                  textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 3, 66, 102),
                                      fontSize: 20),
                                )),
                        subtitle:
                            Text("Topic: " + acceptedMeetings[index].topic,
                                style: GoogleFonts.arvo(
                                  textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 3, 66, 102),
                                      fontSize: 20),
                                )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text("Date: " + acceptedMeetings[index].date,
                            style: GoogleFonts.arvo(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 3, 66, 102),
                                  fontSize: 20),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text("Time: " + acceptedMeetings[index].time,
                            style: GoogleFonts.arvo(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 3, 66, 102),
                                  fontSize: 20),
                            )),
                      ),
                      ListTile(
                        title: Text("Additional Information:",
                            style: GoogleFonts.arvo(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 3, 66, 102),
                                  fontSize: 20),
                            )),
                        subtitle: Text(acceptedMeetings[index].note,
                            style: GoogleFonts.arvo(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 3, 66, 102),
                                  fontSize: 20),
                            )),
                      ),
                    ],
                  ));
            },
          )
          : Center(
            child: Text("No Meetings", style: GoogleFonts.arvo(
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 3, 66, 102),
                  fontSize: 20),
            ),),
          ),
        ),
      );
    }
  }
}
