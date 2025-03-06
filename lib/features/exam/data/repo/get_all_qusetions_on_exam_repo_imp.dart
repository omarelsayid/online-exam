import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/exam/data/data_source/exam_data_source.dart';
import 'package:online_exam/features/exam/data/models/qusetions_response.dart';
import 'package:online_exam/features/exam/domain/entites/qusetion_entity.dart';
import 'package:online_exam/features/exam/domain/repo/get_all_qusetions_on_exam_repo.dart';

@Injectable(as: GetAllQusetionsOnExamRepo)
class GetAllQusetionsOnExamRepoImp implements GetAllQusetionsOnExamRepo {
  ExamDataSource examDataSource;
  GetAllQusetionsOnExamRepoImp({
    required this.examDataSource,
  });
  @override
  Future<Either<ServerFailure, List<QusetionEntity>>> getAllQuestionsOnExam(
      {required String examId}) async {
    try {
      QusetionsResponse questionsResponse =
          await examDataSource.getAllQuestionsOnExam(examId: examId);

      List<QusetionEntity> questions =
          questionsResponse.questions.map((e) => e.toQusetionEntity()).toList();
      return right(questions);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
