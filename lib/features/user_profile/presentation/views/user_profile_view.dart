import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/widgets/custom_app_bar.dart';
import 'package:online_exam/features/user_profile/domain/repo/get_user_profile_repo.dart';
import 'package:online_exam/features/user_profile/presentation/cubits/user_profile_cubit/user_profile_cubit.dart';
import 'package:online_exam/features/user_profile/presentation/views/widgets/sigin_view_body_bloc_consumer.dart';
import 'package:online_exam/features/user_profile/presentation/views/widgets/user_profile_view_body.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileCubit(getIt.get<GetUserProfileRepo>()),
      child: Scaffold(
        appBar: buildCustomAppBar(
            title: 'Profile', isVisible: false, context: context),
        body: UserProfileViewBodyBlocConsumer(),
      ),
    );
  }
}
