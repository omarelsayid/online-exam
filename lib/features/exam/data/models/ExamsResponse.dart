import 'Metadata.dart';
import 'Exam.dart';

class ExamsResponse {
  String? message;
  Metadata? metadata;
  List<Exam>? exams;
  ExamsResponse({
    this.message,
    this.metadata,
    this.exams,
  });

  ExamsResponse.fromJson(dynamic json) {
    message = json['message'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['exams'] != null) {
      exams = [];
      json['exams'].forEach((v) {
        exams?.add(Exam.fromJson(v));
      });
    }
  }

  ExamsResponse copyWith({
    String? message,
    Metadata? metadata,
    List<Exam>? exams,
  }) =>
      ExamsResponse(
        message: message ?? this.message,
        metadata: metadata ?? this.metadata,
        exams: exams ?? this.exams,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    if (exams != null) {
      map['exams'] = exams?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
