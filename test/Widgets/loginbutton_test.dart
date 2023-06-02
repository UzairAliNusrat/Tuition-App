import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuition_app_project/Screens/HomeScreen/bloc/home_bloc.dart';
import 'package:tuition_app_project/Screens/login/bloc/login_bloc.dart';
import 'package:tuition_app_project/Widgets/bottomNavigationBar.dart';
import 'package:tuition_app_project/Widgets/homeScreenButton.dart';
import 'package:tuition_app_project/Widgets/loginbutton.dart';

class MockLoginBloc extends Mock implements LoginBloc {}

void main() {
  late MockLoginBloc mockloginBloc;

  setUp(() {
    mockloginBloc = MockLoginBloc();
  });

  testWidgets('homeScreenButton widget ...', (tester) async {
    // TODO: Implement test

    final GlobalKey<FormState> formkey = MockFormState();
    final TextEditingController emailController = MockemailEditingController();
    final TextEditingController passwordController =
        MockpasswordEditingController();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: login_button(
            formkey: formkey,
            emailController: emailController,
            passwordController: passwordController,
            loginBloc: mockloginBloc),
      ),
    ));

    await tester.pumpAndSettle();

    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}

class MockemailEditingController extends TextEditingController {
  @override
  String get text => "email";
}

class MockpasswordEditingController extends TextEditingController {
  @override
  String get text => "password";
}

class MockFormState extends GlobalKey<FormState> {
  MockFormState() : super.constructor();
}
