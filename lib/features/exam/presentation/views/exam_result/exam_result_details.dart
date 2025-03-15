import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/constans.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../domain/entites/exam_result_entity.dart';

class ExamResultDetails extends StatelessWidget {
  final ExamResultEntity examResult;

  const ExamResultDetails({Key? key, required this.examResult}) : super(key: key);
  static const routeName = 'ExamResultDetails';

  @override
  Widget build(BuildContext context) {
    final questions = examResult.questions; // List<QuestionResultEntity>

    return Scaffold(
      appBar: buildCustomAppBar(
        title: examResult.examTitle,
        isVisible: true,
        context: context,
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          final questionText = question.questionText;
          final answers = question.answers ?? [];
          final correctKey = question.correctKey;
          final selectedAnswer = question.selectedAnswer;

          return Container(
            margin: EdgeInsets.symmetric(horizontal: kHorizontalPadding.w),
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
                SizedBox(height: 8.h),
                ...answers.map((ans) {
                  final ansText = ans.answer;
                  final ansKey = ans.key;

                  final bool isCorrect = ansKey == correctKey;
                  final bool isSelected = ansKey == selectedAnswer;
                  final bool isWrongAnswer =
                      selectedAnswer != null && selectedAnswer != correctKey;
                  final Color borderColor = isSelected
                      ? (isCorrect ? Colors.green : Colors.red)
                      : (isWrongAnswer && isCorrect
                      ? Colors.green
                      : Colors.transparent);
                  final Color backgroundColor = isSelected
                      ? (isCorrect
                      ? const Color(0xffCAF9CC)
                      : const Color(0xffF8D2D2))
                      : (isWrongAnswer && isCorrect
                      ? const Color(0xffDFF9E2)
                      : const Color(0xffEDEFF3));

                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: RadioListTile<String>(
                      tileColor: backgroundColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: borderColor, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      value: ansKey,
                      groupValue: selectedAnswer,
                      onChanged: (value) {},
                      activeColor: isCorrect ? Colors.green : Colors.red,
                      title: Text(
                        ansText,
                        style: AppTextStyles.inter500_18.copyWith(
                          color: const Color(0xFF0E0E0E),
                          fontSize: 14,
                        ),
                      ),
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
