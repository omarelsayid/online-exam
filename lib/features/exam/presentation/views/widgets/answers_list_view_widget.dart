import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/exam/domain/entites/qusetion_entity.dart';

class AnswerslistViewWidget extends StatefulWidget {
  final QusetionEntity currentQuestion;
  final Function(int) onAnswerSelected;

  const AnswerslistViewWidget({
    super.key,
    required this.currentQuestion,
    required this.onAnswerSelected,
  });

  @override
  _AnswerslistViewWidgetState createState() => _AnswerslistViewWidgetState();
}

class _AnswerslistViewWidgetState extends State<AnswerslistViewWidget> {
  int? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.currentQuestion.answers!.length,
      itemBuilder: (context, index) {
        final choice = widget.currentQuestion.answers![index];

        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: RadioListTile<int>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            selected: selectedAnswer == index,
            tileColor: const Color(0xffedeff3),
            selectedTileColor:
                selectedAnswer == index ? const Color(0xffCCD7EB) : null,
            activeColor: primayColor,
            title: Text(
              choice.answer,
              style: AppTextStyles.inter400_14.copyWith(color: blackColor),
            ),
            value: index,
            groupValue: selectedAnswer,
            onChanged: (value) {
              setState(() {
                selectedAnswer = value;
              });

              widget.onAnswerSelected(value!);
            },
          ),
        );
      },
    );
  }
}
