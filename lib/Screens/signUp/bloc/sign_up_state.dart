part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpActionState extends SignUpState {}


class SignUpInitial extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpLoadedSuccessfulState extends SignUpState {
  final String selectedValue;
  final String image;

  SignUpLoadedSuccessfulState({required this.selectedValue, required this.image});
}

class NavigateToLoginScreenState extends SignUpActionState {}
