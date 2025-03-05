// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/exam/data/data_source/exam_data_source.dart';
import 'package:online_exam/features/exam/data/models/question_model.dart';
import 'package:online_exam/features/exam/domain/repo/get_all_qusetions_on_exam_repo.dart';

@Injectable(as: GetAllQusetionsOnExam)
class GetAllQusetionsOnExamRepoImp implements GetAllQusetionsOnExam {
  ExamDataSource examDataSource;
  GetAllQusetionsOnExamRepoImp({
    required this.examDataSource,
  });
  @override
  Future<Either<ServerFailure, QuestionModel>> getAllQuestionsOnExam(
      {required String examId}) async {
    try {
      QuestionModel questionsResponse =
          await examDataSource.getAllQuestionsOnExam(examId: examId);
      return right(questionsResponse);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
