import 'package:flutter/widgets.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/features/exam/presentation/cubits/all_qusetions_on_exam_cubit/all_qusetions_on_exam_cubit.dart';

class ExamQusetionsViewBody extends StatefulWidget {
  const ExamQusetionsViewBody({super.key});

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
        examId: '670070a830a3c3c1944a9c63');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('ExamQusetionsViewBody'),
    );
  }
}
