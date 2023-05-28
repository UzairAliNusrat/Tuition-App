import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tuition_app_project/Repositories/userRepository.dart';
import 'package:tuition_app_project/Screens/HomeScreen/bloc/home_bloc.dart';
import 'package:tuition_app_project/Screens/TeachScreen/teachScreen.dart';
import 'package:tuition_app_project/Screens/TeacherProfileScreen/TeacherProfileScreen.dart';
import 'package:tuition_app_project/Utils/constants.dart';
import 'package:tuition_app_project/Widgets/MeetingList.dart';
import 'package:tuition_app_project/Widgets/bottomNavigationBar.dart';
import 'package:tuition_app_project/Widgets/homeScreenButton.dart';
import 'package:tuition_app_project/Widgets/sideDrawer.dart';
import 'package:tuition_app_project/Models/userModel.dart';
import '../../Widgets/teacherList.dart';
import '../LearnScreen/learnScreen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    homeBloc.add(HomeInitialEvent(FirebaseAuth.instance.currentUser!.uid));
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        // TODO: implement listener
        if (state is HomeNavigateToLearnScreenState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => learnScreen(
                        studentId: state.id,
                        studentName: state.studentName,
                        studentPicturePath: state.imagepath,
                      )));
        } else if (state is HomeNavigateToTeachScreenState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const teachScreen()));
        } else if (state is HomeNavigateToTeacherProfileScreenState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => teacherProfileScreen(
                      id: state.id,
                      fullname: state.fullname,
                      imagepath: state.imagepath)));
        }
      },
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return Scaffold(
            backgroundColor: Colors.cyan[100],
            bottomNavigationBar:
                bottomNavigationBar(index: 0, homeBloc: homeBloc),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is HomeLoadedState) {
          switch (state.selectedIndex) {
            case 0:
              {
                if (state.User.UserType == "Student") {
                  return Scaffold(
                    backgroundColor: Colors.cyan[100],
                    appBar: AppBar(
                      title: Center(
                          child: Text(
                        'Teach n Learn',
                        style: GoogleFonts.arvo(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 3, 66, 102),
                              fontSize: 30),
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
                      elevation: 0,
                    ),
                    drawer: side_drawer(User: state.User),
                    bottomNavigationBar: bottomNavigationBar(
                        index: state.selectedIndex, homeBloc: homeBloc),
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
                                padding:
                                    const EdgeInsets.only(left: 20, top: 5),
                                child: Text(
                                  "Welcome Back,",
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 25),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: Text(
                                        state.User.first_name ??
                                            FirebaseAuth.instance.currentUser
                                                ?.displayName ??
                                            "",
                                        style: GoogleFonts.arvo(
                                          textStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 3, 66, 102),
                                              fontSize: 25),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 3,
                                    ),
                                    child: Text(state.User.last_name ?? "",
                                        style: GoogleFonts.arvo(
                                          textStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 3, 66, 102),
                                              fontSize: 25),
                                        )),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 100, right: 100),
                          child: homeScreenButton(
                            text: "Learn",
                            homeBloc: homeBloc,
                            studentId: state.User.id,
                            studentName: state.User.first_name +
                                " " +
                                state.User.last_name,
                            imagepath: state.User.ProfileImagePath,
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
                              acceptedMeetings: state.acceptedMeetings, userType: "Student",),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 7, bottom: 10),
                            child: RichText(
                              text: TextSpan(
                                  text: "Top Ranking Teachers",
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
                          child: teacherList(
                            teachers: state.Teachers,
                            homebloc: homeBloc,
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Scaffold(
                    backgroundColor: Colors.cyan[100],
                    appBar: AppBar(
                      title: Center(
                          child: Text(
                        'Teach n Learn',
                        style: GoogleFonts.arvo(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 3, 66, 102),
                              fontSize: 30),
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
                      elevation: 0,
                    ),
                    drawer: side_drawer(User: state.User),
                    bottomNavigationBar: bottomNavigationBar(
                        index: state.selectedIndex, homeBloc: homeBloc),
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
                                padding:
                                    const EdgeInsets.only(left: 20, top: 5),
                                child: Text(
                                  "Welcome Back,",
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 25),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: Text(
                                        state.User.first_name ??
                                            FirebaseAuth.instance.currentUser
                                                ?.displayName ??
                                            "",
                                        style: GoogleFonts.arvo(
                                          textStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 3, 66, 102),
                                              fontSize: 25),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 3,
                                    ),
                                    child: Text(state.User.last_name ?? "",
                                        style: GoogleFonts.arvo(
                                          textStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 3, 66, 102),
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
                              acceptedMeetings: state.acceptedMeetings, userType: "Teacher",),
                        ),
                        // Center(
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(top: 7, bottom: 10),
                        //     child: RichText(
                        //       text: TextSpan(
                        //           text: "Top Ranking Teachers",
                        //           style: GoogleFonts.arvo(
                        //             textStyle: const TextStyle(
                        //                 decoration: TextDecoration.underline,
                        //                 color: Color.fromARGB(255, 3, 66, 102),
                        //                 fontSize: 20,
                        //                 fontWeight: FontWeight.bold),
                        //           )),
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: teacherList(
                        //     teachers: state.Teachers,
                        //     homebloc: homeBloc,
                        //   ),
                        // )
                      ],
                    ),
                  );
                }
              }

            case 1:
              {
                if (state.User.UserType == "Student") {
                  return Scaffold(
                    backgroundColor: Colors.cyan[100],
                    appBar: AppBar(
                      title: Center(
                          child: Text(
                        'Meeting Requests',
                        style: GoogleFonts.arvo(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 3, 66, 102),
                              fontSize: 30),
                        ),
                      )),
                      // actions: const [
                      //   Padding(
                      //     padding: EdgeInsets.only(left: 25),
                      //     child: Opacity(
                      //       opacity: 0,
                      //       child: Icon(Icons.transform_sharp),
                      //     ),
                      //   )
                      // ],
                      backgroundColor: const Color.fromARGB(255, 139, 193, 238),
                      elevation: 0,
                    ),
                    bottomNavigationBar: bottomNavigationBar(
                        index: state.selectedIndex, homeBloc: homeBloc),
                    body: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: ListView.builder(
                        itemCount: state.meetingRequests.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.blue[100],
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                          radius: 40,
                                          foregroundImage: FileImage(File(state
                                              .meetingRequests[index]
                                              .teacherimagepath))),
                                      title: Text(state
                                          .meetingRequests[index].teacherName),
                                    ),
                                    ListTile(
                                      title: Text("Subject: " +
                                          state.meetingRequests[index].subject),
                                      subtitle: Text("Topic: " +
                                          state.meetingRequests[index].topic),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 210),
                                      child: Text("Additonal Information:"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 275, top: 7, bottom: 10),
                                      child: Text(
                                          state.meetingRequests[index].note),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return Scaffold(
                    backgroundColor: Colors.cyan[100],
                    appBar: AppBar(
                      title: Center(
                          child: Text(
                        'Meeting Requests',
                        style: GoogleFonts.arvo(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 3, 66, 102),
                              fontSize: 30),
                        ),
                      )),
                      // actions: const [
                      //   Padding(
                      //     padding: EdgeInsets.only(left: 25),
                      //     child: Opacity(
                      //       opacity: 0,
                      //       child: Icon(Icons.transform_sharp),
                      //     ),
                      //   )
                      // ],
                      backgroundColor: const Color.fromARGB(255, 139, 193, 238),
                      elevation: 0,
                    ),
                    bottomNavigationBar: bottomNavigationBar(
                        index: state.selectedIndex, homeBloc: homeBloc),
                    body: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: ListView.builder(
                        itemCount: state.meetingRequests.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.blue[100],
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                          radius: 40,
                                          foregroundImage: FileImage(File(state
                                              .meetingRequests[index]
                                              .Studentimagepath))),
                                      title: Text(state
                                          .meetingRequests[index].studentName),
                                      trailing: SizedBox(
                                        width: 120,
                                        height: 50,
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              width: 50,
                                              height: 50,
                                              child: IconButton(
                                                  color: Colors.green,
                                                  onPressed: () async {
                                                    var date =
                                                        await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime.now(),
                                                            lastDate: DateTime(
                                                                2023,
                                                                12,
                                                                31,
                                                                23,
                                                                59));
                                                    var time =
                                                        await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                const TimeOfDay(
                                                                    hour: 12,
                                                                    minute: 0));
                                                    if (date != null &&
                                                        time != null) {
                                                      var formattedDate =
                                                          DateFormat(
                                                                  'MM/dd/yyyy')
                                                              .format(date);
                                                      var formattedTime =
                                                          time.hour.toString() +
                                                              ":" +
                                                              time.minute
                                                                  .toString();
                                                      homeBloc.add(MeetingRequestTickButtonClickedEvent(
                                                          meetingId: state
                                                              .meetingRequests[
                                                                  index]
                                                              .meetingId,
                                                          teacherId: state
                                                              .meetingRequests[
                                                                  index]
                                                              .teacherId,
                                                          studentName: state
                                                              .meetingRequests[
                                                                  index]
                                                              .studentName,
                                                          imagepath: state
                                                              .meetingRequests[
                                                                  index]
                                                              .Studentimagepath,
                                                          studentId: state
                                                              .meetingRequests[
                                                                  index]
                                                              .studentId,
                                                          subject: state
                                                              .meetingRequests[
                                                                  index]
                                                              .subject,
                                                          topic: state
                                                              .meetingRequests[
                                                                  index]
                                                              .topic,
                                                          note: state
                                                              .meetingRequests[
                                                                  index]
                                                              .note,
                                                          teacherName: state
                                                              .meetingRequests[
                                                                  index]
                                                              .teacherName,
                                                          date: formattedDate,
                                                          time: formattedTime));
                                                    }
                                                  },
                                                  icon:
                                                      const Icon(Icons.check)),
                                            ),
                                            const Spacer(),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              width: 50,
                                              height: 50,
                                              child: IconButton(
                                                  color: Colors.red,
                                                  onPressed: () {},
                                                  icon:
                                                      const Icon(Icons.close)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("Subject: " +
                                          state.meetingRequests[index].subject),
                                      subtitle: Text("Topic: " +
                                          state.meetingRequests[index].topic),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 210),
                                      child: Text("Additonal Information:"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 275, top: 7, bottom: 10),
                                      child: Text(
                                          state.meetingRequests[index].note),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              }
            case 2:
              {
                return Scaffold(
                  backgroundColor: Colors.cyan[100],
                  body: const Center(
                      child: Text(
                    "Chat",
                    style: TextStyle(fontSize: 20),
                  )),
                  bottomNavigationBar: bottomNavigationBar(
                      index: state.selectedIndex, homeBloc: homeBloc),
                );
              }
            default:
              {
                //statements;
                return Scaffold(
                  backgroundColor: Colors.cyan[100],
                  body: const Center(
                      child: Text(
                    "Something went wrong",
                    style: TextStyle(fontSize: 20),
                  )),
                );
              }
          }
        } else {
          return Container();
        }
      },
    );
  }
}
