part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpInitialEvent extends SignUpEvent {
  final String selectedValue;

  SignUpInitialEvent({required this.selectedValue});
}

class DropDownValueChangedEvent extends SignUpEvent {
  final String selectedValue;
  final String image;
  DropDownValueChangedEvent({required this.selectedValue, required this.image});
}

class ImagePickerEvent extends SignUpEvent {
  final String selectedValue;

  ImagePickerEvent({required this.selectedValue});
}

class BackArrowIconClickedEvent extends SignUpEvent {
  BuildContext context;
  BackArrowIconClickedEvent({required this.context});
}

class SignUpNextButtonClickedEvent extends SignUpEvent {
  
}

class SignUpButtonClickedEvent extends SignUpEvent {
  final BuildContext context;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String imagePath;
  final String userType;

  SignUpButtonClickedEvent(
      {required this.context,
      required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.imagePath,
      required this.userType});
}
