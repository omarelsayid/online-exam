// exam_result_sqlite_ds.dart
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/services/database_helper.dart';
import 'exam_result_local_ds.dart';

@Injectable(as: ExamResultLocalDataSource)
class ExamResultSqliteDataSource implements ExamResultLocalDataSource {
  final DatabaseHelper databaseHelper;

  ExamResultSqliteDataSource(this.databaseHelper);

  @override
  Future<List<dynamic>> getExamResults() async {
    final db = await databaseHelper.database;
    final results = await db.query('exam_results');
    return results.map((row) {
      // Check if 'questions' is null before decoding.
      return {
        ...row,
        'questions': row['questions'] != null
            ? json.decode(row['questions'] as String)
            : [],
      };
    }).toList();
  }

  @override
  Future<void> cacheExamResults(List<dynamic> examResults) async {
    final db = await databaseHelper.database;
    // Clear existing records
    await db.delete('exam_results');
    // Insert each exam result
    for (var examResult in examResults) {
      final examResultCopy = Map<String, dynamic>.from(examResult);
      if (examResultCopy.containsKey('questions')) {
        examResultCopy['questions'] = json.encode(examResultCopy['questions']);
      }
      await db.insert('exam_results', examResultCopy);
    }
  }

  @override
  Future<void> clearExamResults() async {
    final db = await databaseHelper.database;
    await db.delete('exam_results');
  }

  @override
  Future<void> insertExamResult(Map<String, dynamic> examResult) async {
    final db = await databaseHelper.database;
    final examResultCopy = {
      'exam_title': examResult['examTitle'],
      'total_questions': examResult['totalQuestions'],
      'exam_duration': examResult['examDuration'],
      'correct_answers': examResult['correctAnswers'],
      'time_taken_min': examResult['timeTakenMin'],
      'time_taken_sec': examResult['timeTakenSec'],
      'questions': json.encode(examResult['questions']),
    };
    await db.insert('exam_results', examResultCopy);
  }
}
