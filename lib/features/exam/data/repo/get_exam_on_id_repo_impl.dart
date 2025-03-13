import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:online_exam/features/exam/data/data_source/exam_data_source.dart';
import 'package:online_exam/features/exam/domain/entites/exam_entity.dart';
import 'package:online_exam/features/exam/domain/repo/get_exam_on_id_repo.dart';

import '../../../../core/errors/failures.dart';

@Injectable(as: GetExamOnIdRepo)
class GetExamOnIdRepoImpl extends GetExamOnIdRepo {
  final ExamDataSource examDataSource;
  final InternetConnectionChecker internetConnectionChecker;

  GetExamOnIdRepoImpl(this.examDataSource, this.internetConnectionChecker);

  @override
  Future<Either<ServerFailure, ExamEntity>> getExamOnId(
      {required String examId}) async {
    bool isConnected = await internetConnectionChecker.hasConnection;
    if (isConnected) {
      final result = await examDataSource.getExamOnId(examId: examId);
      return result.fold(
        (failure) => left(failure),
        (exam) => right(exam.toExamEntity()),
      );
    } else {
      return left(ServerFailure(
          errorMessage:
              "Please check your internet connection and try again later"));
    }
  }
}
