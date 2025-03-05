import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/core/services/exam_service.dart';
import 'package:online_exam/features/exam/data/data_source/exam_data_source.dart';
import 'package:online_exam/features/exam/data/models/Exam.dart';
import 'package:online_exam/features/exam/data/models/ExamResponse.dart';
import 'package:online_exam/features/exam/data/models/ExamsResponse.dart';
import 'package:online_exam/features/exam/data/models/Subjects.dart';
import 'package:online_exam/features/exam/data/models/SubjectsResponse.dart';
import 'package:online_exam/features/exam/data/models/qusetions_response.dart';

@Injectable(as: ExamDataSource)
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
  Future<Either<ServerFailure, List<Exam>>> getAllExamsOnSubject(
      {required String subjectId}) async {
    try {
      Response response =
          await examService.getAllExamsOnSubject(subjectId: subjectId);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        ExamsResponse examsResponse = ExamsResponse.fromJson(response.data);
        return Right(examsResponse.exams!);
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
  Future<Either<ServerFailure, Exam>> getExamOnId(
      {required String examId}) async {
    try {
      Response response = await examService.getExamOnId(examId: examId);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        ExamResponse examResponse = ExamResponse.fromJson(response.data);
        return Right(examResponse.exam!);
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
  Future<QusetionsResponse> getAllQuestionsOnExam(
      {required String examId}) async {
    Response response = await examService.getAllQuestionsOnExam(examId: examId);
    QusetionsResponse questionsResponse =
        QusetionsResponse.fromJson(response.data);
    return questionsResponse;
  }
}
