import 'package:flutter/material.dart';
import '../../../../../core/services/secure_storage_service.dart';

// 1. Paste the helper function somewhere in this file (above or below the widget).
String getCategoryFromTitle(String examTitle) {
  final lowerTitle = examTitle.toLowerCase();

  if (lowerTitle.contains('html') ||
      lowerTitle.contains('c++') ||
      lowerTitle.contains('flutter') ||
      lowerTitle.contains('java') ||
      lowerTitle.contains('python') ||
      lowerTitle.contains('javascript') ||
      lowerTitle.contains('dart')) {
    return 'Programming';
  }

  if (lowerTitle.contains('html') ||
      lowerTitle.contains('french') ||
      lowerTitle.contains('arabic') ||
      lowerTitle.contains('spanish')) {
    return 'Language';
  }

  if (lowerTitle.contains('math') ||
      lowerTitle.contains('algebra') ||
      lowerTitle.contains('geometry') ||
      lowerTitle.contains('calculus')) {
    return 'Math';
  }

  return 'Unknown';
}

class ExamResult extends StatefulWidget {
  const ExamResult({Key? key}) : super(key: key);

  @override
  State<ExamResult> createState() => _ExamResultState();
}

class _ExamResultState extends State<ExamResult> {
  late Future<List<dynamic>> _futureResults;

  @override
  void initState() {
    super.initState();
    _futureResults = SecureStorageService.getAllExamResults();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Results'),
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _futureResults,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final results = snapshot.data!;
          if (results.isEmpty) {
            return const Center(child: Text('No exam attempts found.'));
          }

          final Map<String, List<Map<String, dynamic>>> groupedByCategory = {};

          for (var item in results) {
            final map = item as Map<String, dynamic>;

            final examTitle = map['examTitle'] ?? 'Untitled Exam';
            final category = getCategoryFromTitle(examTitle);
            if (!groupedByCategory.containsKey(category)) {
              groupedByCategory[category] = [];
            }
            groupedByCategory[category]!.add(map);
          }
          return ListView(
            padding: const EdgeInsets.only(top: kToolbarHeight+12),
            children: groupedByCategory.entries.map((entry) {
              final categoryName = entry.key;
              final examsInCategory = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                    child: Text(
                      categoryName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),


                  ...examsInCategory.map((examMap) {
                    final examTitle = examMap['examTitle'] ?? '';
                    final examDuration = examMap['examDuration'] ?? 0; // minutes
                    final totalQuestions = examMap['totalQuestions'] ?? 0;
                    final correctAnswers = examMap['correctAnswers'] ?? 0;
                    final usedMin = examMap['timeTakenMin'] ?? 0;
                    final usedSec = examMap['timeTakenSec'] ?? 0;

                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "ExamResultDetails",
                          arguments: examMap,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      examTitle,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '$examDuration Minutes',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),

                                // Total questions
                                Text(
                                  '$totalQuestions Question',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                Text(
                                  '$correctAnswers correct answers in $usedMin min $usedSec sec',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await SecureStorageService.clearExamResults();
          setState(() {
            _futureResults = SecureStorageService.getAllExamResults();
          });
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}
