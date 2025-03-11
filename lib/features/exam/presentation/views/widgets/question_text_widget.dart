import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/exam/domain/entites/qusetion_entity.dart';

class QuestionTextWidget extends StatelessWidget {
  const QuestionTextWidget({
    super.key,
    required this.currentQuestion,
  });

  final QusetionEntity currentQuestion;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 291.w,
          child: Text(
            currentQuestion.question!,
            style: AppTextStyles.inter500_18.copyWith(color: Color(0xFF0E0E0E)),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
