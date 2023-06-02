

class meetingRequestModel {
  String meetingId;
  String teacherId;
  String studentName;
  String Studentimagepath;
  String studentId;
  String subject;
  String topic;
  String note;
  String teacherName;
  String teacherimagepath;

  meetingRequestModel(
      {required this.meetingId,
      required this.teacherId,
      required this.studentId,
      required this.studentName,
      required this.Studentimagepath,
      required this.subject,
      required this.topic,
      required this.note,
      required this.teacherName,
      required this.teacherimagepath});

  static meetingRequestModel fromJson(Map<String, dynamic> json) {
    return meetingRequestModel(
      teacherId: json['teacherId'] as String? ?? 'field empty',
      meetingId: json['meetingId'] as String? ?? 'field empty',
      studentId: json['studentId'] as String? ?? 'field empty',
      studentName: json['studentName'] as String? ?? 'field empty',
      Studentimagepath: json['Studentimagepath'] as String? ?? 'field empty',
      subject: json['subject'] as String? ?? 'field empty',
      topic: json['topic'] as String? ?? 'field empty',
      note: json['note'] as String? ?? 'field empty',
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
      'Studentimagepath': Studentimagepath,
      'subject': subject,
      'topic': topic,
      'note': note,
      'teacherName': teacherName,
      'teacherimagepath': teacherimagepath,
    };
  }
}
