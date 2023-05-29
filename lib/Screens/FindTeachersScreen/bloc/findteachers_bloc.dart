import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';
import 'package:tuition_app_project/Models/meetingRequestModel.dart';
import 'package:tuition_app_project/Models/teacherInfoModel.dart';
import 'package:tuition_app_project/Models/userModel.dart';
import 'package:tuition_app_project/Repositories/meetingRequestRepository.dart';
import 'package:tuition_app_project/Repositories/teacherRepository.dart';
import 'package:tuition_app_project/Screens/LearnScreen/bloc/learn_bloc.dart';
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
    FirebaseTeacherRepository teacherInfoRepository =
        FirebaseTeacherRepository();
    List<user> teachers = await Userrepo.userRepo.fetchTeacherList();
    List<Teacherinfo> teachersinfo = await teacherInfoRepository
        .fetchTeacherinfoListbySubject(event.subject);
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
    emit(FindTeachersLoadedSuccessState(
        teachers: teacherslist, teacherRequestSent: teacherRequestSent));
  }

  Future<FutureOr<void>> meetingRequestButtonClickedEvent(
      MeetingRequestButtonClickedEvent event,
      Emitter<FindteachersState> emit) async {
    FirebaseMeetingRequestRepository meetingRequestRepository =
        FirebaseMeetingRequestRepository();
    String meetingId = IDgenerator.uuid.v4();
    await meetingRequestRepository.setMeetingRequest(meetingRequestModel(
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
    await meetingRequestRepository.setMeetingHistory(meetingRequestModel(
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
    emit(FindTeachersLoadedSuccessState(
        teachers: event.teachers,
        teacherRequestSent: event.teacherRequestSent));
  }
}
