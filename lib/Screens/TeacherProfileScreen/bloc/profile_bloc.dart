import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tuition_app_project/Models/teacherInfoModel.dart';
import 'package:tuition_app_project/Repositories/teacherRepository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileInitialEvent>(profileInitialEvent);
  }

  FutureOr<void> profileInitialEvent(ProfileInitialEvent event, Emitter<ProfileState> emit) async{
    emit(ProfileLoading());
    FirebaseTeacherRepository firebaseTeacherRepository = FirebaseTeacherRepository();
    Teacherinfo teacherinfo = await firebaseTeacherRepository.getTeacher(event.id);
    emit(ProfileLoadedState(
        fullname: event.fullname,
        imagepath: event.imagepath,
        age: teacherinfo.age,
        qualification: teacherinfo.qualification,
        subjects: teacherinfo.subjects,
        description: teacherinfo.description));
    
  }
}
