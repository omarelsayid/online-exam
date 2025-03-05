import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:online_exam/features/exam/data/data_source/exam_data_source.dart';
import 'package:online_exam/features/exam/domain/entites/exam_entity.dart';
import 'package:online_exam/features/exam/domain/repo/get_all_exams_on_subject_repo.dart';

import '../../../../core/errors/failures.dart';

@Injectable(as: GetAllExamsOnSubjectRepo)
class GetAllExamOnSubjectRepoImpl extends GetAllExamsOnSubjectRepo {
  final ExamDataSource examDataSource;
  final InternetConnectionChecker internetConnectionChecker;

  GetAllExamOnSubjectRepoImpl(
      this.examDataSource, this.internetConnectionChecker);

  @override
  Future<Either<ServerFailure, List<ExamEntity>>> getAllExamsOnSubject(
      {required String subjectId}) async {
    bool isConnected = await internetConnectionChecker.hasConnection;
    if (isConnected) {
      final result =
          await examDataSource.getAllExamsOnSubject(subjectId: subjectId);
          
      return result.fold(
        (failure) => left(failure),
        (exams) => right(exams.map((e) => e.toExamEntity()).toList()),
      );
    } else {
      return left(ServerFailure(
          errorMessage:
              "Please check your internet connection and try again later"));
    }
  }
}
