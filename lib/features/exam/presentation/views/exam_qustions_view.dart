import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/features/exam/domain/entites/exam_entity.dart';
import 'package:online_exam/features/exam/domain/repo/get_all_exams_on_subject_repo.dart';
import 'package:online_exam/features/exam/presentation/cubits/get_all_exams_on_subjects_cubit/get_all_exams_on_subjects_cubit.dart';
import 'package:online_exam/features/exam/presentation/views/widgets/exam_qusetions_view_body.dart';

class ExamQustionsView extends StatelessWidget {
  const ExamQustionsView({super.key});
  static const String routeName = 'examQustionsView';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return BlocProvider(
        create: (context) =>
            GetAllExamsOnSubjectsCubit(getIt.get<GetAllExamsOnSubjectRepo>()),
        child: Scaffold(
          body: const ExamQusetionsViewBody(),
        ));
  }
}
