import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuition_app_project/Models/meetingRequestModel.dart';
import '../Models/meetingAcceptedModel.dart';

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
  final db = FirebaseFirestore.instance;

  @override
  Future<List<meetingRequestModel>> fetchMeetingRequestList(
      String Id, String userType) async {
    List<meetingRequestModel> meetingRequests = [];
    final QuerySnapshot result = await db.collection("Meeting Requests").get();

    final List<DocumentSnapshot<Map<String, dynamic>>> documents =
        result.docs.cast<DocumentSnapshot<Map<String, dynamic>>>();

    if (userType == "Student") {
      for (var element in documents) {
        if (meetingRequestModel.fromJson(element.data()!).studentId == Id) {
          meetingRequests.add(meetingRequestModel.fromJson(element.data()!));
        }
      }
    } else {
      for (var element in documents) {
        if (meetingRequestModel.fromJson(element.data()!).teacherId == Id) {
          print("hello1");
          meetingRequests.add(meetingRequestModel.fromJson(element.data()!));
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
        if (meetingAcceptedModel.fromJson(element.data()!).studentId == Id) {
          acceptedMeetings.add(meetingAcceptedModel.fromJson(element.data()!));
        }
      }
    } else {
      for (var element in documents) {
        if (meetingAcceptedModel.fromJson(element.data()!).teacherId == Id) {
          acceptedMeetings.add(meetingAcceptedModel.fromJson(element.data()!));
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
    if (meetingRequestModel.fromJson(element.data()!).studentId == Id) {
      meetingHistory.add(meetingRequestModel.fromJson(element.data()!));
    }
  }

  return meetingHistory;
}

  @override
  deleteAcceptedMeeting(String meetingId) async {
    await db.collection("Accepted Meetings").doc(meetingId).delete();
  }
}

