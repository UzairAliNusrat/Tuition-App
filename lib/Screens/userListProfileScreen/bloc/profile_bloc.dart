import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tuition_app_project/Models/Ratings.dart';
import 'package:tuition_app_project/Models/studentInfoModel.dart';
import 'package:tuition_app_project/Models/teacherInfoModel.dart';
import 'package:tuition_app_project/Repositories/studentRepository.dart';
import 'package:tuition_app_project/Repositories/teacherRepository.dart';
import 'package:tuition_app_project/Utils/constants.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileInitialEvent>(profileInitialEvent);
    on<NewRatingEvent>(newratingEvent);
  }

  FutureOr<void> profileInitialEvent(
      ProfileInitialEvent event, Emitter<ProfileState> emit) async {
        print("hello");
    emit(ProfileLoadingState());
    if (event.userType == "Teacher") {
      print("hello1");
      FirebaseTeacherRepository firebaseTeacherRepository =
          FirebaseTeacherRepository();
      Teacherinfo teacherinfo =
          await firebaseTeacherRepository.getTeacher(event.id);
      double avgRating = await Userrepo.userRepo.getAvgUserRating(event.id);
      emit(ProfileLoadedState(
          fullname: event.fullname,
          imagepath: event.imagepath,
          age: teacherinfo.age,
          qualification: teacherinfo.qualification,
          subjects: teacherinfo.subjects,
          description: teacherinfo.description,
          rating: avgRating,
          initialRating: 0,
          phoneNumber: teacherinfo.phoneNumber));
    } else {
      print("hello3");
      FirebaseStudentRepository firebaseStudentRepository =
          FirebaseStudentRepository();
      Studentinfo studentinfo =
          await firebaseStudentRepository.getStudentinfo(event.id);
      double avgRating = await Userrepo.userRepo.getAvgUserRating(event.id);
      emit(ProfileLoadedState(
          fullname: event.fullname,
          imagepath: event.imagepath,
          age: studentinfo.age,
          qualification: studentinfo.qualification,
          subjects: const [],
          description: studentinfo.description,
          rating: avgRating,
          initialRating: 0,
          phoneNumber: studentinfo.phoneNumber));
    }
  }

  Future<FutureOr<void>> newratingEvent(
      NewRatingEvent event, Emitter<ProfileState> emit) async {
    Ratings rating = Ratings(
        rating: event.rating,
        userId: event.userId,
        ratingID: IDgenerator.uuid.v4());
    await Userrepo.userRepo.setRating(rating);
    double avgRating = await Userrepo.userRepo.getAvgUserRating(event.userId);
    emit(ProfileLoadedState(
        fullname: event.fullname,
        imagepath: event.imagepath,
        age: event.age,
        qualification: event.qualification,
        subjects: event.subjects,
        description: event.description,
        rating: avgRating,
        initialRating: event.initialRating,
        phoneNumber: event.phoneNumber));
  }
}
