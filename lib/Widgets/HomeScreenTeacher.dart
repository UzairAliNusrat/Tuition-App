import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuition_app_project/Widgets/sideDrawer.dart';
import 'package:tuition_app_project/Widgets/TopRateduserList.dart';

import '../Models/meetingAcceptedModel.dart';
import '../Models/userModel.dart';
import '../Screens/HomeScreen/bloc/home_bloc.dart';
import 'MeetingList.dart';
import 'bottomNavigationBar.dart';

class HomeScreenTeacher extends StatelessWidget {
  final HomeBloc homeBloc;
  final user User;
  final int bottomNavigationBarIndex;
  final List<meetingAcceptedModel> acceptedMeetings;
  final List<user> students;
  const HomeScreenTeacher(
      {super.key,
      required this.homeBloc,
      required this.User,
      required this.bottomNavigationBarIndex,
      required this.acceptedMeetings,
      required this.students});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        title: Center(
            child: Text(
          'Teach n Learn',
          style: GoogleFonts.arvo(
            textStyle: const TextStyle(
                color: Color.fromARGB(255, 3, 66, 102), fontSize: 30),
          ),
        )),
        actions: const [
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Opacity(
              opacity: 0,
              child: Icon(Icons.transform_sharp),
            ),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 139, 193, 238),
        elevation: 2,
      ),
      drawer: side_drawer(User: User, homeBloc: homeBloc),
      bottomNavigationBar: bottomNavigationBar(
        index: bottomNavigationBarIndex,
        homeBloc: homeBloc,
        userType: "Teacher",
      ),
      body: ListView(
        children: [
          Container(
            height: 80,
            width: double.infinity,
            color: const Color.fromARGB(255, 139, 193, 238),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Text(
                    "Welcome Back,",
                    style: GoogleFonts.arvo(
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 3, 66, 102), fontSize: 15),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(User.first_name,
                          style: GoogleFonts.arvo(
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 3, 66, 102),
                                fontSize: 25),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 3,
                      ),
                      child: Text(User.last_name,
                          style: GoogleFonts.arvo(
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 3, 66, 102),
                                fontSize: 25),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                    text: "Your Scheduled Meetings",
                    style: GoogleFonts.arvo(
                      textStyle: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color.fromARGB(255, 3, 66, 102),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: meetingList(
              acceptedMeetings: acceptedMeetings,
              User: User,
              homeBloc: homeBloc,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 7, bottom: 10),
              child: RichText(
                text: TextSpan(
                    text: "Top Rated Students",
                    style: GoogleFonts.arvo(
                      textStyle: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color.fromARGB(255, 3, 66, 102),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: userList(
              teachers: const [],
              homebloc: homeBloc,
              students: students,
              userType: "Student",
            ),
          )
        ],
      ),
    );
  }
}
