import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuition_app_project/Models/meetingRequestModel.dart';
import 'package:tuition_app_project/Models/teacherInfoModel.dart';
import '../Models/meetingAcceptedModel.dart';
import '../Models/userModel.dart';

abstract class MeetingRequestRepository {
  setMeetingRequest(meetingRequestModel meetingRequest);
  Future<List<meetingRequestModel>> fetchMeetingRequestList(
      String Id, String userType);
  deleteMeetingRequest(String meetingId);
  deleteAcceptedMeeting(String meetingId);
  setAcceptedMeeting(meetingAcceptedModel acceptedMeeting);
  Future<List<meetingAcceptedModel>> fetchAcceptedMeetingList(
      String Id, String userType);
  setMeetingHistory(meetingRequestModel meetingRequest);
  Future<List<meetingRequestModel>> fetchMeetingHistoryList(String Id);
}

class FirebaseMeetingRequestRepository implements MeetingRequestRepository {
  static var i = 0;
  final db = FirebaseFirestore.instance;
  late Teacherinfo teacherinfo;

  @override
  Future<List<meetingRequestModel>> fetchMeetingRequestList(
      String Id, String userType) async {
    List<meetingRequestModel> meetingRequests = [];
    final QuerySnapshot result = await db.collection("Meeting Requests").get();

    final List<DocumentSnapshot<Map<String, dynamic>>> documents =
        result.docs.cast<DocumentSnapshot<Map<String, dynamic>>>();

    if (userType == "Student") {
      for (var element in documents) {
        if (meetingRequestModel.fromJson(element).studentId == Id) {
          meetingRequests.add(meetingRequestModel.fromJson(element));
        }
      }
    } else {
      for (var element in documents) {
        if (meetingRequestModel.fromJson(element).teacherId == Id) {
          print("hello1");
          meetingRequests.add(meetingRequestModel.fromJson(element));
        }
      }
    }

    return meetingRequests;
  }

  @override
  setMeetingRequest(meetingRequestModel meetingRequest) async {
    await db
        .collection("Meeting Requests")
        .doc(meetingRequest.meetingId)
        .set(meetingRequest.toJson());
  }

  @override
  setAcceptedMeeting(meetingAcceptedModel acceptedMeeting) async {
    await db
        .collection("Accepted Meetings")
        .doc(acceptedMeeting.meetingId)
        .set(acceptedMeeting.toJson());
  }

  @override
  Future<List<meetingAcceptedModel>> fetchAcceptedMeetingList(
      String Id, String userType) async {
    List<meetingAcceptedModel> acceptedMeetings = [];
    final QuerySnapshot result = await db.collection("Accepted Meetings").get();
    final List<DocumentSnapshot<Map<String, dynamic>>> documents =
        result.docs.cast<DocumentSnapshot<Map<String, dynamic>>>();
    if (userType == "Student") {
      for (var element in documents) {
        if (meetingAcceptedModel.fromJson(element).studentId == Id) {
          acceptedMeetings.add(meetingAcceptedModel.fromJson(element));
        }
      }
    } else {
      for (var element in documents) {
        if (meetingAcceptedModel.fromJson(element).teacherId == Id) {
          acceptedMeetings.add(meetingAcceptedModel.fromJson(element));
        }
      }
    }
    return acceptedMeetings;
  }

  @override
  deleteMeetingRequest(String meetingId) async {
    await db.collection("Meeting Requests").doc(meetingId).delete();
  }

  @override
  setMeetingHistory(meetingRequestModel meetingRequest) async {
    await db
        .collection("Meeting History")
        .doc(meetingRequest.meetingId)
        .set(meetingRequest.toJson());
  }

  @override
  Future<List<meetingRequestModel>> fetchMeetingHistoryList(String Id) async {
    List<meetingRequestModel> meetingHistory = [];
    final QuerySnapshot result = await db.collection("Meeting History").get();

    final List<DocumentSnapshot<Map<String, dynamic>>> documents =
        result.docs.cast<DocumentSnapshot<Map<String, dynamic>>>();

    for (var element in documents) {
      if (meetingRequestModel.fromJson(element).studentId == Id) {
        meetingHistory.add(meetingRequestModel.fromJson(element));
      }
    }

    return meetingHistory;
  }
  
  @override
  deleteAcceptedMeeting(String meetingId) async {
    await db.collection("Accepted Meetings").doc(meetingId).delete();
  }
}
