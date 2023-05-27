import 'package:cloud_firestore/cloud_firestore.dart';

class meetingRequestModel {
  String teacherId;
  String studentId;
  String subject;
  String topic;
  String note;

  meetingRequestModel(
      {required this.teacherId,
      required this.studentId,
      required this.subject,
      required this.topic,
      required this.note});

  
  static meetingRequestModel fromJson(DocumentSnapshot<Map<String, dynamic>> json) {
    return meetingRequestModel(
      teacherId: json['teacherId'] as String? ?? 'field empty',
      studentId: json['studentId'] as String? ?? 'field empty',
      subject: json['subject'] as String? ?? 'field empty',
      topic: json['topic'] as String? ?? 'field empty',
      note: json['note'] as String? ?? 'field empty',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teacherId': teacherId,
      'studentId': studentId,
      'subject': subject,
      'topic': topic,
      'note': note,
    };
  }
}
