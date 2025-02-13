import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/base_api_state.dart';
import 'package:online_exam/core/utils/constans.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/auth/presentation/cubits/forget_password_cubit/forget_password_state.dart';
import 'package:online_exam/features/auth/presentation/cubits/forget_password_cubit/forget_password_view_model.dart';
import 'package:online_exam/features/auth/presentation/cubits/verify_code_cubit/verify_reset_code_state.dart';
import 'package:online_exam/features/auth/presentation/cubits/verify_code_cubit/verify_reset_code_view_model.dart';
import 'package:online_exam/features/auth/presentation/views/reset_password_view.dart';
import 'package:online_exam/features/auth/presentation/views/sigin_up_view.dart';

class VerifyResetCodeView extends StatefulWidget {
  const VerifyResetCodeView({super.key, required this.email});
  static const String routeName = 'verifyResetCodeView';

  final String email;

  @override
  State<VerifyResetCodeView> createState() => _VerifyResetCodeView();
}

class _VerifyResetCodeView extends State<VerifyResetCodeView> {
  VerifyResetCodeViewModel verifyRestCodeViewModel = getIt();
  TextEditingController emailController = TextEditingController();

  AutovalidateMode validateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => verifyRestCodeViewModel,
      child:
          BlocListener<VerifyResetCodeViewModel, VerifyResetCodeViewModelState>(
        listener: (context, state) {
          if (state.verifyCodeState is BaseErrorState) {
            String errorMessage =
                (state.verifyCodeState as BaseErrorState).errorMessage;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state.verifyCodeState is BaseSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResetPasswordView(email: widget.email),
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
                          return 'Please enter your code';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'code',
                        hintText: 'Enter your code',
                      ),
                    ),
                  ),
                  BlocBuilder<VerifyResetCodeViewModel,
                      VerifyResetCodeViewModelState>(
                    builder: (context, state) {
                      if (state.verifyCodeState is BaseLoadingState) {
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
                              verifyRestCodeViewModel.verifyResetCode(
                                  resetCode: emailController.text);
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
