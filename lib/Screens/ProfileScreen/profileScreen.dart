import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuition_app_project/Models/userModel.dart';

import 'bloc/my_profile_bloc.dart';

class profileScreen extends StatelessWidget {
  final user User;
  profileScreen({super.key, required this.User});

  final MyProfileBloc MyprofileBloc = MyProfileBloc();

  @override
  Widget build(BuildContext context) {
    MyprofileBloc.add(MyProfileInitialEvent(User));
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        title: Center(
            child: Text(
          'Profile',
          style: GoogleFonts.arvo(
            textStyle: const TextStyle(
                color: Color.fromARGB(255, 3, 66, 102), fontSize: 30),
          ),
        )),
        backgroundColor: const Color.fromARGB(255, 139, 193, 238),
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Opacity(
              opacity: 0,
              child: Icon(Icons.transform_sharp),
            ),
          )
        ],
      ),
      body: BlocConsumer<MyProfileBloc, MyProfileState>(
        bloc: MyprofileBloc,
        listenWhen: (previous, current) => current is MyProfileActionState,
        buildWhen: (previous, current) => current is! MyProfileActionState,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is MyProfileLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MyProfileLoadedState) {
            return SingleChildScrollView(
                child: state.studentinfo != null
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: CircleAvatar(
                              radius: 60,
                              foregroundImage:
                                  NetworkImage(User.ProfileImagePath),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            "${User.first_name} ${User.last_name}",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            state.studentinfo!.qualification,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Rating: ${state.avgRating}",
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          RatingBar.builder(
                            initialRating: state.avgRating.toDouble(),
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            ignoreGestures: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          const SizedBox(height: 20),
                          ListTile(
                            leading: const Icon(Icons.phone),
                            title: Text(
                                "Phone Number: ${state.studentinfo!.phoneNumber}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: Text("Age: ${state.studentinfo!.age}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          ListTile(
                            leading: const Icon(Icons.email),
                            title: Text(
                              User.email,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.description),
                            title: Text(
                                "About: ${state.studentinfo!.description}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: CircleAvatar(
                              radius: 60,
                              foregroundImage:
                                  NetworkImage(User.ProfileImagePath),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            "${User.first_name} ${User.last_name}",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            state.teacherinfo!.qualification,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Rating: ${state.avgRating}",
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          RatingBar.builder(
                            initialRating: state.avgRating,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            ignoreGestures: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          const SizedBox(height: 20),
                          ListTile(
                            leading: const Icon(Icons.phone),
                            title: Text(
                                "Phone Number: ${state.teacherinfo!.phoneNumber}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: Text("Age: ${state.teacherinfo!.age}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          ListTile(
                            leading: const Icon(Icons.email),
                            title: Text(
                              User.email,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                              leading: const Icon(Icons.subject),
                              title: Text(
                                "Subjects: ${state.teacherinfo!.subjects.toString().substring(1, state.teacherinfo!.subjects.toString().length - 1)}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                          ListTile(
                            leading: const Icon(Icons.description),
                            title: Text(
                                "About: ${state.teacherinfo!.description}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ));
          } else {
            return const Text("Error Occured");
          }
        },
      ),
    );
  }
}
