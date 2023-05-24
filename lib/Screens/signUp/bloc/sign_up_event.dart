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
