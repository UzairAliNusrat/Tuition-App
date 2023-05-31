import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuition_app_project/Models/meetingAcceptedModel.dart';
import 'package:tuition_app_project/Models/userModel.dart';
import 'package:tuition_app_project/Screens/HomeScreen/bloc/home_bloc.dart';
import 'package:tuition_app_project/Widgets/homeScreenButton.dart';

class meetingList extends StatelessWidget {
  List<meetingAcceptedModel> acceptedMeetings;
  final user User;
  final HomeBloc homeBloc;
  meetingList({super.key, required this.acceptedMeetings, required this.User, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    if (User.UserType == "Student") {
      return Container(
        width: double.infinity,
        height: 280,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent[100],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: acceptedMeetings.isNotEmpty
              ? ListView.builder(
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
                                "Teacher: ${acceptedMeetings[index].teacherName}",
                                style: GoogleFonts.arvo(
                                  textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 3, 66, 102),
                                      fontSize: 18),
                                ),
                              ),
                              subtitle: Text(
                                  "Date: ${acceptedMeetings[index].date}  Time: ${acceptedMeetings[index].time}",
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 15),
                                  )),
                              leading: CircleAvatar(
                                radius: 30,
                                foregroundImage: NetworkImage(
                                    acceptedMeetings[index].teacherimagepath),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                  "Subject: ${acceptedMeetings[index].subject}",
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 18),
                                  )),
                              subtitle: Text(
                                  "Topic: ${acceptedMeetings[index].topic}",
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 18),
                                  )),
                            ),
                            ListTile(
                              title: Text("Additional Information:",
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 18),
                                  )),
                              subtitle: Text(acceptedMeetings[index].note,
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 18),
                                  )),
                            ),
                          ],
                        ));
                  },
                )
              : Center(
                  child: Text(
                    "No Meetings",
                    style: GoogleFonts.arvo(
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 3, 66, 102), fontSize: 20),
                    ),
                  ),
                ),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent[100],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: acceptedMeetings.isNotEmpty
              ? ListView.builder(
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
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ListTile(
                                title: Text(
                                  "Student: ${acceptedMeetings[index].studentName}",
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 18),
                                  ),
                                ),
                                subtitle: Text(
                                    "Date: ${acceptedMeetings[index].date}  Time: ${acceptedMeetings[index].time}",
                                    style: GoogleFonts.arvo(
                                      textStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 3, 66, 102),
                                          fontSize: 15),
                                    )),
                                leading: CircleAvatar(
                                  radius: 30,
                                  foregroundImage: NetworkImage(
                                      acceptedMeetings[index].studentimagepath),
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                  "Subject: ${acceptedMeetings[index].subject}",
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 18),
                                  )),
                              subtitle: Text(
                                  "Topic: ${acceptedMeetings[index].topic}",
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 18),
                                  )),
                            ),
                            ListTile(
                              title: Text("Additional Information:",
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 18),
                                  )),
                              subtitle: Text(acceptedMeetings[index].note,
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 18),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10, top: 10),
                              child: Center(
                                child: homeScreenButton(text: "End Meeting", homeBloc: homeBloc, studentId: "", studentName: "", imagepath: "", meetingId: acceptedMeetings[index].meetingId,),
                              ),
                            ),
                          ],
                        ));
                  },
                )
              : Center(
                  child: Text(
                    "No Meetings",
                    style: GoogleFonts.arvo(
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 3, 66, 102), fontSize: 20),
                    ),
                  ),
                ),
        ),
      );
    }
  }
}
