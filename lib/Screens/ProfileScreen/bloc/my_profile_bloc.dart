import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tuition_app_project/Models/studentInfoModel.dart';
import 'package:tuition_app_project/Models/teacherInfoModel.dart';
import 'package:tuition_app_project/Models/userModel.dart';
import 'package:tuition_app_project/Repositories/teacherRepository.dart';
import 'package:tuition_app_project/Utils/constants.dart';

import '../../../Repositories/studentRepository.dart';

part 'my_profile_event.dart';
part 'my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  MyProfileBloc() : super(MyProfileInitial()) {
    on<MyProfileInitialEvent>(myProfileInitialEvent);
  }

  FutureOr<void> myProfileInitialEvent(MyProfileInitialEvent event, Emitter<MyProfileState> emit) async{

    emit(MyProfileLoadingState());
    if (event.User.UserType == "Student") {
      Studentinfo studentinfo =
          await StudentInfoRepo.studentInfoRepo.getStudentinfo(event.User.id);
          double avgRating = await Userrepo.userRepo.getAvgUserRating(event.User.id);
      emit(MyProfileLoadedState(studentinfo: studentinfo, teacherinfo: null, avgRating: avgRating));
      
    }
    else{
      Teacherinfo teacherinfo =
          await TeacherInfoRepo.teacherInfoRepo.getTeacher(event.User.id);
          double avgRating = await Userrepo.userRepo.getAvgUserRating(event.User.id);
      emit(MyProfileLoadedState(studentinfo: null, teacherinfo: teacherinfo, avgRating: avgRating));
    }
  }
}
