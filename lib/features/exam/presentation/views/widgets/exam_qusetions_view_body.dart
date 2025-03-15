  import 'dart:async';
  import 'dart:convert';

  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:online_exam/core/utils/app_colors.dart';
  import 'package:online_exam/core/utils/app_images.dart';
  import 'package:online_exam/core/utils/constans.dart';
  import 'package:online_exam/core/utils/text_styles.dart';
  import 'package:online_exam/features/exam/data/models/UserAnswerModel.dart';
  import 'package:online_exam/features/exam/domain/entites/exam_entity.dart';
  import 'package:online_exam/features/exam/domain/entites/qusetion_entity.dart';
  import 'package:online_exam/features/exam/domain/entites/user_answer_entity.dart';
  import 'package:online_exam/features/exam/presentation/cubits/get_all_qusetions_on_exam_cubit/get_all_qusetions_on_exam_cubit.dart';
  import 'package:online_exam/features/exam/presentation/cubits/get_all_qusetions_on_exam_cubit/get_all_qusetions_on_exam_states.dart';
  import 'package:online_exam/features/exam/presentation/views/exam_score_view.dart';
  import 'package:online_exam/features/exam/presentation/views/widgets/current_question_index_widget.dart';
  import 'package:online_exam/features/exam/presentation/views/widgets/custom_elevated_button.dart';
  import 'package:online_exam/features/exam/presentation/views/widgets/progress_bar_widget.dart';
  import 'package:online_exam/features/exam/presentation/views/widgets/question_text_widget.dart';
  import 'package:top_snackbar_flutter/custom_snack_bar.dart';
  import 'package:top_snackbar_flutter/top_snack_bar.dart';

  import '../../../../../core/services/hive_db_service.dart';
