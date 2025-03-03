import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/core/services/exam_service.dart';
import 'package:online_exam/features/exam/data/data_source/exam_data_source.dart';
import 'package:online_exam/features/exam/data/models/Subjects.dart';
import 'package:online_exam/features/exam/data/models/SubjectsResponse.dart';

class ExamDataSourceImpl extends ExamDataSource {
  ExamService examService;
  ExamDataSourceImpl(this.examService);
  @override
  Future<Either<ServerFailure, List<Subjects>>> getAllSubjects() async {
    try {
      Response response = await examService.getAllSubjects();
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        SubjectsResponse subjectsResponse =
            SubjectsResponse.fromJson(response.data);
        return Right(subjectsResponse.subjects!);
      } else {
        log(response.data['message'].toString());
        return left(ServerFailure.fromDioException(response.data['message']));
      }
    } on DioException catch (e) {
      log(e.toString());
      return left(ServerFailure.fromDioException(e));
    }
  }

  @override
  Future<void> getAllExamsOnSubject() {
    // TODO: implement getAllExamsOnSubject
    throw UnimplementedError();
  }

  @override
  Future<void> getExamOnId() {
    // TODO: implement getExamOnId
    throw UnimplementedError();
  }
}
