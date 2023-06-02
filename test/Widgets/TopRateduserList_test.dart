import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:tuition_app_project/Models/userModel.dart';
import 'package:tuition_app_project/Screens/HomeScreen/bloc/home_bloc.dart';
import 'package:tuition_app_project/Widgets/TopRateduserList.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  late MockHomeBloc mockhomeBloc;

  setUp(() {
    mockhomeBloc = MockHomeBloc();
  });

  testWidgets('TopRatedUserList widget ...', (tester) async {
    // TODO: Implement test

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

    final List<user> students = [
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
          body: userList(
              teachers: teachers,
              homebloc: mockhomeBloc,
              students: students),
        ),
      ));

      await tester.pumpAndSettle();

      expect(find.text("${teachers[0].first_name} ${teachers[0].last_name}"),
          findsOneWidget);
      
      expect(find.byType(OutlinedButton), findsOneWidget);
    });
  });
}
