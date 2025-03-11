import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/features/exam/domain/entites/qusetion_entity.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({
    super.key,
    required this.questions,
    required this.currentQuestionIndex,
  });

  final List<QusetionEntity> questions;
  final int currentQuestionIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 4.h,
      child: LinearProgressBar(
        maxSteps: questions.length,
        progressType: LinearProgressBar.progressTypeLinear,
        currentStep: currentQuestionIndex + 1,
        progressColor: primayColor,
        backgroundColor: Color(0xffCFCFCF),
        borderRadius: BorderRadius.circular(100), //  NEW
      ),
    );
  }
}
