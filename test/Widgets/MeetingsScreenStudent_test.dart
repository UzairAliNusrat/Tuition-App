import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuition_app_project/Models/meetingRequestModel.dart';
import 'package:tuition_app_project/Screens/HomeScreen/bloc/home_bloc.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:tuition_app_project/Widgets/MeetingsScreenStudent.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  late MockHomeBloc mockhomeBloc;

  setUp(() {
    mockhomeBloc = MockHomeBloc();
  });

  testWidgets('meetingsScreenStudent widget ...', (tester) async {
    // TODO: Implement test

    final List<meetingRequestModel> meetingHistory = [meetingRequestModel(
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
          body: MeetingsScreenStudent(homeBloc: mockhomeBloc, bottomNavigationBarIndex: bottomNavigationBarIndex, meetingHistory: meetingHistory),
        ),
      ));

      await tester.pumpAndSettle();

      expect(find.text('Meeting Request History'), findsOneWidget);
      expect(find.text("Subject: ${meetingHistory[0].subject}"), findsOneWidget);
      expect(find.text("Topic: ${meetingHistory[0].topic}"), findsOneWidget);
      expect(find.text("Additonal Information:"), findsOneWidget);
      expect(find.text(meetingHistory[0].note), findsOneWidget);
    });
  });
}
