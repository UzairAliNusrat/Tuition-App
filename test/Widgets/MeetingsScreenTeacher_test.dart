import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuition_app_project/Models/meetingRequestModel.dart';
import 'package:tuition_app_project/Screens/HomeScreen/bloc/home_bloc.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:tuition_app_project/Widgets/MeetingsScreenTeacher.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  late MockHomeBloc mockhomeBloc;

  setUp(() {
    mockhomeBloc = MockHomeBloc();
  });

  testWidgets('meetingsScreenTeacher widget ...', (tester) async {
    // TODO: Implement test

    final List<meetingRequestModel> meetingRequests = [meetingRequestModel(
        meetingId: '1',
        teacherId: 'teacher123',
        studentId: 'student456',
        studentName: 'John Doe',
        Studentimagepath: 'path/to/image',
        subject: 'Math',
        topic: 'Algebra',
        note: 'Please bring your textbook.',
        teacherName: 'Jane Smith',
        teacherimagepath: 'path/to/image',
      )];

    final int bottomNavigationBarIndex = 1;


    mockNetworkImagesFor(() async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MeetingsScreenTeacher(homeBloc: mockhomeBloc, bottomNavigationBarIndex: bottomNavigationBarIndex, meetingRequests: meetingRequests),
        ),
      ));

      await tester.pumpAndSettle();

      expect(find.text('Meeting Requests'), findsNWidgets(2));
      expect(find.text(meetingRequests[0].studentName), findsOneWidget);
      expect(find.text("Subject: ${meetingRequests[0].subject}"), findsOneWidget);
      expect(find.text("Topic: ${meetingRequests[0].topic}"), findsOneWidget);
      expect(find.text("Additonal Information:"), findsOneWidget);
      expect(find.text(meetingRequests[0].note), findsOneWidget);
    });
  });
}
