import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/features/exam/data/data_source/local_data_source/exam_result_local_ds.dart';

@Injectable(as: ExamResultLocalDataSource )
class ExamResultHiveDataSource implements ExamResultLocalDataSource {
  final Box _box;
  static const String _examResultKey = 'exam_results';

  ExamResultHiveDataSource(this._box);

  @override
  Future<List<dynamic>> getExamResults() async {
    final data = _box.get(_examResultKey);
    if (data == null) {
      return [];
    }
    return data as List<dynamic>;
  }

  @override
  Future<void> cacheExamResults(List<dynamic> examResults) async {
    await _box.put(_examResultKey, examResults);
  }

  @override
  Future<void> clearExamResults() async {
    await _box.delete(_examResultKey);
  }
}