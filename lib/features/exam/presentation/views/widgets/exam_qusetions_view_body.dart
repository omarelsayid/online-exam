import 'package:flutter/widgets.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/features/exam/domain/entites/exam_entity.dart';
import 'package:online_exam/features/exam/presentation/cubits/all_qusetions_on_exam_cubit/all_qusetions_on_exam_cubit.dart';

class ExamQusetionsViewBody extends StatefulWidget {
  const ExamQusetionsViewBody({super.key, required this.exam});
  final ExamEntity exam;
  @override
  State<ExamQusetionsViewBody> createState() => _ExamQusetionsViewBodyState();
}

class _ExamQusetionsViewBodyState extends State<ExamQusetionsViewBody> {
  AllQusetionsOnExamCubit getAllQuestionsOnExamCubit =
      getIt.get<AllQusetionsOnExamCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllQuestionsOnExamCubit.getAllQuestionsOnExam(
        examId: widget.exam.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('ExamQusetionsViewBody'),
    );
  }
}
