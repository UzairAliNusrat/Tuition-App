import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuition_app_project/Screens/HomeScreen/bloc/home_bloc.dart';
import 'package:tuition_app_project/Screens/ProfileScreen/profileScreen.dart';
import 'package:tuition_app_project/Screens/TeachScreen/teachScreen.dart';
import 'package:tuition_app_project/Screens/userListProfileScreen/userListProfileScreen.dart';
import 'package:tuition_app_project/Widgets/HomeScreenStudent.dart';
import 'package:tuition_app_project/Widgets/HomeScreenTeacher.dart';
import 'package:tuition_app_project/Widgets/MeetingsScreenStudent.dart';
import 'package:tuition_app_project/Widgets/MeetingsScreenTeacher.dart';
import 'package:tuition_app_project/Widgets/bottomNavigationBar.dart';
import '../LearnScreen/learnScreen.dart';

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
        } else if (state is HomeNavigateToListProfileScreenState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => userListProfileScreen(
                      id: state.id,
                      fullname: state.fullname,
                      imagepath: state.imagepath,
                      userType: state.userType)));
        } else if (state is HomeNavigateToProfileScreenState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => profileScreen(User: state.User)));
        }
      },
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return Scaffold(
            backgroundColor: Colors.cyan[100],
            bottomNavigationBar: bottomNavigationBar(
                index: state.selectedIndex, homeBloc: homeBloc, userType: ""),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is HomeLoadedState) {
          switch (state.selectedIndex) {
            case 0:
              {
                if (state.User.UserType == "Student") {
                  return HomeScreenStudent(
                      homeBloc: homeBloc,
                      User: state.User,
                      bottomNavigationBarIndex: state.selectedIndex,
                      acceptedMeetings: state.acceptedMeetings,
                      teachers: state.Teachers);
                } else {
                  return HomeScreenTeacher(
                      homeBloc: homeBloc,
                      User: state.User,
                      bottomNavigationBarIndex: state.selectedIndex,
                      acceptedMeetings: state.acceptedMeetings,
                      students: state.Students);
                }
              }

            case 1:
              {
                if (state.User.UserType == "Student") {
                  return MeetingsScreenStudent(
                      homeBloc: homeBloc,
                      bottomNavigationBarIndex: state.selectedIndex,
                      meetingHistory: state.meetingHistory);
                } else {
                  return MeetingsScreenTeacher(
                      homeBloc: homeBloc,
                      bottomNavigationBarIndex: state.selectedIndex,
                      meetingRequests: state.meetingRequests);
                }
              }
            case 2:
              {
                return Scaffold(
                    backgroundColor: Colors.cyan[100],
                    bottomNavigationBar: bottomNavigationBar(
                        index: state.selectedIndex,
                        homeBloc: homeBloc,
                        userType: state.User.UserType),
                    appBar: AppBar(
                      title: Center(
                          child: Text(
                        state.User.UserType == "Student"
                            ? "Teachers"
                            : "Students",
                        style: GoogleFonts.arvo(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 3, 66, 102),
                              fontSize: 30),
                        ),
                      )),
                      backgroundColor: const Color.fromARGB(255, 139, 193, 238),
                      elevation: 2,
                    ),
                    body: state.Students.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(4),
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  // crossAxisSpacing: 8,
                                  // mainAxisSpacing: 10,
                                ),
                                itemCount: state.Students.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return Container(
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlueAccent[100],
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(
                                                  state.Students[index]
                                                      .ProfileImagePath),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                                "${state.Students[index].first_name} ${state.Students[index].last_name}",
                                                style: const TextStyle(
                                                    color: Colors.black)),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: OutlinedButton(
                                              onPressed: () {
                                                homeBloc.add(
                                                    ListItemClickedEvent(
                                                        id: state
                                                            .Students[index].id,
                                                        imagepath: state
                                                            .Students[index]
                                                            .ProfileImagePath,
                                                        fullname:
                                                            "${state.Students[index].first_name} ${state.Students[index].last_name}",
                                                        userType: state
                                                            .Students[index]
                                                            .UserType));
                                              },
                                              style: OutlinedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                side: const BorderSide(
                                                    width: 2.0,
                                                    color: Colors.blue),
                                              ),
                                              child: const Text("View profile",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(4),
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  // crossAxisSpacing: 8,
                                  // mainAxisSpacing: 10,
                                ),
                                itemCount: state.Teachers.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return Container(
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlueAccent[100],
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(
                                                  state.Teachers[index]
                                                      .ProfileImagePath),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                                "${state.Teachers[index].first_name} ${state.Teachers[index].last_name}",
                                                style: const TextStyle(
                                                    color: Colors.black)),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: OutlinedButton(
                                              onPressed: () {
                                                homeBloc.add(
                                                    ListItemClickedEvent(
                                                        id: state
                                                            .Teachers[index].id,
                                                        imagepath: state
                                                            .Teachers[index]
                                                            .ProfileImagePath,
                                                        fullname:
                                                            "${state.Teachers[index].first_name} ${state.Teachers[index].last_name}",
                                                        userType: state
                                                            .Teachers[index]
                                                            .UserType));
                                              },
                                              style: OutlinedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                side: const BorderSide(
                                                    width: 2.0,
                                                    color: Colors.blue),
                                              ),
                                              child: const Text("View profile",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ));
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
