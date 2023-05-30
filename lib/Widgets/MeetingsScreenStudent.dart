import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuition_app_project/Models/meetingRequestModel.dart';

import '../Screens/HomeScreen/bloc/home_bloc.dart';
import 'bottomNavigationBar.dart';

class MeetingsScreenStudent extends StatelessWidget {
  final List<meetingRequestModel> meetingHistory;
  final HomeBloc homeBloc;
  final bottomNavigationBarIndex;
  const MeetingsScreenStudent(
      {super.key,
      required this.homeBloc,
      required this.bottomNavigationBarIndex,
      required this.meetingHistory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        title: Center(
            child: Text(
          'Meeting Request History',
          style: GoogleFonts.arvo(
            textStyle: const TextStyle(
                color: Color.fromARGB(255, 3, 66, 102), fontSize: 25),
          ),
        )),
        backgroundColor: const Color.fromARGB(255, 139, 193, 238),
        elevation: 0,
      ),
      bottomNavigationBar: bottomNavigationBar(
          index: bottomNavigationBarIndex,
          homeBloc: homeBloc,
          userType: "Student"),
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: meetingHistory.isNotEmpty
              ? ListView.builder(
                  itemCount: meetingHistory.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.cyan,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                    radius: 40,
                                    foregroundImage: NetworkImage(
                                        meetingHistory[index]
                                            .teacherimagepath)),
                                title: Text(meetingHistory[index].teacherName,
                                    style: GoogleFonts.arvo(
                                      textStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 3, 66, 102),
                                          fontSize: 20),
                                    )),
                              ),
                              ListTile(
                                title: Text(
                                    "Subject: ${meetingHistory[index].subject}",
                                    style: GoogleFonts.arvo(
                                      textStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 3, 66, 102),
                                          fontSize: 18),
                                    )),
                                subtitle: Text(
                                    "Topic: ${meetingHistory[index].topic}",
                                    style: GoogleFonts.arvo(
                                      textStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 3, 66, 102),
                                          fontSize: 18),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text("Additonal Information:",
                                    style: GoogleFonts.arvo(
                                      textStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 3, 66, 102),
                                          fontSize: 18),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, top: 7, bottom: 10),
                                child: Text(meetingHistory[index].note, style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 18),
                                  )),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text("No Meeting Request History",
                      style: GoogleFonts.arvo(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 3, 66, 102),
                            fontSize: 20),
                      )))),
    );
  }
}
