import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:tuition_app_project/Screens/login/bloc/login_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpInitialEvent>(signUpInitialEvent);
    on<DropDownValueChangedEvent>(dropDownValueChangedEvent);
    on<ImagePickerEvent>(imagePickerEvent);
    on<BackArrowIconClickedEvent>(backArrowIconClickedEvent);
    on<SignUpButtonClickedEvent>(signUpButtonClickedEvent);
    on<SignUpNextButtonClickedEvent>(signUpNextButtonClickedEvent);
  }

  FutureOr<void> signUpInitialEvent(
      SignUpInitialEvent event, Emitter<SignUpState> emit) {
    emit(SignUpLoadingState());
    emit(SignUpLoadedSuccessfulState(
        selectedValue: event.selectedValue, image: ""));
  }

  FutureOr<void> dropDownValueChangedEvent(
      DropDownValueChangedEvent event, Emitter<SignUpState> emit) {
    emit(SignUpLoadedSuccessfulState(
        selectedValue: event.selectedValue, image: event.image));
  }

  FutureOr<void> imagePickerEvent(
      ImagePickerEvent event, Emitter<SignUpState> emit) async {
    final imagePicker = ImagePicker();
    final XFile? PickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (PickedImage != null) {
      var path = PickedImage.path;
      emit(SignUpLoadedSuccessfulState(
          selectedValue: event.selectedValue, image: path));
    } else {
      emit(SignUpLoadedSuccessfulState(
          selectedValue: event.selectedValue, image: ""));
    }
  }

  FutureOr<void> backArrowIconClickedEvent(
      BackArrowIconClickedEvent event, Emitter<SignUpState> emit) {
    Navigator.pop(event.context);
    emit(NavigateToLoginScreenState());
  }

  FutureOr<void> signUpButtonClickedEvent(
      SignUpButtonClickedEvent event, Emitter<SignUpState> emit) {
    auth.signUp(event.context, event.email, event.password, event.firstName,
        event.lastName, event.imagePath, event.userType);
  }

  FutureOr<void> signUpNextButtonClickedEvent(SignUpNextButtonClickedEvent event, Emitter<SignUpState> emit) {
    emit(NavigateToSignUpPage2State());
  }
}
