import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuition_app_project/Screens/HomeScreen/bloc/home_bloc.dart';
import 'package:tuition_app_project/Widgets/homeScreenButton.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  late MockHomeBloc mockhomeBloc;

  setUp(() {
    mockhomeBloc = MockHomeBloc();
  });

  testWidgets('homeScreenButton widget ...', (tester) async {
    // TODO: Implement test

    final String text = "Learn";
    final String studentId = "1234";
    final String studentName = "john doe";
    final String imagepath = "image";
    final String? meetingId = "3456";

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: homeScreenButton(text: text, homeBloc: mockhomeBloc, studentId: studentId, studentName: studentName, imagepath: imagepath, meetingId: meetingId),
      ),
    ));

    await tester.pumpAndSettle();

    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
