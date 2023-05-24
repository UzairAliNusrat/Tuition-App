import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tuition_app_project/Repositories/userRepository.dart';
import 'package:tuition_app_project/Screens/HomeScreen/bloc/home_bloc.dart';
import 'package:tuition_app_project/Screens/TeachScreen/teachScreen.dart';
import 'package:tuition_app_project/Widgets/MeetingList.dart';
import 'package:tuition_app_project/Widgets/bottomNavigationBar.dart';
import 'package:tuition_app_project/Widgets/homeScreenButton.dart';
import 'package:tuition_app_project/Widgets/sideDrawer.dart';
import 'package:tuition_app_project/Models/userModel.dart';

import '../../Widgets/teacherList.dart';
import '../../main.dart';
import '../LearnScreen/learnScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    final userRepo = FirebaseUserRepository();
    final currentUserFuture =
        userRepo.getUser(FirebaseAuth.instance.currentUser!.uid);
    return FutureBuilder<user?>(
      future: currentUserFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // If the future throws an error, display the error message
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else {
          homeBloc.add(HomeInitialEvent());
          // If the future is complete and returns a value, display the UI
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
                        builder: (context) => learnScreen()));
              } else if (state is HomeNavigateToTeachScreenState) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const teachScreen()));
              }
            },
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return Scaffold(
                  backgroundColor: Colors.cyan[100],

                  body: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is HomeLoadedState) {
                switch (state.selectedIndex) {
                  case 0:
                    {
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
                          backgroundColor:
                              const Color.fromARGB(255, 139, 193, 238),
                          elevation: 0,
                        ),
                        drawer: side_drawer(User: snapshot.data),
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
                                            color:
                                                Color.fromARGB(255, 3, 66, 102),
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
                                            snapshot.data?.first_name ??
                                                FirebaseAuth.instance
                                                    .currentUser?.displayName ??
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
                                        child:
                                            Text(snapshot.data?.last_name ?? "",
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
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  homeScreenButton(
                                      text: "Teach", homeBloc: homeBloc),
                                  homeScreenButton(
                                      text: "Learn", homeBloc: homeBloc),
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
                                            decoration:
                                                TextDecoration.underline,
                                            color:
                                                Color.fromARGB(255, 3, 66, 102),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(15),
                              child: meetingList(),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 7, bottom: 10),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Top Ranking Teachers",
                                      style: GoogleFonts.arvo(
                                        textStyle: const TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color:
                                                Color.fromARGB(255, 3, 66, 102),
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: teacherList(),
                            )
                          ],
                        ),
                      );
                    }

                  case 1:
                    {
                      return Scaffold(
                        backgroundColor: Colors.cyan[100],
                        body: const Center(
                            child: Text(
                          "Meetings",
                          style: TextStyle(fontSize: 20),
                        )),
                        bottomNavigationBar: bottomNavigationBar(
                            index: state.selectedIndex, homeBloc: homeBloc),
                      );
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
                return const Scaffold(
                  body: CircularProgressIndicator(),
                );
              }
            },
          );
        }
      },
    );
  }
}
