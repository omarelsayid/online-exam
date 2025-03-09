import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/exam/presentation/cubits/check_questions_cubit/check_questions_cubit.dart';
import 'package:online_exam/features/exam/presentation/cubits/check_questions_cubit/check_questions_state.dart';
import 'package:online_exam/main_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ExamScoreView extends StatefulWidget {
  const ExamScoreView({super.key});

  static const String routeName = 'ExamScoreView';

  @override
  State<ExamScoreView> createState() => _ExamScoreViewState();
}

class _ExamScoreViewState extends State<ExamScoreView> {
  late List<Map<String, dynamic>> answers;
  CheckQuestionsCubit checkQuestionsCubit = getIt();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // print(answers);
      checkQuestionsCubit.checkQuestions(answers: answers);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    answers = ModalRoute.of(context)!.settings.arguments
        as List<Map<String, dynamic>>;
    return BlocProvider(
      create: (context) => checkQuestionsCubit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Exam Score'),
        ),
        body: BlocConsumer<CheckQuestionsCubit, CheckQuestionsState>(
          listener: (context, state) {
            if (state is CheckQuestionsErrorState) {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(
                  message: state.errorMessage,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CheckQuestionsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CheckQuestionsSuccessState) {
              return buildBodyView(state, context);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Padding buildBodyView(
      CheckQuestionsSuccessState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Score',
            style: AppTextStyles.inter500_18,
          ),
          SizedBox(
            height: 20,
          ),
          buildScoreInfo(state),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, MainView.routeName);
            },
            child: Text(
              'Start Again',
              style: AppTextStyles.roboto500_16.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Row buildScoreInfo(CheckQuestionsSuccessState state) {
    return Row(
      children: [
        buildCircularPercentIndicator(state),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            buildCorrectInfo(state),
            SizedBox(
              height: 10,
            ),
            buildIncorrectInfo(state),
          ],
        ),
      ],
    );
  }

  Row buildIncorrectInfo(CheckQuestionsSuccessState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Incorrect',
          style: AppTextStyles.inter500_16.copyWith(color: Colors.red),
        ),
        SizedBox(
          width: 40,
        ),
        Container(
          width: 25,
          height: 25,
          padding: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(110),
            border: Border.all(color: Colors.red),
          ),
          child: Text(
            state.checkQuestionResponse.wrong.toString(),
            textAlign: TextAlign.center,
            style: AppTextStyles.inter500_14
                .copyWith(fontSize: 13, color: Colors.red),
          ),
        )
      ],
    );
  }

  Row buildCorrectInfo(CheckQuestionsSuccessState state) {
    return Row(
      children: [
        Text(
          'Correct',
          style: AppTextStyles.inter500_16.copyWith(color: primayColor),
        ),
        SizedBox(
          width: 50,
        ),
        Container(
          width: 25,
          height: 25,
          padding: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(110),
            border: Border.all(color: primayColor),
          ),
          child: Text(
            state.checkQuestionResponse.correct.toString(),
            textAlign: TextAlign.center,
            style: AppTextStyles.inter500_14
                .copyWith(fontSize: 13, color: primayColor),
          ),
        )
      ],
    );
  }

  CircularPercentIndicator buildCircularPercentIndicator(
      CheckQuestionsSuccessState state) {
    return CircularPercentIndicator(
      radius: 60.0,
      lineWidth: 6.0,
      animation: true,
      percent:
          double.parse(state.checkQuestionResponse.total!.replaceAll('%', ''))
                  .round() /
              100,
      center: Text(
        "${double.parse(state.checkQuestionResponse.total!.replaceAll('%', '')).round()}%",
        style: AppTextStyles.inter500_20,
      ),
      circularStrokeCap: CircularStrokeCap.square,
      backgroundColor: Colors.red,
      progressColor: primayColor,
    );
  }
}
