import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../Models/meetingRequestModel.dart';
import '../Screens/HomeScreen/bloc/home_bloc.dart';
import 'bottomNavigationBar.dart';

class MeetingsScreenTeacher extends StatelessWidget {
  final List<meetingRequestModel> meetingRequests;
  final HomeBloc homeBloc;
  final bottomNavigationBarIndex;
  const MeetingsScreenTeacher(
      {super.key,
      required this.homeBloc,
      required this.bottomNavigationBarIndex,
      required this.meetingRequests});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        title: Center(
            child: Text(
          'Meeting Requests',
          style: GoogleFonts.arvo(
            textStyle: const TextStyle(
                color: Color.fromARGB(255, 3, 66, 102), fontSize: 30),
          ),
        )),
        backgroundColor: const Color.fromARGB(255, 139, 193, 238),
        elevation: 0,
      ),
      bottomNavigationBar: bottomNavigationBar(
          index: bottomNavigationBarIndex,
          homeBloc: homeBloc,
          userType: "Teacher"),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: meetingRequests.isNotEmpty
            ? ListView.builder(
                itemCount: meetingRequests.length,
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
                                      meetingRequests[index].Studentimagepath)),
                              title: Text(meetingRequests[index].studentName,
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 19),
                                  )),
                              trailing: SizedBox(
                                width: 120,
                                height: 50,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      width: 50,
                                      height: 50,
                                      child: IconButton(
                                          color: Colors.green,
                                          onPressed: () async {
                                            var date = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(
                                                    2023, 12, 31, 23, 59));
                                            var time = await showTimePicker(
                                                context: context,
                                                initialTime: const TimeOfDay(
                                                    hour: 12, minute: 0));
                                            if (date != null && time != null) {
                                              var formattedDate =
                                                  DateFormat('MM/dd/yyyy')
                                                      .format(date);
                                              var formattedTime =
                                                  DateFormat('hh:mm a').format(
                                                DateTime(0, 0, 0, time.hour,
                                                    time.minute),
                                              );
                                              ;
                                              homeBloc.add(MeetingRequestTickButtonClickedEvent(
                                                  meetingId: meetingRequests[index]
                                                      .meetingId,
                                                  teacherId:
                                                      meetingRequests[index]
                                                          .teacherId,
                                                  studentName:
                                                      meetingRequests[index]
                                                          .studentName,
                                                  studentimagepath:
                                                      meetingRequests[index]
                                                          .Studentimagepath,
                                                  studentId:
                                                      meetingRequests[index]
                                                          .studentId,
                                                  subject:
                                                      meetingRequests[index]
                                                          .subject,
                                                  topic: meetingRequests[index]
                                                      .topic,
                                                  note: meetingRequests[index]
                                                      .note,
                                                  teacherName:
                                                      meetingRequests[index]
                                                          .teacherName,
                                                  date: formattedDate,
                                                  time: formattedTime,
                                                  teacherimagepath:
                                                      meetingRequests[index]
                                                          .teacherimagepath));
                                            }
                                          },
                                          icon: const Icon(Icons.check)),
                                    ),
                                    const Spacer(),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      width: 50,
                                      height: 50,
                                      child: IconButton(
                                          color: Colors.red,
                                          onPressed: () {
                                            homeBloc.add(
                                                MeetingRequestCrossButtonClickedEvent(
                                                    meetingId:
                                                        meetingRequests[index]
                                                            .meetingId));
                                          },
                                          icon: const Icon(Icons.close)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                  "Subject: ${meetingRequests[index].subject}",
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 19),
                                  )),
                              subtitle: Text(
                                  "Topic: ${meetingRequests[index].topic}",
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 19),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text("Additonal Information:",
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 19),
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, bottom: 10),
                              child: Text(meetingRequests[index].note,
                                  style: GoogleFonts.arvo(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 3, 66, 102),
                                        fontSize: 19),
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
                child: Text("No Meeting Requests",
                    style: GoogleFonts.arvo(
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 3, 66, 102), fontSize: 20),
                    ))),
      ),
    );
  }
}
