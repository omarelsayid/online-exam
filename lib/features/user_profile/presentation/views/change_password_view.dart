import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/features/user_profile/domain/repo/change_password_repo.dart';
import 'package:online_exam/features/user_profile/presentation/cubits/change_password_cubit/change_password_cubit.dart';
import 'package:online_exam/features/user_profile/presentation/views/widgets/change_password_widgets/change_password_body.dart';

import '../../../../core/services/di_service.dart';
import '../../domain/repo/logout_repo.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  static const String routeName = 'chnagePasswordView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(
          getIt.get<ChangePasswordRepo>(), getIt.get<LogoutRepo>()),
      child: ChangePasswordBody(),
    );
  }
}
