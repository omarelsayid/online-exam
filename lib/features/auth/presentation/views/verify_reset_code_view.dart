import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/auth/presentation/cubits/forget_password_cubit/forget_password_view_model.dart';
import 'package:online_exam/features/auth/presentation/cubits/verify_code_cubit/verify_reset_code_state.dart';
import 'package:online_exam/features/auth/presentation/cubits/verify_code_cubit/verify_reset_code_view_model.dart';
import 'package:online_exam/features/auth/presentation/views/reset_password_view.dart';

class VerifyResetCodeView extends StatefulWidget {
  const VerifyResetCodeView({super.key});

  static const String routeName = 'verifyResetCodeView';

  @override
  State<VerifyResetCodeView> createState() => _VerifyResetCodeView();
}

class _VerifyResetCodeView extends State<VerifyResetCodeView> {
  VerifyResetCodeViewModel verifyRestCodeViewModel = getIt();
  ForgetPasswordViewModel forgetPasswordViewModel = getIt();
  late String email;
  AutovalidateMode validateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)!.settings.arguments as String;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => verifyRestCodeViewModel),
        BlocProvider(create: (_) => forgetPasswordViewModel),
      ],
      child:
          BlocListener<VerifyResetCodeViewModel, VerifyResetCodeViewModelState>(
        listener: (context, state) {
          if (state is VerifyResetCodeErrorState) {
            String errorMessage = (state).errorMessage;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is VerifyResetCodeSuccessState) {
            Navigator.pushReplacementNamed(context, ResetPasswordView.routeName,
                arguments: email);
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
                buildOtpFields(),
                buildLoadingOnBuilder(),
                buildResendCode(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildLoadingOnBuilder() {
    return BlocBuilder<VerifyResetCodeViewModel, VerifyResetCodeViewModelState>(
      builder: (context, state) {
        if (state is VerifyResetCodeLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        return Container();
      },
    );
  }

  Padding buildOtpFields() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          6,
          (index) {
            return buildOtpField(index);
          },
        ),
      ),
    );
  }

  String joinListToText() {
    List<String> stringList =
        _controllers.map((controller) => controller.text).toList();
    return stringList.join();
  }

  Row buildResendCode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't receive code?",
          style: AppTextStyles.inter400_16.copyWith(
            color: blackColor,
          ),
        ),
        TextButton(
          onPressed: () {
            _controllers.forEach((controller) => controller.clear());
            forgetPasswordViewModel.forgetPassword(email: email);
          },
          child: Text(
            "Resend",
            style: AppTextStyles.inter400_16.copyWith(
              color: primayColor,
              decoration: TextDecoration.underline,
              decorationColor: primayColor,
            ),
          ),
        ),
      ],
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

  Widget buildOtpField(int index) {
    return SizedBox(
      width: 50,
      height: 80,
      child: TextFormField(
        autovalidateMode: validateMode,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
          bool allFilled =
              _controllers.every((controller) => controller.text.isNotEmpty);

          if (allFilled && formKey.currentState!.validate()) {
            setState(() {
              validateMode = AutovalidateMode.disabled;
            });
            verifyRestCodeViewModel.verifyResetCode(
                resetCode: joinListToText());
          } else {
            setState(() {
              validateMode = AutovalidateMode.always;
            });
          }
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: pinColor, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: pinColor, width: 1)),
          filled: true,
          fillColor: pinColor,
          counterText: '',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: pinColor, width: 1)),
        ),
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
            'Email verification',
            maxLines: 1,
            style: AppTextStyles.inter500_18.copyWith(color: blackColor),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Please enter your code that send to your email address ',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: AppTextStyles.inter400_14.copyWith(color: greyColor),
          ),
        ],
      ),
    );
  }

// return BlocProvider(
//   create: (context) => verifyRestCodeViewModel,
//   child:
//       BlocListener<VerifyResetCodeViewModel, VerifyResetCodeViewModelState>(
//     listener: (context, state) {
//       if (state.verifyCodeState is BaseErrorState) {
//         String errorMessage =
//             (state.verifyCodeState as BaseErrorState).errorMessage;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(errorMessage),
//             backgroundColor: Colors.red,
//           ),
//         );
//       } else if (state.verifyCodeState is BaseSuccessState) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ResetPasswordView(),
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
//                       return 'Please enter your code';
//                     }
//                     return null;
//                   },
//                   controller: emailController,
//                   decoration: const InputDecoration(
//                     labelText: 'code',
//                     hintText: 'Enter your code',
//                   ),
//                 ),
//               ),
//               BlocBuilder<VerifyResetCodeViewModel,
//                   VerifyResetCodeViewModelState>(
//                 builder: (context, state) {
//                   if (state.verifyCodeState is BaseLoadingState) {
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
//                           verifyRestCodeViewModel.verifyResetCode(
//                               resetCode: emailController.text);
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
