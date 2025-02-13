import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/constans.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/auth/presentation/cubits/reset_password_cubit/reset_password_state.dart';
import 'package:online_exam/features/auth/presentation/cubits/reset_password_cubit/reset_password_view_model.dart';
import 'package:online_exam/features/auth/presentation/views/sigin_view.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});
  static const String routeName = 'resetPasswordView';

  @override
  State<ResetPasswordView> createState() => _ResetPasswordView();
}

class _ResetPasswordView extends State<ResetPasswordView> {
  ResetPasswordViewModel resetPasswordViewModel = getIt();
  TextEditingController emailController = TextEditingController();

  AutovalidateMode validateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => resetPasswordViewModel,
      child: BlocListener<ResetPasswordViewModel, ResetPasswordViewModelState>(
        listener: (context, state) {
          if (state is ResetPasswordErrorState) {
            String errorMessage = (state).errorMessage;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ResetPasswordSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SiginView(),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Forget Password',
              style: AppTextStyles.roboto500_16,
            ),
            backgroundColor: primayColor,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Center(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'password',
                        hintText: 'Enter your password',
                      ),
                    ),
                  ),
                  BlocBuilder<ResetPasswordViewModel,
                      ResetPasswordViewModelState>(
                    builder: (context, state) {
                      if (state is ResetPasswordLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                validateMode == AutovalidateMode.disabled
                                    ? primayColor
                                    : secondaryColor,
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                validateMode = AutovalidateMode.disabled;
                              });
                              resetPasswordViewModel.resetPassword(
                                  email: emailController.text,
                                  newPassword: emailController.text);
                            } else {
                              setState(() {
                                validateMode = AutovalidateMode.always;
                              });
                            }
                          },
                          child: Text(
                            'Verify',
                            style: AppTextStyles.roboto500_16
                                .copyWith(color: Colors.white),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
