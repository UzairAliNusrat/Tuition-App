import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tuition_app_project/Models/meetingAcceptedModel.dart';

class meetingList extends StatelessWidget {
  List<meetingAcceptedModel> acceptedMeetings;
  final String userType;
  meetingList({super.key, required this.acceptedMeetings, required this.userType});

  @override
  Widget build(BuildContext context) {
    if (userType == "Student"){
      return Container(
      width: double.infinity,
      height: 450,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent[100],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
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
                  children: [
                    ListTile(
                        title: Text(acceptedMeetings[index].teacherName +
                            "              " +
                            acceptedMeetings[index].date +
                            "  " +
                            acceptedMeetings[index].time)),
                    ListTile(
                      title: Text(acceptedMeetings[index].subject),
                      subtitle: Text(acceptedMeetings[index].topic),
                    ),
                    ListTile(
                      title: Text(acceptedMeetings[index].note),
                    ),
                  ],
                ));
          },
        ),
      ),
    );
    }
    else{
      return Container(
      width: double.infinity,
      height: 450,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent[100],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
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
                  children: [
                    ListTile(
                        title: Text(acceptedMeetings[index].studentName +
                            "              " +
                            acceptedMeetings[index].date +
                            "  " +
                            acceptedMeetings[index].time)),
                    ListTile(
                      title: Text(acceptedMeetings[index].subject),
                      subtitle: Text(acceptedMeetings[index].topic),
                    ),
                    ListTile(
                      title: Text(acceptedMeetings[index].note),
                    ),
                  ],
                ));
          },
        ),
      ),
    );
    }
    
  }
}