import '../../../../../core/services/secure_storage_service.dart';
import '../../../domain/entites/exam_result_entity.dart';
import '../../cubits/exam_result_cubit/exam_result_cubit.dart';

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
    late Duration countdownDuration;
    late ValueNotifier<Duration> durationNotifier;
    Timer? timer;
    late List<QusetionEntity> questions;
    DateTime? _startTime;

    @override
    void initState() {
      countdownDuration = Duration(minutes: widget.exam.duration!.toInt());
      durationNotifier = ValueNotifier<Duration>(countdownDuration);
      startTimer();
      _startTime = DateTime.now();
      super.initState();
    }

    @override
    void dispose() {
      timer?.cancel();
      durationNotifier.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return BlocConsumer<GetAllQusetionsOnExamCubit, GetAllQuestionOnExamStates>(
        listener: (context, state) {
          if (state is GetAllQusetionsOnExamSuccessState) {
            if (state.qusetionsResponse.isEmpty) {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(
                  message: "No questions found",
                ),
              );
            } else {
              userAnswers = List.generate(
                state.qusetionsResponse.length,
                (index) => UserAnswerEntity(),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is GetAllQusetionsOnExamLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetAllQusetionsOnExamSuccessState) {
            if (state.qusetionsResponse.isEmpty) {
              return const Center(child: Text('No questions found'));
            } else {
              questions = state.qusetionsResponse;
              final currentQuestion = questions[currentQuestionIndex];

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          Assets.imagesAlram2,
                        ),
                        SizedBox(width: 8.w),
                        // Text(
                        //   (double.parse(widget.exam.duration.toString()))
                        //       .toString(),
                        // ),
                        ValueListenableBuilder<Duration>(
                          valueListenable: durationNotifier,
                          builder: (context, duration, child) {
                            return buildTime(duration);
                          },
                        )
                      ],
                    ),
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
                        height: 290.h,
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
            }
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      );
    }

    Widget buildTime(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      final totalSeconds = countdownDuration.inSeconds;
      final remainingSeconds = duration.inSeconds;
      final Color textColor =
          remainingSeconds > totalSeconds / 2 ? Colors.green : Colors.red;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildDigit(minutes, "minutes", textColor), // Pass color
          Text(
            ' : ',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
          ),
          buildDigit(seconds, "seconds", textColor), // Pass color
        ],
      );
    }

    Widget buildDigit(String digit, String type, Color color) {
      return Text(
        digit,
        key: ValueKey<String>("$type-$digit"),
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
      );
    }

    void startTimer() {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (durationNotifier.value.inSeconds > 0) {
          durationNotifier.value =
              Duration(seconds: durationNotifier.value.inSeconds - 1);
        } else {
          List<UserAnswerModel> userQuestionAnswer = questions.indexed
              .map((question) => question.$1 <= currentQuestionIndex
                  ? UserAnswerModel(
                      questionId:
                          userAnswers[question.$1].questionId ?? question.$2.id,
                      correct: userAnswers[question.$1].userAnswer ??
                          (selectedAnswer != null
                              ? 'A${1 + selectedAnswer!}'
                              : " "))
                  : UserAnswerModel(questionId: question.$2.id, correct: " "))
              .toList();

          // print(userQuestionAnswer.length);
          // print(user as StringQuestionAnswer[1].questionId);
          // print(userQuestionAnswer[1].correct);

          List<Map<String, dynamic>> jsonString = (jsonDecode(jsonEncode(
            userQuestionAnswer.map((answer) => answer.toJson()).toList(),
          )) as List<dynamic>)
              .cast<Map<String, dynamic>>();
          // print(jsonString);
          showTimerEndDialog(jsonString);

          _onExamFinish();
          timer.cancel(); // Stop the timer when time reaches 0
        }
      });
    }

    //==========================================================
    //======================Store Exam Result Function==========
    //==========================================================

    void _onExamFinish() async {
      // Calculate the time taken by the examinee
      final endTime = DateTime.now();
      final duration = endTime.difference(_startTime!);
      final usedMinutes = duration.inMinutes;
      final usedSeconds = duration.inSeconds % 60;

      // Count how many answers are correct
      int correctCount = 0;
      for (int i = 0; i < questions.length; i++) {
        if (userAnswers[i].userAnswer == questions[i].correctKey) {
          correctCount++;
        }
      }

      // Create the ExamResultEntity using the exam and question data.
      final examResult = ExamResultEntity(
        examTitle: widget.exam.title!,
        totalQuestions: questions.length,
        examDuration: widget.exam.duration!.toInt(),
        correctAnswers: correctCount,
        timeTakenMin: usedMinutes,
        timeTakenSec: usedSeconds,
        questions: questions.asMap().entries.map((entry) {
          final i = entry.key;
          final q = entry.value;
          final ua = userAnswers[i];

          // Map the answers using AnswerEntity.
          final answersList = q.answers?.map((a) => AnswerEntity(
            answer: a.answer,
            key: a.key,
          )).toList();

          return QuestionResultEntity(
            id: q.id!,
            questionText: q.question!,
            answers: answersList,
            correctKey: q.correctKey!,
            selectedAnswer: ua.userAnswer,
            answerIndex: ua.answerIndex,
            correctAnswer: ua.correctAnswer,
          );
        }).toList(),
      );

      context.read<ExamResultCubit>().addExamResult(examResult);
    }


    //==========================================================
    //==========================================================
    //==========================================================

    Future<dynamic> showTimerEndDialog(jsonString) {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            contentPadding: EdgeInsets.all(30),
            backgroundColor: Colors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min, // Prevent overflow
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/sand-clock 1.png', height: 50),
                    SizedBox(width: 10),
                    Text(
                      'Time Out !!',
                      style: AppTextStyles.roboto400_20
                          .copyWith(color: Colors.red, fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, ExamScoreView.routeName,
                        arguments: jsonString);
                  },
                  child: Text(
                    'View Score',
                    style:
                        AppTextStyles.roboto400_20.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    void _nextQusetion(
        List<QusetionEntity> questions, QusetionEntity currentQuestion) {
      if (selectedAnswer != null) {
        setState(() {
          userAnswers[currentQuestionIndex] = UserAnswerEntity(
            answerIndex: selectedAnswer,
            questionId: currentQuestion.id,
            userAnswer: 'A${1 + selectedAnswer!}',
            correctAnswer: currentQuestion.correctKey,
          );
        });
        if (currentQuestionIndex < questions.length - 1) {
          setState(() {
            currentQuestionIndex++;

            // ! save the asnwer (to understand it well look at  line 138)
            selectedAnswer =
                userAnswers[currentQuestionIndex].answerIndex ?? null;
          });
        } else {
          List<UserAnswerModel> userQuestionAnswer = userAnswers
              .map((answer) => UserAnswerModel(
                  questionId: answer.questionId, correct: answer.userAnswer))
              .toList();

          // String jsonString =
          // jsonEncode(userQuestionAnswer.map((answer) => answer.toJson()).toList());
          List<Map<String, dynamic>> jsonString = (jsonDecode(jsonEncode(
            userQuestionAnswer.map((answer) => answer.toJson()).toList(),
          )) as List<dynamic>)
              .cast<Map<String, dynamic>>();

          //
          // log(jsonString as String);
          // log(userQuestionAnswer[1].correct as String);
          // log(userQuestionAnswer.length as String);

          _onExamFinish();
          Navigator.pushReplacementNamed(context, ExamScoreView.routeName,
              arguments: jsonString);
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
          selectedAnswer = userAnswers[currentQuestionIndex].answerIndex;
        });
      }
    }

    ListView _answersWidget(QusetionEntity currentQuestion) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
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

                  // ! save the asnwer (to understand it well look at  line 138)
                  userAnswers[currentQuestionIndex].answerIndex = value;
                });
              },
            ),
          );
        },
      );
    }
  }
