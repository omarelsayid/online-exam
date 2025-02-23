import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/helper_function/show_error_snackbar.dart';
import 'package:online_exam/features/user_profile/presentation/cubits/user_profile_cubit/user_profile_cubit.dart';
import 'package:online_exam/features/user_profile/presentation/cubits/user_profile_cubit/user_profile_states.dart';

class UserProfileViewBody extends StatelessWidget {
  const UserProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileCubit, UserProfileStates>(
      builder: (context, state) {
        if (state is UserProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserProfileLoaded) {
          return Center(
              child: Text(state.userProfileEntity.firstName.toString()));
        } else if (state is UserProfileInitial) {
          return ElevatedButton(
            child: const Text('Get User Profile'),
            onPressed: () {
              context
                  .read<UserProfileCubit>()
                  .getUserProfile(); // Use context.read instead of getIt
            },
          );
        } else if (state is UserProfileFailure) {
          return Center(child: Text(state.errorMessage));
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
      listener: (context, state) async {
        if (state is UserProfileLoaded) {
          log(state.userProfileEntity.toString());
        } else if (state is UserProfileFailure) {
          ShowSnackbar(state.errorMessage, context);
        }
      },
    );
  }
}
