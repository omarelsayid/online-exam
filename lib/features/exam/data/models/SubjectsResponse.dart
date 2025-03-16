import 'Metadata.dart';
import 'Subjects.dart';

class SubjectsResponse {
  String? message;
  Metadata? metadata;
  List<Subjects>? subjects;
  SubjectsResponse({
    this.message,
    this.metadata,
    this.subjects,
  });

  SubjectsResponse.fromJson(dynamic json) {
    message = json['message'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['subjects'] != null) {
      subjects = [];
      json['subjects'].forEach((v) {
        subjects?.add(Subjects.fromJson(v));
      });
    }
  }

  SubjectsResponse copyWith({
    String? message,
    Metadata? metadata,
    List<Subjects>? subjects,
  }) =>
      SubjectsResponse(
        message: message ?? this.message,
        metadata: metadata ?? this.metadata,
        subjects: subjects ?? this.subjects,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    if (subjects != null) {
      map['subjects'] = subjects?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
