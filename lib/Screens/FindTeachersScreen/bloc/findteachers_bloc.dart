import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tuition_app_project/Models/meetingRequestModel.dart';
import 'package:tuition_app_project/Models/teacherInfoModel.dart';
import 'package:tuition_app_project/Models/userModel.dart';
import 'package:tuition_app_project/Utils/constants.dart';

part 'findteachers_event.dart';
part 'findteachers_state.dart';

class FindteachersBloc extends Bloc<FindteachersEvent, FindteachersState> {
  FindteachersBloc() : super(FindteachersInitial()) {
    on<FindTeachersInitialEvent>(findTeachersInitialEvent);
    on<MeetingRequestButtonClickedEvent>(meetingRequestButtonClickedEvent);
  }

  FutureOr<void> findTeachersInitialEvent(
      FindTeachersInitialEvent event, Emitter<FindteachersState> emit) async {
    emit(FindTeachersLoadingState());
    List<user> teacherslist = [];
    
    List<user> teachers = await Userrepo.userRepo.fetchTeacherList();
    List<Teacherinfo> teachersinfo = await TeacherInfoRepo.teacherInfoRepo
        .fetchTeacherInfoListBySubject(event.subject);
    if (teachersinfo.isEmpty) {
      emit(FindTeachersErrorState(message: "No teachers found"));
    } else {
      for (int i = 0; i < teachers.length; i++) {
        for (int j = 0; j < teachersinfo.length; j++) {
          if (teachers[i].id == teachersinfo[j].id) {
            teacherslist.add(teachers[i]);
            break;
          }
        }
      }
      List<bool> teacherRequestSent =
          List.generate(teacherslist.length, (index) => false);
      List<double> teacherRatings = [];
      for (int i = 0; i < teacherslist.length; i++) {
        teacherRatings
            .add(await Userrepo.userRepo.getAvgUserRating(teacherslist[i].id));
      }

      emit(FindTeachersLoadedSuccessState(
          teachers: teacherslist, teacherRequestSent: teacherRequestSent, teacherRatings: teacherRatings));
    }
  }

  Future<FutureOr<void>> meetingRequestButtonClickedEvent(
      MeetingRequestButtonClickedEvent event,
      Emitter<FindteachersState> emit) async {
    String meetingId = IDgenerator.uuid.v4();
    await MeetingRequestRepo.meetingRequestRepo.setMeetingRequest(meetingRequestModel(
        meetingId: meetingId,
        studentName: event.studentName,
        Studentimagepath: event.Studentimagepath,
        teacherId: event.teacherId,
        studentId: event.studentId,
        subject: event.subject,
        topic: event.topic,
        note: event.note,
        teacherName: event.teacherName,
        teacherimagepath: event.teacherImagepath));
    await MeetingRequestRepo.meetingRequestRepo.setMeetingHistory(meetingRequestModel(
        meetingId: meetingId,
        studentName: event.studentName,
        Studentimagepath: event.Studentimagepath,
        teacherId: event.teacherId,
        studentId: event.studentId,
        subject: event.subject,
        topic: event.topic,
        note: event.note,
        teacherName: event.teacherName,
        teacherimagepath: event.teacherImagepath));

    event.teacherRequestSent[event.teacherIndex] = true;

    List<double> teacherRatings = [];
      for (int i = 0; i < event.teachers.length; i++) {
        teacherRatings
            .add(await Userrepo.userRepo.getAvgUserRating(event.teachers[i].id));
      }
    
    emit(FindTeachersLoadedSuccessState(
        teachers: event.teachers,
        teacherRequestSent: event.teacherRequestSent,
        teacherRatings: teacherRatings));
  }
}
