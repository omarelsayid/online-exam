import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/helper_function/show_error_snackbar.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/base_api_state.dart';
import 'package:online_exam/core/utils/constans.dart';
import 'package:online_exam/core/utils/extensions.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/auth/presentation/cubits/forget_password_cubit/forget_password_state.dart';
import 'package:online_exam/features/auth/presentation/cubits/forget_password_cubit/forget_password_view_model.dart';
import 'package:online_exam/features/auth/presentation/views/verify_reset_code_view.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  static const String routeName = 'forgetPasswordView';

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
          if (state is ForgetPasswordErrorState) {
            String errorMessage = (state).errorMessage;
            ShowErrorSnackbar(errorMessage, context);
          } else if (state is ForgetPasswordSuccessState) {
            Navigator.pushReplacementNamed(context, VerifyResetCodeView.routeName,
                arguments: emailController.text);
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
                return "emails can not be empty";
              }
              if (!value.isValidEmail) {
                return "Please enter a valid email";
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
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          BlocBuilder<ForgetPasswordViewModel, ForgetPasswordViewModelState>(
            builder: (context, state) {
              if (state is ForgetPasswordLoadingState) {
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
                        forgetPasswordViewModel.forgetPassword(
                          email: emailController.text,
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
            'Forget Password',
            maxLines: 1,
            style: AppTextStyles.inter500_18.copyWith(color: blackColor),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Please enter your email associated to your account',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: AppTextStyles.inter400_14.copyWith(color: greyColor),
          ),
        ],
      ),
    );
  }

// return BlocProvider(
// create: (context) => forgetPasswordViewModel,
// child:
// BlocListener<ForgetPasswordViewModel, ForgetPasswordViewModelState>(
// listener: (context, state) {
// if (state.forgetPasswordState is BaseErrorState) {
// String errorMessage =
// (state.forgetPasswordState as BaseErrorState).errorMessage;
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Text(errorMessage),
// backgroundColor: Colors.red,
// ),
// );
// } else if (state.forgetPasswordState is BaseSuccessState) {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => VerifyResetCodeView(
// // email: emailController.text,
// ),
// ),
// );
// }
// },
// child: Scaffold(
// appBar: AppBar(
// title: Text(
// 'Forget Password',
// style: AppTextStyles.roboto500_16,
// ),
// backgroundColor: primayColor,
// ),
// body: Padding(
// padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
// child: Form(
// key: formKey,
// child: Column(
// children: [
// Center(
// child: TextFormField(
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter your email';
// }
// return null;
// },
// controller: emailController,
// decoration: const InputDecoration(
// labelText: 'email',
// hintText: 'Enter your email',
// ),
// ),
// ),
// BlocBuilder<ForgetPasswordViewModel,
// ForgetPasswordViewModelState>(
// builder: (context, state) {
// if (state.forgetPasswordState is BaseLoadingState) {
// return Center(child: CircularProgressIndicator());
// } else {
// return ElevatedButton(
// style: ElevatedButton.styleFrom(
// backgroundColor:
// validateMode == AutovalidateMode.disabled
// ? primayColor
//     : secondaryColor,
// ),
// onPressed: () {
// if (formKey.currentState!.validate()) {
// setState(() {
// validateMode = AutovalidateMode.disabled;
// });
// forgetPasswordViewModel.forgetPassword(
// email: emailController.text);
// } else {
// setState(() {
// validateMode = AutovalidateMode.always;
// });
// }
// },
// child: Text(
// 'Login',
// style: AppTextStyles.roboto500_16
//     .copyWith(color: Colors.white),
// ),
// );
// }
// },
// ),
// ],
// ),
// ),
// ),
// ),
// ),
// );
//
}
