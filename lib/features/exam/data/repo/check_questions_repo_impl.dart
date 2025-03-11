import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:online_exam/features/exam/data/data_source/exam_data_source.dart';
import 'package:online_exam/features/exam/data/models/CheckQuestionResponse.dart';
import 'package:online_exam/features/exam/domain/repo/check_questions_repo.dart';

import '../../../../core/errors/failures.dart';

@Injectable(as: CheckQuestionsRepo)
class CheckQuestionsRepoImpl extends CheckQuestionsRepo {
  final ExamDataSource examDataSource;
  final InternetConnectionChecker internetConnectionChecker;

  CheckQuestionsRepoImpl(this.examDataSource, this.internetConnectionChecker);

  @override
  Future<Either<ServerFailure, CheckQuestionResponse>> checkQuestions(
      {required List<Map<String, dynamic>> answers}) async {
    bool isConnected = await internetConnectionChecker.hasConnection;
    if (isConnected) {
      final result = await examDataSource.checkQuestions(answers: answers);
      return result.fold(
        (failure) => left(failure),
        (checkQuestionsResponse) => right(checkQuestionsResponse),
      );
    } else {
      return left(ServerFailure(
          errorMessage:
              "Please check your internet connection and try again later"));
    }
  }
}
