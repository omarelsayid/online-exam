abstract class ExamResultLocalDataSource {
  Future<List<dynamic>> getExamResults();
  Future<void> cacheExamResults(List<dynamic> examResults);
  Future<void> clearExamResults();
}