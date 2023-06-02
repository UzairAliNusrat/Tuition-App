import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Screens/HomeScreen/bloc/home_bloc.dart';
import 'bottomNavigationBar.dart';

class usersScreen extends StatelessWidget {
  final HomeBloc homeBloc;
  final HomeLoadedState state;
  const usersScreen({super.key, required this.homeBloc, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan[100],
        bottomNavigationBar: bottomNavigationBar(
            index: state.selectedIndex,
            homeBloc: homeBloc,
            userType: state.User.UserType),
        appBar: AppBar(
          title: Center(
              child: Text(
            state.User.UserType == "Student" ? "Teachers" : "Students",
            style: GoogleFonts.arvo(
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 3, 66, 102), fontSize: 30),
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
                          border: Border.all(
                            color: const Color.fromARGB(255, 3, 66, 102),
                            width: 3,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                      state.Students[index].ProfileImagePath),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "${state.Students[index].first_name} ${state.Students[index].last_name}",
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: OutlinedButton(
                                  onPressed: () {
                                    homeBloc.add(ListItemClickedEvent(
                                        id: state.Students[index].id,
                                        imagepath: state
                                            .Students[index].ProfileImagePath,
                                        fullname:
                                            "${state.Students[index].first_name} ${state.Students[index].last_name}",
                                        userType:
                                            state.Students[index].UserType));
                                  },
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    side: const BorderSide(
                                        width: 2.0, color: Colors.blue),
                                  ),
                                  child: Text(
                                    "View profile",
                                    style: GoogleFonts.arvo(
                                      textStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 3, 66, 102),
                                          fontSize: 15),
                                    ),
                                  ),
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
                          border: Border.all(
                            color: const Color.fromARGB(255, 3, 66, 102),
                            width: 3,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                      state.Teachers[index].ProfileImagePath),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "${state.Teachers[index].first_name} ${state.Teachers[index].last_name}",
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: OutlinedButton(
                                  onPressed: () {
                                    homeBloc.add(ListItemClickedEvent(
                                        id: state.Teachers[index].id,
                                        imagepath: state
                                            .Teachers[index].ProfileImagePath,
                                        fullname:
                                            "${state.Teachers[index].first_name} ${state.Teachers[index].last_name}",
                                        userType:
                                            state.Teachers[index].UserType));
                                  },
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    side: const BorderSide(
                                        width: 2.0, color: Colors.blue),
                                  ),
                                  child: Text(
                                    "View profile",
                                    style: GoogleFonts.arvo(
                                      textStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 3, 66, 102),
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ));
  }
}
