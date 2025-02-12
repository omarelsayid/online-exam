import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/base_api_state.dart';
import 'package:online_exam/core/utils/constans.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/auth/presentation/cubits/forget_password_cubit/forget_password_state.dart';
import 'package:online_exam/features/auth/presentation/cubits/forget_password_cubit/forget_password_view_model.dart';
import 'package:online_exam/features/auth/presentation/views/sigin_up_view.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  ForgetPasswordViewModel forgetPasswordViewModel = getIt();
  TextEditingController emailController = TextEditingController();

  AutovalidateMode validateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => forgetPasswordViewModel,
      child:
          BlocListener<ForgetPasswordViewModel, ForgetPasswordViewModelState>(
        listener: (context, state) {
          if (state.forgetPasswordState is BaseErrorState) {
            String errorMessage =
                (state.forgetPasswordState as BaseErrorState).errorMessage;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state.forgetPasswordState is BaseSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SiginUpView(),
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
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'email',
                        hintText: 'Enter your email',
                      ),
                    ),
                  ),
                  BlocBuilder<ForgetPasswordViewModel,
                      ForgetPasswordViewModelState>(
                    builder: (context, state) {
                      if (state.forgetPasswordState is BaseLoadingState) {
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
                              forgetPasswordViewModel.forgetPassword(
                                  email: emailController.text);
                            } else {
                              setState(() {
                                validateMode = AutovalidateMode.always;
                              });
                            }
                          },
                          child: Text(
                            'Login',
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
