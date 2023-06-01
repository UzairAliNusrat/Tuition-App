import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuition_app_project/Screens/login/bloc/login_bloc.dart';

void main() {
  late LoginBloc loginBloc;

  setUp(() {
    loginBloc = LoginBloc();
  });

  tearDown() {
    loginBloc.close();
  }

  blocTest<LoginBloc, LoginState>(
      'emits login page loading state when LoginInitialEvent is added',
      build: () => loginBloc,
      act: (bloc) => bloc.add(LoginInitialEvent()),
      expect: () => [
            isA<LoginLoadedSuccessfulState>(),
          ]);

  blocTest<LoginBloc, LoginState>(
      'emits login page loading state when LoginInitialEvent is added',
      build: () => loginBloc,
      act: (bloc) => bloc.add(JoinNowButtonClickedEvent()),
      expect: () => [
            isA<NavigatetoSignUpState>(),
          ]);

  // blocTest<LoginBloc, LoginState>(
  //   'emits login page loading state when LoginInitialEvent is added',
  //   build: () => loginBloc,
  //   act: (bloc) => bloc.add(LoginButtonClickedEvent(context: , email: , password: )),
  //   expect: () => [
  //   ]
  // );

  // blocTest<LoginBloc, LoginState>(
  //   'emits login page loading state when LoginInitialEvent is added',
  //   build: () => loginBloc,
  //   act: (bloc) => bloc.add(PasswordHideButtonClickedEvent(hide: )),
  //   expect: () => [
  //     isA<LoginLoadedSuccessfulState>()
  //   ]
  // );

  // testWidgets('Login page displays correctly', (WidgetTester tester) async {
  //   //await tester.pumpWidget(MaterialApp(home: Login()));

  // final loginBloc = LoginBloc();

  // //expect(find.text("Teach n Learn"), findsOneWidget);

  //   //expect(find.text("Teach n Learn"), findsOneWidget);
  //   // expect(find.byKey(const Key("login button")), findsOneWidget);

  //   // expect(find.text('Login'), findsNWidgets(2));
  //   // expect(find.text('Dont have an account?'), findsOneWidget);
  //   // expect(find.byType(TextFormField), findsNWidgets(2));
  //   // //expect(find.byType(ElevatedButton), findsOneWidget);
  //   // expect(find.byIcon(Icons.email_outlined), findsOneWidget);
  //   // expect(find.byIcon(Icons.lock_outline), findsNWidgets(2));
  // });
}
