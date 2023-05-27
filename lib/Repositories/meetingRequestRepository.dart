import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuition_app_project/Models/meetingRequestModel.dart';
import 'package:tuition_app_project/Models/teacherInfoModel.dart';
import '../Models/userModel.dart';

abstract class MeetingRequestRepository {
  setMeetingRequest(meetingRequestModel meetingRequest);
  Future<List<meetingRequestModel>> fetchMeetingRequestList(String teacherId);
}

class FirebaseMeetingRequestRepository implements MeetingRequestRepository {
  static var i = 0;
  final db = FirebaseFirestore.instance;
  late Teacherinfo teacherinfo;

  

  @override
  Future<List<meetingRequestModel>> fetchMeetingRequestList(
      String teacherId) async {
    List<meetingRequestModel> meetingRequests = [];
    final QuerySnapshot result =
        await db.collection("Meeting Requests").get();
    final List<DocumentSnapshot<Map<String, dynamic>>> documents =
        result.docs.cast<DocumentSnapshot<Map<String, dynamic>>>();
    for (var element in documents) {
      if (meetingRequestModel.fromJson(element).teacherId == teacherId) {
        meetingRequests.add(meetingRequestModel.fromJson(element));
      }
    }
    return meetingRequests;

  }

  @override
  setMeetingRequest(meetingRequestModel meetingRequest) async {
    await db
        .collection("Meeting Requests")
        .doc(meetingRequest.teacherId)
        .set(meetingRequest.toJson());
  }
}
