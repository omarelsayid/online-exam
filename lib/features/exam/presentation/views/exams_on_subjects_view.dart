import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/helper_function/show_snackbar.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/exam/data/models/Subjects.dart';
import 'package:online_exam/features/exam/domain/entites/exam_entity.dart';
import 'package:online_exam/features/exam/presentation/cubits/get_all_exams_on_subjects_cubit/get_all_exams_on_subjects_cubit.dart';
import 'package:online_exam/features/exam/presentation/cubits/get_all_exams_on_subjects_cubit/get_all_exams_on_subjects_state.dart';
import 'package:online_exam/features/exam/presentation/views/exam_details_view.dart';

class ExamsOnSubjectsView extends StatefulWidget {
  const ExamsOnSubjectsView({super.key});
  static const routeName = 'ExamsOnSubjectsView';

  @override
  State<ExamsOnSubjectsView> createState() => _ExamsOnSubjectsViewState();
}

class _ExamsOnSubjectsViewState extends State<ExamsOnSubjectsView> {
  late Subjects subject;
  GetAllExamsOnSubjectsCubit getAllExamsOnSubjectsCubit = getIt();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAllExamsOnSubjectsCubit.getAllExamsOnSubject(subjectId: subject.id!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    subject = ModalRoute.of(context)!.settings.arguments as Subjects;
    return BlocProvider(
      create: (context) => getAllExamsOnSubjectsCubit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(subject.name!),
        ),
        body: Padding(
          padding:  EdgeInsets.only(left: 16.0.w, right: 16.w, top: 24.0.h),
          child: BlocConsumer<GetAllExamsOnSubjectsCubit,
              GetAllExamsOnSubjectsState>(
            listener: (context, state) {
              if (state is GetAllExamsOnSubjectsErrorState) {
                ShowErrorSnackbar(state.errorMessage, context);
              }
            },
            builder: (context, state) {
              if (state is GetAllExamsOnSubjectsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetAllExamsOnSubjectsSuccessState) {
                if (state.exams.isEmpty) {
                  return Center(
                    child: Text(
                      'No exams available',
                      style:
                          AppTextStyles.inter500_16.copyWith(color: blackColor),
                    ),
                  );
                } else {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return buildExamContainer(state.exams[index]);
                    },
                    separatorBuilder: (context, index) {
                      return  SizedBox(
                        height: 20.h,
                      );
                    },
                    itemCount: state.exams.length,
                  );
                }
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildExamContainer(ExamEntity exam) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ExamDetailsView.routeName,
            arguments: exam.id);
      },
      child: Container(
        margin:  EdgeInsets.symmetric(horizontal: 8.w),
        height: MediaQuery.of(context).size.height * .1,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.r,
              spreadRadius: 0.r,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: buildExamRow(exam),
      ),
    );
  }

  Row buildExamRow(ExamEntity exam) {
    return Row(
      children: [
        Image.asset('assets/images/exam.png'),
         SizedBox(
          width: 16.w,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exam.title ?? '',
                style: AppTextStyles.inter500_16.copyWith(color: blackColor),
              ),
              Text(
                "${exam.numberOfQuestions ?? ''} Questions ",
                style: AppTextStyles.inter400_13.copyWith(color: greyColor),
              ),
            ],
          ),
        ),
        Text(
          '${exam.duration} Minutes',
          style: AppTextStyles.inter400_13.copyWith(color: primayColor),
        ),
      ],
    );
  }
}
