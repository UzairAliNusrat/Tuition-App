import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

    on<MeetingRequestCrossButtonClickedEvent>(
        meetingRequestCrossButtonClickedEvent);

    on<SignOutButtonClickedEvent>(signOutButtonClickedEvent);

    on<ProfileButtonClickedEvent>(profileButtonClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState(0));
    await Userrepo.userRepo.getUser(event.id);
    List<user> teachers = await Userrepo.userRepo.fetchTeacherList();
    FirebaseMeetingRequestRepository meetingRequestRepo =
        FirebaseMeetingRequestRepository();
    List<meetingAcceptedModel> acceptedMeetings = await meetingRequestRepo
        .fetchAcceptedMeetingList(event.id, Userrepo.userRepo.User.UserType);
    emit(HomeLoadedState(0, teachers, Userrepo.userRepo.User, const [],
        acceptedMeetings, const []));
  }

  Future<FutureOr<void>> bottomNavigationBarItemHomeClickedEvent(
      BottomNavigationBarItemHomeClickedEvent event,
      Emitter<HomeState> emit) async {
    emit(HomeLoadingState(0));
    List<user> teachers = await Userrepo.userRepo.fetchTeacherList();
    FirebaseMeetingRequestRepository meetingRequestRepo =
        FirebaseMeetingRequestRepository();
    List<meetingAcceptedModel> acceptedMeetings =
        await meetingRequestRepo.fetchAcceptedMeetingList(
            Userrepo.userRepo.User.id, Userrepo.userRepo.User.UserType);
    emit(HomeLoadedState(0, teachers, Userrepo.userRepo.User, const [],
        acceptedMeetings, const []));
    print("Home Clicked");
  }

  Future<FutureOr<void>> bottomNavigationBarItemMeetingsClickedEvent(
      BottomNavigationBarItemMeetingsClickedEvent event,
      Emitter<HomeState> emit) async {
    emit(HomeLoadingState(1));
    List<meetingRequestModel> meetingRequests = [];
    List<meetingRequestModel> meetingHistory = [];
    FirebaseMeetingRequestRepository meetingRequestRepo =
        FirebaseMeetingRequestRepository();
    print("hello");
    meetingRequests = await meetingRequestRepo.fetchMeetingRequestList(
        Userrepo.userRepo.User.id, Userrepo.userRepo.User.UserType);
    meetingHistory = await meetingRequestRepo
        .fetchMeetingHistoryList(Userrepo.userRepo.User.id);
    print("hello2");

    emit(HomeLoadedState(1, const [], Userrepo.userRepo.User, meetingRequests,
        const [], meetingHistory));
    print("Meetings Clicked");
  }

  FutureOr<void> bottomNavigationBarItemChatClickedEvent(
      BottomNavigationBarItemChatClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState(2));
    emit(HomeLoadedState(
        2, const [], Userrepo.userRepo.User, const [], const [], const []));
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
    emit(HomeLoadedState(1, const [], Userrepo.userRepo.User, meetingRequests,
        const [], const []));
  }

  Future<FutureOr<void>> meetingRequestCrossButtonClickedEvent(
      MeetingRequestCrossButtonClickedEvent event,
      Emitter<HomeState> emit) async {
    FirebaseMeetingRequestRepository meetingRequestRepo =
        FirebaseMeetingRequestRepository();
    meetingRequestRepo.deleteMeetingRequest(event.meetingId);
    List<meetingRequestModel> meetingRequests =
        await meetingRequestRepo.fetchMeetingRequestList(
            Userrepo.userRepo.User.id, Userrepo.userRepo.User.UserType);
    emit(HomeLoadedState(1, const [], Userrepo.userRepo.User, meetingRequests,
        const [], const []));
  }

  Future<FutureOr<void>> signOutButtonClickedEvent(
      SignOutButtonClickedEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState(0));
    Future.delayed(const Duration(seconds: 1), () async {
      await FirebaseAuth.instance.signOut();
    });
  }

  FutureOr<void> profileButtonClickedEvent(ProfileButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToProfileScreenState(User: event.User));
  }
}
