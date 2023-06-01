import 'package:cloud_firestore/cloud_firestore.dart';

class meetingAcceptedModel {
  String meetingId;
  String teacherId;
  String studentName;
  String studentimagepath;
  String studentId;
  String subject;
  String topic;
  String note;
  String date;
  String time;
  String teacherName;
  String teacherimagepath;

  meetingAcceptedModel(
      {required this.meetingId,
      required this.teacherId,
      required this.studentId,
      required this.studentName,
      required this.studentimagepath,
      required this.subject,
      required this.topic,
      required this.note,
      required this.date,
      required this.time,
      required this.teacherName,
      required this.teacherimagepath
      });

  static meetingAcceptedModel fromJson(Map<String, dynamic> json) {
    return meetingAcceptedModel(
      teacherId: json['teacherId'] as String? ?? 'field empty',
      meetingId: json['meetingId'] as String? ?? 'field empty',
      studentId: json['studentId'] as String? ?? 'field empty',
      studentName: json['studentName'] as String? ?? 'field empty',
      studentimagepath: json['studentimagepath'] as String? ?? 'field empty',
      subject: json['subject'] as String? ?? 'field empty',
      topic: json['topic'] as String? ?? 'field empty',
      note: json['note'] as String? ?? 'field empty',
      date: json['date'] as String? ?? 'field empty',
      time: json['time'] as String? ?? 'field empty',
      teacherName: json['teacherName'] as String? ?? 'field empty',
      teacherimagepath: json['teacherimagepath'] as String? ?? 'field empty',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meetingId': meetingId,
      'teacherId': teacherId,
      'studentId': studentId,
      'studentName': studentName,
      'studentimagepath': studentimagepath,
      'subject': subject,
      'topic': topic,
      'note': note,
      'date': date,
      'time': time,
      'teacherName': teacherName,
      'teacherimagepath': teacherimagepath,
    };
  }
}
