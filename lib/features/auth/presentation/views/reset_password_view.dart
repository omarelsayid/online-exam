import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/constans.dart';
import 'package:online_exam/core/utils/extensions.dart';
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
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late String email;
  AutovalidateMode validateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)!.settings.arguments as String;

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
            Navigator.pushReplacementNamed(
              context,
              SiginView.routeName,
            );
          }
        },
        child: Scaffold(
          appBar: buildAppBar(),
          body: Form(
            key: formKey,
            autovalidateMode: validateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildColumnTextBody(),
                buildColumnTextFieldAndButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        'Password',
        style: AppTextStyles.inter500_20.copyWith(color: blackColor),
      ),
    );
  }

  Padding buildColumnTextFieldAndButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: validateMode,
            validator: (value) {
              if (value == null || value.isEmpty == true) {
                return "empty passwords are not allowed";
              }
              if (value.length < 8) {
                return "passwords can not be less than 8 characters";
              }
              if (!value.isValidPassword) {
                return "password must contain at least one upper case letter and one number";
              }
              return null;
            },
            onChanged: (value) {
              if (formKey.currentState!.validate()) {
                setState(() {
                  validateMode = AutovalidateMode.disabled;
                });
              } else {
                setState(() {
                  validateMode = AutovalidateMode.always;
                });
              }
            },
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'New Password',
              hintText: 'Enter your Password',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            autovalidateMode: validateMode,
            validator: (value) {
              if (value! != passwordController.text) {
                return 'passwords do not match';
              }
              return null;
            },
            onChanged: (value) {
              if (formKey.currentState!.validate()) {
                setState(() {
                  validateMode = AutovalidateMode.disabled;
                });
              } else {
                setState(() {
                  validateMode = AutovalidateMode.always;
                });
              }
            },
            controller: confirmPasswordController,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
              hintText: 'Confirm Password',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          BlocBuilder<ResetPasswordViewModel, ResetPasswordViewModelState>(
            builder: (context, state) {
              if (state is ResetPasswordLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: validateMode == AutovalidateMode.disabled
                        ? primayColor
                        : secondaryColor,
                  ),
                  onPressed: () {
                    if (validateMode == AutovalidateMode.always) {
                      null;
                    } else {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          validateMode = AutovalidateMode.disabled;
                        });
                        //view model fun
                        resetPasswordViewModel.resetPassword(
                          email: email,
                          newPassword: confirmPasswordController.text,
                        );
                      } else {
                        setState(() {
                          validateMode = AutovalidateMode.always;
                        });
                      }
                    }
                  },
                  child: Text(
                    'Continue',
                    style: AppTextStyles.roboto500_16
                        .copyWith(color: Colors.white),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Padding buildColumnTextBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Reset password',
            maxLines: 1,
            style: AppTextStyles.inter500_18.copyWith(color: blackColor),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Password must not be empty and must contain 6 characters with upper case letter and one number at least ',
            maxLines: 3,
            textAlign: TextAlign.center,
            style: AppTextStyles.inter400_14.copyWith(color: greyColor),
          ),
        ],
      ),
    );
  }

  // return BlocProvider(
  //   create: (context) => resetPasswordViewModel,
  //   child: BlocListener<ResetPasswordViewModel, ResetPasswordViewModelState>(
  //     listener: (context, state) {
  //       if (state is ResetPasswordErrorState) {
  //         String errorMessage = (state).errorMessage;
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(errorMessage),
  //             backgroundColor: Colors.red,
  //           ),
  //         );
  //       } else if (state is ResetPasswordSuccessState) {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const SiginView(),
  //           ),
  //         );
  //       }
  //     },
  //     child: Scaffold(
  //       appBar: AppBar(
  //         title: Text(
  //           'Forget Password',
  //           style: AppTextStyles.roboto500_16,
  //         ),
  //         backgroundColor: primayColor,
  //       ),
  //       body: Padding(
  //         padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
  //         child: Form(
  //           key: formKey,
  //           child: Column(
  //             children: [
  //               Center(
  //                 child: TextFormField(
  //                   validator: (value) {
  //                     if (value == null || value.isEmpty) {
  //                       return 'Please enter your password';
  //                     }
  //                     return null;
  //                   },
  //                   controller: emailController,
  //                   decoration: const InputDecoration(
  //                     labelText: 'password',
  //                     hintText: 'Enter your password',
  //                   ),
  //                 ),
  //               ),
  //               BlocBuilder<ResetPasswordViewModel,
  //                   ResetPasswordViewModelState>(
  //                 builder: (context, state) {
  //                   if (state is ResetPasswordLoadingState) {
  //                     return Center(child: CircularProgressIndicator());
  //                   } else {
  //                     return ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                         backgroundColor:
  //                             validateMode == AutovalidateMode.disabled
  //                                 ? primayColor
  //                                 : secondaryColor,
  //                       ),
  //                       onPressed: () {
  //                         if (formKey.currentState!.validate()) {
  //                           setState(() {
  //                             validateMode = AutovalidateMode.disabled;
  //                           });
  //                           resetPasswordViewModel.resetPassword(
  //                               email: emailController.text,
  //                               newPassword: emailController.text);
  //                         } else {
  //                           setState(() {
  //                             validateMode = AutovalidateMode.always;
  //                           });
  //                         }
  //                       },
  //                       child: Text(
  //                         'Verify',
  //                         style: AppTextStyles.roboto500_16
  //                             .copyWith(color: Colors.white),
  //                       ),
  //                     );
  //                   }
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   ),
  // );
  // }
}
