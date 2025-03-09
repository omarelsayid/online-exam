import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_app_bar.dart';

class ExamResultDetails extends StatelessWidget {
  final Map<String, dynamic> examResult;

  const ExamResultDetails({Key? key, required this.examResult}) : super(key: key);
  static const routeName = 'ExamResultDetails';

  @override
  Widget build(BuildContext context) {
    final questions = examResult['questions'] as List<dynamic>? ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(examResult['examTitle'] ?? 'Exam Details'),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final q = questions[index] as Map<String, dynamic>;
          final questionText = q['questionText'] ?? '';
          final answers = q['answers'] as List<dynamic>? ?? [];
          final correctKey = q['correctKey'];
          final selectedAnswer = q['selectedAnswer'];

          return Card(
            child: ListTile(
              title: Text('Q${index + 1}: $questionText'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: answers.map((ans) {
                  final ansMap = ans as Map<String, dynamic>;
                  final ansText = ansMap['answer'] ?? '';
                  final ansKey = ansMap['key'] ?? '';

                  bool isCorrect = ansKey == correctKey;
                  bool isSelected = ansKey == selectedAnswer;

                  Color color = Colors.transparent;
                  if (isCorrect && isSelected) {
                    color = Colors.green.withOpacity(0.3);
                  } else if (isSelected && !isCorrect) {
                    color = Colors.red.withOpacity(0.3);
                  } else if (isCorrect) {
                    color = Colors.green.withOpacity(0.3);
                  }

                  return Container(
                    color: color,
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.all(8),
                    child: Text(ansText),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
