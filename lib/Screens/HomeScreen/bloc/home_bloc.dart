import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tuition_app_project/Models/meetingAcceptedModel.dart';
import 'package:tuition_app_project/Models/meetingRequestModel.dart';
import 'package:tuition_app_project/Models/userModel.dart';
import 'package:tuition_app_project/Repositories/meetingRequestRepository.dart';
import 'package:tuition_app_project/Repositories/userRepository.dart';
import 'package:tuition_app_project/Utils/constants.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);

    on<BottomNavigationBarItemHomeClickedEvent>(
        bottomNavigationBarItemHomeClickedEvent);

    on<BottomNavigationBarItemMeetingsClickedEvent>(
        bottomNavigationBarItemMeetingsClickedEvent);

    on<BottomNavigationBarItemChatClickedEvent>(
        bottomNavigationBarItemChatClickedEvent);

    on<LearnButtonClickedEvent>(learnButtonClickedEvent);

    on<TeachButtonClickedEvent>(teachButtonClickedEvent);

    on<TeacherListItemClickedEvent>(teacherListItemClickedEvent);

    on<MeetingRequestTickButtonClickedEvent>(
        meetingRequestTickButtonClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Userrepo.userRepo.getUser(event.id);
    List<user> teachers = await Userrepo.userRepo.fetchTeacherList();
    FirebaseMeetingRequestRepository meetingRequestRepo =
        FirebaseMeetingRequestRepository();
    List<meetingAcceptedModel> acceptedMeetings = await meetingRequestRepo
        .fetchAcceptedMeetingList(event.id, Userrepo.userRepo.User.UserType);
    emit(HomeLoadedState(
        0, teachers, Userrepo.userRepo.User, [], acceptedMeetings));
  }

  Future<FutureOr<void>> bottomNavigationBarItemHomeClickedEvent(
      BottomNavigationBarItemHomeClickedEvent event,
      Emitter<HomeState> emit) async {
    List<user> teachers = await Userrepo.userRepo.fetchTeacherList();
    FirebaseMeetingRequestRepository meetingRequestRepo =
        FirebaseMeetingRequestRepository();
    List<meetingAcceptedModel> acceptedMeetings =
        await meetingRequestRepo.fetchAcceptedMeetingList(
            Userrepo.userRepo.User.id, Userrepo.userRepo.User.UserType);
    emit(HomeLoadedState(
        0, teachers, Userrepo.userRepo.User, [], acceptedMeetings));
    print("Home Clicked");
  }

  Future<FutureOr<void>> bottomNavigationBarItemMeetingsClickedEvent(
      BottomNavigationBarItemMeetingsClickedEvent event,
      Emitter<HomeState> emit) async {
    List<meetingRequestModel> meetingRequests = [];
    FirebaseMeetingRequestRepository meetingRequestRepo =
        FirebaseMeetingRequestRepository();
    print("hello");
    meetingRequests = await meetingRequestRepo.fetchMeetingRequestList(
        Userrepo.userRepo.User.id, Userrepo.userRepo.User.UserType);
    print("hello2");

    emit(HomeLoadedState(1, [], Userrepo.userRepo.User, meetingRequests, []));
    print("Meetings Clicked");
  }

  FutureOr<void> bottomNavigationBarItemChatClickedEvent(
      BottomNavigationBarItemChatClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    emit(HomeLoadedState(2, [], Userrepo.userRepo.User, [], []));
    print("Chat Clicked");
  }

  FutureOr<void> learnButtonClickedEvent(
      LearnButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToLearnScreenState(
        id: event.studentId,
        studentName: event.studentName,
        imagepath: event.imagepath));
  }

  FutureOr<void> teachButtonClickedEvent(
      TeachButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToTeachScreenState());
  }

  FutureOr<void> teacherListItemClickedEvent(
      TeacherListItemClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToTeacherProfileScreenState(
        id: event.id, imagepath: event.imagepath, fullname: event.fullname));
  }

  FutureOr<void> meetingRequestTickButtonClickedEvent(
      MeetingRequestTickButtonClickedEvent event,
      Emitter<HomeState> emit) async {
    FirebaseMeetingRequestRepository meetingRequestRepo =
        FirebaseMeetingRequestRepository();
    await meetingRequestRepo.deleteMeetingRequest(event.meetingId);
    List<meetingRequestModel> meetingRequests =
        await meetingRequestRepo.fetchMeetingRequestList(
            Userrepo.userRepo.User.id, Userrepo.userRepo.User.UserType);
    meetingAcceptedModel meetingAccepted = meetingAcceptedModel(
        teacherId: event.teacherId,
        studentId: event.studentId,
        studentName: event.studentName,
        meetingId: event.meetingId,
        date: event.date,
        imagepath: event.imagepath,
        note: event.note,
        subject: event.subject,
        time: event.time,
        topic: event.topic,
        teacherName: event.teacherName);
    await meetingRequestRepo.setAcceptedMeeting(meetingAccepted);
    emit(HomeLoadedState(1, [], Userrepo.userRepo.User, meetingRequests, []));
  }
}
