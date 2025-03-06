import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/features/exam/domain/entites/exam_entity.dart';
import 'package:online_exam/features/exam/presentation/cubits/get_all_qusetions_on_exam_cubit/get_all_qusetions_on_exam_cubit.dart';
import 'package:online_exam/features/exam/presentation/cubits/get_all_qusetions_on_exam_cubit/get_all_qusetions_on_exam_states.dart';

class ExamQusetionsViewBody extends StatefulWidget {
  const ExamQusetionsViewBody({super.key, required this.exam});
  final ExamEntity exam;
  @override
  State<ExamQusetionsViewBody> createState() => _ExamQusetionsViewBodyState();
}

class _ExamQusetionsViewBodyState extends State<ExamQusetionsViewBody> {
  GetAllQusetionsOnExamCubit getAllQuestionsOnExamCubit =
      getIt.get<GetAllQusetionsOnExamCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllQuestionsOnExamCubit.getAllQuestionsOnExam(
        examId: widget.exam.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAllQusetionsOnExamCubit,
            GetAllQusetionsOnExamStates>(
        builder: (context, state) {
          if (state is GetAllQusetionsOnExamLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: primayColor,
              ),
            );
          } else if (state is GetAllQusetionsOnExamSuccessState) {
            return Text('');
          } else {
            return Text('');
          }
        },
        listener: (context, state) {});
  }
}
