import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/widgets/custom_app_bar.dart';
import 'package:online_exam/features/exam/domain/entites/exam_entity.dart';
import 'package:online_exam/features/exam/domain/repo/get_all_qusetions_on_exam_repo.dart';
import 'package:online_exam/features/exam/presentation/cubits/get_all_qusetions_on_exam_cubit/get_all_qusetions_on_exam_cubit.dart';
import 'package:online_exam/features/exam/presentation/views/widgets/exam_qusetions_view_body.dart';

class ExamQustionsView extends StatelessWidget {
  const ExamQustionsView({super.key});
  static const String routeName = 'examQustionsView';

  @override
  Widget build(BuildContext context) {
    final exam = ModalRoute.of(context)?.settings.arguments as ExamEntity;
    return BlocProvider<GetAllQusetionsOnExamCubit>(
        create: (context) =>
            GetAllQusetionsOnExamCubit(getIt.get<GetAllQusetionsOnExamRepo>()),
        child: Scaffold(
          appBar: buildCustomAppBar(
              title: 'Exam', isVisible: true, context: context),
          body: ExamQusetionsViewBody(
            exam: exam,
          ),
        ));
  }
}
