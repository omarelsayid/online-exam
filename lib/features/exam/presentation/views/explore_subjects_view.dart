import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/helper_function/show_snackbar.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/exam/presentation/cubits/explore_subjects_cubit/explore_subjects_cubit.dart';
import 'package:online_exam/features/exam/presentation/cubits/explore_subjects_cubit/explore_subjects_state.dart';
import 'package:online_exam/features/exam/presentation/views/exams_on_subjects_view.dart';

class ExploreSubjectsView extends StatefulWidget {
  const ExploreSubjectsView({super.key});

  @override
  State<ExploreSubjectsView> createState() => _ExploreSubjectsViewState();
}

class _ExploreSubjectsViewState extends State<ExploreSubjectsView> {
  ExploreSubjectsCubit exploreSubjectsCubit = getIt();

  @override
  void initState() {
    // TODO: implement initState
    exploreSubjectsCubit.getAllSubjects();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => exploreSubjectsCubit,
      child: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(left: 10.0.w, right: 10.0.w, top: 24.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Survey',
                style: AppTextStyles.inter500_20.copyWith(color: primayColor),
              ),
               SizedBox(
                height: 20.h,
              ),
              buildSearchContainer(),
               SizedBox(
                height: 30.h ,
              ),
              Text(
                'Browse by subject',
                style: AppTextStyles.inter500_18.copyWith(color: blackColor),
              ),
               SizedBox(
                height: 20.h,
              ),
              buildBlocConsumer(),
               SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BlocConsumer<ExploreSubjectsCubit, ExploreSubjectsState> buildBlocConsumer() {
    return BlocConsumer<ExploreSubjectsCubit, ExploreSubjectsState>(
      builder: (context, state) {
        if (state is ExploreSubjectsLoadingState) {
          return buildLoading();
        } else if (state is ExploreSubjectsSuccessState) {
          if (state.subjects.isEmpty) {
            return buildEmptyData();
          } else {
            return buildSubjectsList(state);
          }
        } else {
          return Container();
        }
      },
      listener: (context, state) {
        if (state is ExploreSubjectsErrorState) {
          ShowErrorSnackbar(state.errorMessage, context);
        }
      },
    );
  }

  Center buildEmptyData() {
    return Center(
        child: Text(
      'No Data',
      style: AppTextStyles.inter500_20.copyWith(color: greyColor),
    ));
  }

  Center buildLoading() =>
      Center(child: CircularProgressIndicator(color: primayColor));

  Expanded buildSubjectsList(ExploreSubjectsSuccessState state) {
    return buildListViewBuilder(state);
  }

  Expanded buildListViewBuilder(ExploreSubjectsSuccessState state) {
    return Expanded(
      child: ListView.separated(
        itemCount: state.subjects.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Navigator.pushNamed(context, ExamsOnSubjectsView.routeName,
                    arguments: state.subjects[index]);
              },
              child: buildSubjectsContainer(context, state, index));
        },
        separatorBuilder: (context, index) {
          return  SizedBox(
            height: 12.h,
          );
        },
      ),
    );
  }

  Container buildSubjectsContainer(
      BuildContext context, ExploreSubjectsSuccessState state, int index) {
    return Container(
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
      child: buildSubjectRow(state, index, context),
    );
  }

  Row buildSubjectRow(
      ExploreSubjectsSuccessState state, int index, BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: state.subjects[index].icon!,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          width: MediaQuery.of(context).size.width * .15,
          height: MediaQuery.of(context).size.height * .15,
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          state.subjects[index].name!,
          style: AppTextStyles.inter400_16.copyWith(color: blackColor),
        ),
      ],
    );
  }

  Container buildSearchContainer() {
    return Container(
      padding:  EdgeInsets.all(16.dg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: blackColor,
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
          ),
          SizedBox(
            width: 12.h,
          ),
          Text(
            'Search',
            style: AppTextStyles.inter500_14.copyWith(color: greyColor),
          ),
        ],
      ),
    );
  }
}
