import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuition_app_project/Screens/login/bloc/login_bloc.dart';
import 'package:tuition_app_project/Screens/login/login.dart';
import 'package:tuition_app_project/Widgets/loginbutton.dart';

void main() {
  testWidgets('Login page displays correctly', (WidgetTester tester) async {
    //await tester.pumpWidget(MaterialApp(home: Login()));


  final loginBloc = LoginBloc();
  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider<LoginBloc>.value(
        value: loginBloc,
        child: Login(),
      ),
    ),
  );

  //expect(find.text("Teach n Learn"), findsOneWidget);

    //expect(find.text("Teach n Learn"), findsOneWidget);
    // expect(find.byKey(const Key("login button")), findsOneWidget);

    // expect(find.text('Login'), findsNWidgets(2));
    // expect(find.text('Dont have an account?'), findsOneWidget);
    // expect(find.byType(TextFormField), findsNWidgets(2));
    // //expect(find.byType(ElevatedButton), findsOneWidget);
    // expect(find.byIcon(Icons.email_outlined), findsOneWidget);
    // expect(find.byIcon(Icons.lock_outline), findsNWidgets(2));
  });
}
