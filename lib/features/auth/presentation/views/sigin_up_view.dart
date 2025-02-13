import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/features/auth/domain/repos/sigin_repo.dart';
import 'package:online_exam/features/auth/domain/repos/signup_repo.dart';
import 'package:online_exam/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:online_exam/features/auth/presentation/views/widgets/signup_widgets/signup_body.dart';

import '../../../../core/services/di_service.dart';
import '../../../../core/utils/text_styles.dart';

class SiginUpView extends StatelessWidget {
  const SiginUpView({super.key});
  static const String routeName = 'SiginUpView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupCubit>(
      create: (context) => SignupCubit(getIt<SignUpRepo>()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios)),
          title: Text(
            'SignUp',
            style: AppTextStyles.inter500_20,
          ),
        ),
        body:SignupBody(),
      ),
    );
  }
}
