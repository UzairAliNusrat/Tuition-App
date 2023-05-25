import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tuition_app_project/Auth.dart';

part 'login_event.dart';
part 'login_state.dart';

final auth = Auth();

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginInitialEvent>(loginInitialEvent);
    on<JoinNowButtonClickedEvent>(joinNowButtonClickedEvent);
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
    on<GoogleLoginButtonClickedEvent>(googleLoginButtonClickedEvent);
  }

  FutureOr<void> loginInitialEvent(
      LoginInitialEvent event, Emitter<LoginState> emit) {
    emit(LoginLoadingState());
    emit(LoginLoadedSuccessfulState());
  }

  FutureOr<void> joinNowButtonClickedEvent(
      JoinNowButtonClickedEvent event, Emitter<LoginState> emit) {
    emit(NavigatetoSignUpState());
  }

  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<LoginState> emit) {
    auth.signIn(event.context, event.email, event.password);
  }

  FutureOr<void> googleLoginButtonClickedEvent(
      GoogleLoginButtonClickedEvent event, Emitter<LoginState> emit) {
    auth.signInWithGoogle(event.context);
  }
}
