import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/helper_function/show_error_snackbar.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/exam/presentation/cubits/explore_subjects_cubit/explore_subjects_cubit.dart';
import 'package:online_exam/features/exam/presentation/cubits/explore_subjects_cubit/explore_subjects_state.dart';

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
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Survey',
                style: AppTextStyles.inter500_20.copyWith(color: primayColor),
              ),
              const SizedBox(
                height: 20,
              ),
              buildSearchContainer(),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Browse by subject',
                style: AppTextStyles.inter500_18.copyWith(color: blackColor),
              ),
              const SizedBox(
                height: 20,
              ),
              buildBlocConsumer(),
              const SizedBox(
                height: 20,
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
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: MediaQuery.of(context).size.height * .1,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  spreadRadius: 0,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: buildSubjectRow(state, index, context),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 12,
          );
        },
      ),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: blackColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
          ),
          SizedBox(
            width: 12,
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
