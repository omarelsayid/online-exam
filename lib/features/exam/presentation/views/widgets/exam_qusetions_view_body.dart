import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/constans.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/exam/domain/entites/exam_entity.dart';
import 'package:online_exam/features/exam/domain/entites/qusetion_entity.dart';
import 'package:online_exam/features/exam/domain/entites/user_answer_entity.dart';
import 'package:online_exam/features/exam/presentation/cubits/get_all_qusetions_on_exam_cubit/get_all_qusetions_on_exam_cubit.dart';
import 'package:online_exam/features/exam/presentation/cubits/get_all_qusetions_on_exam_cubit/get_all_qusetions_on_exam_states.dart';
import 'package:online_exam/features/exam/presentation/views/widgets/current_question_index_widget.dart';
import 'package:online_exam/features/exam/presentation/views/widgets/custom_elevated_button.dart';
import 'package:online_exam/features/exam/presentation/views/widgets/progress_bar_widget.dart';
import 'package:online_exam/features/exam/presentation/views/widgets/question_text_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ExamQusetionsViewBody extends StatefulWidget {
  const ExamQusetionsViewBody({super.key, required this.exam});
  final ExamEntity exam;

  @override
  State<ExamQusetionsViewBody> createState() => _ExamQusetionsViewBodyState();
}

class _ExamQusetionsViewBodyState extends State<ExamQusetionsViewBody> {
  int currentQuestionIndex = 0;
  int? selectedAnswer; // Store the selected choice index
  List<UserAnswerEntity> userAnswers = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAllQusetionsOnExamCubit, GetAllQuestionOnExamStates>(
      listener: (context, state) {
        if (state is GetAllQusetionsOnExamSuccessState) {
          userAnswers = List.generate(
            state.qusetionsResponse.length,
            (index) => UserAnswerEntity(),
          );
        }
      },
      builder: (context, state) {
        if (state is GetAllQusetionsOnExamLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetAllQusetionsOnExamSuccessState) {
          final List<QusetionEntity> questions = state.qusetionsResponse;
          final currentQuestion = questions[currentQuestionIndex];

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding.w),
            child: Column(
              children: [
                SizedBox(height: 8.h),
                CurrentQuestionIndexWidget(
                  currentQuestionIndex: currentQuestionIndex,
                  questions: questions,
                ),
                SizedBox(height: 3.h),
                ProgressBarWidget(
                  questions: questions,
                  currentQuestionIndex: currentQuestionIndex,
                ),
                SizedBox(height: 28.h),
                QuestionTextWidget(currentQuestion: currentQuestion),
                SizedBox(height: 24.h),
                SizedBox(
                    width: 343.w,
                    height: 260.h,
                    child: _answersWidget(currentQuestion)),
                SizedBox(height: 80.h),
                Row(
                  children: [
                    CustomElevatedButton(
                        text: 'Back',
                        onPressed: () =>
                            _previousQusetion(questions, currentQuestion),
                        backgroundColor: backgroundColor,
                        textColor: primayColor,
                        borderColor: primayColor),
                    SizedBox(width: 16.w),
                    CustomElevatedButton(
                        text: 'Next',
                        onPressed: () =>
                            _nextQusetion(questions, currentQuestion),
                        backgroundColor: primayColor,
                        textColor: backgroundColor,
                        borderColor: primayColor),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }

  void _nextQusetion(
      List<QusetionEntity> questions, QusetionEntity currentQuestion) {
    if (selectedAnswer != null) {
      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          userAnswers[currentQuestionIndex] = UserAnswerEntity(
            questionId: currentQuestion.id,
            userAnswer: ' A${1 + selectedAnswer!}',
            correctAnswer: currentQuestion.correctKey,
          );
          log(userAnswers[0].userAnswer.toString());
          currentQuestionIndex++;
          selectedAnswer = null;
        });
      }
    } else {
      // show snack bar from the top
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.info(
          message:
              "Please select an answer before moving to the next question.",
        ),
      );
    }
  }

  void _previousQusetion(
      List<QusetionEntity> questions, QusetionEntity currentQuestion) {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  ListView _answersWidget(QusetionEntity currentQuestion) {
    return ListView.builder(
      itemCount: currentQuestion.answers!.length,
      itemBuilder: (context, index) {
        final choice = currentQuestion.answers![index];

        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: RadioListTile<int>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            selected: selectedAnswer == index,
            tileColor: Color(0xffedeff3),
            selectedTileColor:
                selectedAnswer == index ? const Color(0xffCCD7EB) : null,
            activeColor: primayColor,
            title: Text(
              choice.answer,
              style: AppTextStyles.inter400_14.copyWith(color: blackColor),
            ),
            value: index, // Store index instead of 0
            groupValue: selectedAnswer, // Compare with selected index
            onChanged: (value) {
              setState(() {
                selectedAnswer = value;
              });
            },
          ),
        );
      },
    );
  }
}
