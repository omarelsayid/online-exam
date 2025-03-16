// exam_result_repository_impl.dart
import 'package:injectable/injectable.dart';
import 'package:online_exam/features/exam/domain/entites/exam_result_entity.dart';
import 'package:online_exam/features/exam/domain/repo/exam_result_repository.dart';
import '../data_source/local_data_source/exam_result_local_ds.dart';

@Injectable(as: ExamResultRepository)
class ExamResultRepositoryImpl implements ExamResultRepository {
  final ExamResultLocalDataSource localDataSource;

  ExamResultRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ExamResultEntity>> getAllExamResults() async {
    final examResultsData = await localDataSource.getExamResults();
    return examResultsData.map((data) {
      final Map<String, dynamic> stringMap = _convertKeysToCamelCase(data as Map);
      return ExamResultEntity.fromJson(stringMap);
    }).toList();
  }

  Map<String, dynamic> _convertKeysToCamelCase(Map<dynamic, dynamic> data) {
    final Map<String, dynamic> result = {};
    data.forEach((key, value) {
      String camelCaseKey = _snakeToCamel(key.toString());
      result[camelCaseKey] = value;
    });
    return result;
  }

  String _snakeToCamel(String input) {
    List<String> parts = input.split('_');
    String result = parts[0];
    for (int i = 1; i < parts.length; i++) {
      result += parts[i][0].toUpperCase() + parts[i].substring(1);
    }
    return result;
  }

  @override
  Future<void> addExamResult(ExamResultEntity examResult) async {
    await localDataSource.insertExamResult(examResult.toJson());
  }

  @override
  Future<void> clearExamResults() async {
    await localDataSource.clearExamResults();
  }
}
