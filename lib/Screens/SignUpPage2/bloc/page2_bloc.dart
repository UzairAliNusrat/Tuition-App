import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tuition_app_project/Models/studentInfoModel.dart';
import 'package:tuition_app_project/Models/teacherInfoModel.dart';
import 'package:tuition_app_project/Repositories/studentRepository.dart';
import 'package:tuition_app_project/Repositories/teacherRepository.dart';

part 'page2_event.dart';
part 'page2_state.dart';

class Page2Bloc extends Bloc<Page2Event, Page2State> {
  Page2Bloc() : super(Page2Initial()) {
    on<Page2InitialEvent>(page2InitialEvent);
    on<SignUpbuttonTeacherClickedEvent>(signUpbuttonTeacherClickedEvent);
    on<SignUpbuttonStudentClickedEvent>(signUpbuttonStudentClickedEvent);
  }

  FutureOr<void> page2InitialEvent(
      Page2InitialEvent event, Emitter<Page2State> emit) {
    emit(Page2LoadingState());
    emit(Page2LoadedState());
  }

  FutureOr<void> signUpbuttonTeacherClickedEvent(
      SignUpbuttonTeacherClickedEvent event, Emitter<Page2State> emit) async {
    FirebaseTeacherRepository firebaseTeacherRepository =
        FirebaseTeacherRepository();
    emit(Page2LoadingState());
    firebaseTeacherRepository.setTeacherInfo(event.teacher);
    Future.delayed(const Duration(seconds: 1));
    emit(NavigateToLoginPageState());
  }

  Future<FutureOr<void>> signUpbuttonStudentClickedEvent(SignUpbuttonStudentClickedEvent event, Emitter<Page2State> emit) async {
    FirebaseStudentRepository firebaseStudentinfoRepository =
        FirebaseStudentRepository();
    
    await firebaseStudentinfoRepository.setStudentInfo(event.studentinfo);
    emit(Page2LoadingState());
    await Future.delayed(const Duration(seconds: 1), () {
      emit(NavigateToLoginPageState());
    });
    
    
  }
}
