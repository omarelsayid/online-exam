import 'package:flutter/material.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/exam/domain/entites/qusetion_entity.dart';

class CurrentQuestionIndexWidget extends StatelessWidget {
  const CurrentQuestionIndexWidget({
    super.key,
    required this.currentQuestionIndex,
    required this.questions,
  });

  final int currentQuestionIndex;
  final List<QusetionEntity> questions;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Question ${currentQuestionIndex + 1} of ${questions.length}',
      style: AppTextStyles.roboto500_16.copyWith(
        color: Color(0xFF535353),
        height: 1.43,
        letterSpacing: 0.10,
      ),
    );
  }
}
