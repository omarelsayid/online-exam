import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 00,
        surfaceTintColor: Colors.transparent,

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
            margin: EdgeInsets.all(8),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Q${index + 1}: $questionText',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),

                ...answers.map((ans) {
                  final ansMap = ans as Map<String, dynamic>;
                  final ansText = ansMap['answer'] ?? '';
                  final ansKey = ansMap['key'] ?? '';

                  final bool isCorrect = ansKey == correctKey;
                  final bool isSelected = ansKey == selectedAnswer;
                  final bool isWrongAnswer = selectedAnswer != null && selectedAnswer != correctKey;
                  final Color borderColor = isSelected
                      ? (isCorrect ? Colors.green : Colors.red)
                      : (isWrongAnswer && isCorrect ? Colors.green : Colors.transparent);

                  final Color backgroundColor = isSelected
                      ? (isCorrect ? Color(0xffCAF9CC) : Color(0xffF8D2D2))
                      : (isWrongAnswer && isCorrect ? Color(0xffDFF9E2) : Color(0xffEDEFF3));

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      border: Border.all(color: borderColor,width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: RadioListTile<String>(
                      value: ansKey,
                      groupValue: selectedAnswer,
                      onChanged: (value) => {},
                      activeColor: isCorrect ? Colors.green : Colors.red,

                      title: Text(ansText,style: TextStyle(color: Colors.black),),
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
