import 'package:injectable/injectable.dart';
import 'package:online_exam/features/exam/domain/repo/exam_result_repository.dart';


import '../../domain/entites/exam_result_entity.dart';
import '../data_source/local_data_source/exam_result_local_ds.dart';

@Injectable(as: ExamResultRepository )
class ExamResultRepositoryImpl implements ExamResultRepository {
  final ExamResultLocalDataSource localDataSource;

  ExamResultRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ExamResultEntity >> getAllExamResults() async {
    final examResultsData = await localDataSource.getExamResults();
    return examResultsData
        .map((data) => ExamResultEntity .fromJson(Map<String, dynamic>.from(data)))
        .toList();
  }

  @override
  Future<void> addExamResult(ExamResultEntity  examResult) async {
    final currentResults = await localDataSource.getExamResults();
    currentResults.add(examResult.toJson());
    await localDataSource.cacheExamResults(currentResults);
  }

  @override
  Future<void> clearExamResults() async {
    await localDataSource.clearExamResults();
  }
}