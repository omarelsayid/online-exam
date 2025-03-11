import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:online_exam/features/exam/data/data_source/exam_data_source.dart';
import 'package:online_exam/features/exam/data/models/Subjects.dart';
import 'package:online_exam/features/exam/domain/repo/get_all_subjects_repo.dart';

import '../../../../core/errors/failures.dart';

@Injectable(as: GetAllSubjectsRepo)
class GetAllSubjectsRepoImpl extends GetAllSubjectsRepo {
  final ExamDataSource examDataSource;
  final InternetConnectionChecker internetConnectionChecker;

  GetAllSubjectsRepoImpl(this.examDataSource, this.internetConnectionChecker);
  @override
  Future<Either<ServerFailure, List<Subjects>>> getAllSubjects() async {
    bool isConnected = await internetConnectionChecker.hasConnection;
    if (isConnected) {
      return examDataSource.getAllSubjects();
    } else {
      return left(ServerFailure(
          errorMessage:
              "Please check your internet connection and try again later"));
    }
  }
}
