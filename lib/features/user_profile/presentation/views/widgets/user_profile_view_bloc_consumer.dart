import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/helper_function/show_snackbar.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/features/user_profile/presentation/cubits/user_profile_cubit/user_profile_cubit.dart';
import 'package:online_exam/features/user_profile/presentation/cubits/user_profile_cubit/user_profile_states.dart';
import 'package:online_exam/features/user_profile/presentation/views/widgets/user_profile_view_body.dart';

class UserProfileViewBodyBlocConsumer extends StatefulWidget {
  const UserProfileViewBodyBlocConsumer({super.key});
 
  @override
  State<UserProfileViewBodyBlocConsumer> createState() =>
      _UserProfileViewBodyBlocConsumerState();
}

class _UserProfileViewBodyBlocConsumerState
    extends State<UserProfileViewBodyBlocConsumer> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<UserProfileCubit>().getUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileCubit, UserProfileStates>(
      listener: (context, state) {
        if (state is UserProfileFailure) {
          ShowErrorSnackbar(state.errorMessage, context);
        }
      },
      builder: (context, state) {
        if (state is UserProfileLoaded) {
          return UserProfileViewBody(
            userProfileEntity: state.userProfileEntity,
          );
        } else if (state is UserProfileLoading) {
          return Center(child: CircularProgressIndicator(color: primayColor));
        } else {
          return const Center(child: Text('There is no data'));
        }
      },
    );
  }
}
