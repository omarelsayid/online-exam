import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/helper_function/show_error_snackbar.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/exam/domain/entites/exam_entity.dart';
import 'package:online_exam/features/exam/presentation/cubits/get_exam_on_id_cubit/get_exam_on_id_cubit.dart';
import 'package:online_exam/features/exam/presentation/cubits/get_exam_on_id_cubit/get_exam_on_id_state.dart';
import 'package:online_exam/features/exam/presentation/views/exam_qustions_view.dart';

class ExamDetailsView extends StatefulWidget {
  const ExamDetailsView({super.key});
  static const routeName = 'ExamDetailsView';

  @override
  State<ExamDetailsView> createState() => _ExamDetailsViewState();
}

class _ExamDetailsViewState extends State<ExamDetailsView> {
  late String examId;

  GetExamOnIdCubit getExamOnIdCubit = getIt();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getExamOnIdCubit.getExamOnId(examId: examId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    examId = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (context) => getExamOnIdCubit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: BlocConsumer<GetExamOnIdCubit, GetExamOnIdState>(
          listener: (context, state) {
            if (state is GetExamOnIdErrorState) {
              ShowErrorSnackbar(state.errorMessage, context);
            }
          },
          builder: (context, state) {
            if (state is GetExamOnIdLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetExamOnIdSuccessState) {
              return buildExamDetails(state.exam);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Padding buildExamDetails(ExamEntity exam) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('assets/images/exam.png'),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exam.title ?? '',
                      style:
                          AppTextStyles.inter600_20.copyWith(color: blackColor),
                    ),
                  ],
                ),
              ),
              Text(
                '${exam.duration} Minutes',
                style: AppTextStyles.inter400_16.copyWith(color: primayColor),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '${exam.numberOfQuestions ?? ''} Questions',
            style: AppTextStyles.inter400_16.copyWith(color: greyColor),
          ),
          const SizedBox(
            height: 30,
          ),
          Divider(
            color: greyColor,
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primayColor,
            ),
            onPressed: () {
              Navigator.pushNamed(context, ExamQustionsView.routeName,
                  arguments: exam);
            },
            child: Text(
              'Start',
              style: AppTextStyles.roboto500_16.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
