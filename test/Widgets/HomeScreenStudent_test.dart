import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuition_app_project/Models/meetingAcceptedModel.dart';
import 'package:tuition_app_project/Models/userModel.dart';
import 'package:tuition_app_project/Screens/HomeScreen/bloc/home_bloc.dart';
import 'package:tuition_app_project/Widgets/HomeScreenStudent.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  late MockHomeBloc mockhomeBloc;

  setUp(() {
    mockhomeBloc = MockHomeBloc();
  });

  testWidgets('homeScreenStudent widget ...', (tester) async {
    // TODO: Implement test

    final user User = user(
        first_name: "john",
        last_name: "doe",
        email: "john@gmail.com",
        id: "123",
        ProfileImagePath: "image",
        UserType: "Student");

    final int bottomNavigationBarIndex = 0;

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

    final List<user> teachers = [
      user(
        first_name: 'John',
        last_name: 'Doe',
        email: 'johndoe@example.com',
        id: 'user123',
        ProfileImagePath: '/path/to/profile/image.jpg',
        UserType: 'Teacher',
      )
    ];

    mockNetworkImagesFor(() async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: HomeScreenStudent(
              homeBloc: mockhomeBloc,
              User: User,
              bottomNavigationBarIndex: bottomNavigationBarIndex,
              acceptedMeetings: acceptedMeetings,
              teachers: teachers),
        ),
      ));

      await tester.pumpAndSettle();

      expect(find.text("Teach n Learn"), findsOneWidget);
      expect(find.text("Welcome Back,"), findsOneWidget);
      expect(find.text(User.first_name), findsOneWidget);
      expect(find.text(User.last_name), findsOneWidget);
    });
  });
}
