import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/widgets/custom_app_bar.dart';
import 'package:online_exam/features/auth/domain/repos/sigin_repo.dart';
import 'package:online_exam/features/auth/presentation/cubits/sigin_cubit/sigin_cubit.dart';
import 'package:online_exam/features/auth/presentation/views/widgets/sigin_view_body.dart';

class SiginView extends StatelessWidget {
  const SiginView({super.key});
  static const String routeName = 'siginView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SiginCubit>(
      create: (context) => SiginCubit(getIt<SigninRepo>()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildCustomAppBar(
            title: 'Login', isVisible: false, context: context),
        body: SiginViewBody(),
      ),
    );
  }
}
