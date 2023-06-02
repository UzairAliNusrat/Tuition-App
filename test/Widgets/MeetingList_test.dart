import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:tuition_app_project/Models/meetingAcceptedModel.dart';
import 'package:tuition_app_project/Models/userModel.dart';
import 'package:tuition_app_project/Screens/HomeScreen/bloc/home_bloc.dart';
import 'package:tuition_app_project/Widgets/MeetingList.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  late MockHomeBloc mockhomeBloc;

  setUp(() {
    mockhomeBloc = MockHomeBloc();
  });

  testWidgets('meetingList widget ...', (tester) async {
    // TODO: Implement test

    final user User = user(
        first_name: "john",
        last_name: "doe",
        email: "john@gmail.com",
        id: "123",
        ProfileImagePath: "image",
        UserType: "Student");

    final List<meetingAcceptedModel> acceptedMeetings = [
      meetingAcceptedModel(
        meetingId: '1',
        teacherId: 'teacher123',
        studentId: 'student456',
        studentName: 'John Doe',
        studentimagepath: 'path/to/image',
        subject: 'Math',
        topic: 'Algebra',
        note: 'Please bring your textbook.',
        date: '2023-06-01',
        time: '10:00 AM',
        teacherName: 'Jane Smith',
        teacherimagepath: 'path/to/image',
      )
    ];

    mockNetworkImagesFor(() async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: meetingList(
              acceptedMeetings: acceptedMeetings,
              User: User,
              homeBloc: mockhomeBloc),
        ),
      ));

      await tester.pumpAndSettle();

      expect(find.text("Teacher: ${acceptedMeetings[0].teacherName}"),
          findsOneWidget);
      expect(
          find.text(
              "Date: ${acceptedMeetings[0].date}  Time: ${acceptedMeetings[0].time}"),
          findsOneWidget);
      expect(
          find.text("Subject: ${acceptedMeetings[0].subject}"), findsOneWidget);
      expect(find.text("Topic: ${acceptedMeetings[0].topic}"), findsOneWidget);
      expect(find.text("Additional Information:"), findsOneWidget);
      expect(find.text(acceptedMeetings[0].note), findsOneWidget);
    });
  });
}
