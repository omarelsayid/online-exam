import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/features/exam/domain/entites/exam_entity.dart';
import 'package:online_exam/features/exam/domain/entites/qusetion_entity.dart';
import 'package:online_exam/features/exam/presentation/cubits/get_all_qusetions_on_exam_cubit/get_all_qusetions_on_exam_cubit.dart';
import 'package:online_exam/features/exam/presentation/cubits/get_all_qusetions_on_exam_cubit/get_all_qusetions_on_exam_states.dart';

class ExamQusetionsViewBody extends StatefulWidget {
  const ExamQusetionsViewBody({super.key, required this.exam});
  final ExamEntity exam;

  @override
  State<ExamQusetionsViewBody> createState() => _ExamQusetionsViewBodyState();
}

class _ExamQusetionsViewBodyState extends State<ExamQusetionsViewBody> {
  int currentQuestionIndex = 0;
  String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAllQusetionsOnExamCubit, GetAllQuestionOnExamStates>(
      listener: (context, state) {
        if (state is GetAllQusetionsOnExamSuccessState) {
          log('State changed: Questions loaded successfully');
        }
      },
      builder: (context, state) {
        if (state is GetAllQusetionsOnExamLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetAllQusetionsOnExamSuccessState) {
          final List<QusetionEntity> questions = state.qusetionsResponse;

          if (questions.isEmpty) {
            return const Center(child: Text("No questions available"));
          }

          final currentQuestion = questions[currentQuestionIndex];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  currentQuestion.question!,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView(
                  children: currentQuestion.answers!.map<Widget>((choice) {
                    return RadioListTile(
                      title: Text(choice.answer),
                      value: choice.answer,
                      groupValue: selectedAnswer,
                      onChanged: (value) {
                        setState(() {
                          selectedAnswer = value.toString();
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              if (currentQuestionIndex < questions.length - 1)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentQuestionIndex++;
                      selectedAnswer = null; // Reset answer selection for the next question
                    });
                  },
                  child: const Text("Next"),
                ),
            ],
          );
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }
}