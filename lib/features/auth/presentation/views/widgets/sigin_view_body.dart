import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/helper_function/show_error_snackbar.dart';
import 'package:online_exam/core/services/secure_storage_service.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/constans.dart';
import 'package:online_exam/core/utils/extensions.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/auth/presentation/cubits/sigin_cubit/sigin_cubit.dart';
import 'package:online_exam/features/auth/presentation/cubits/sigin_cubit/sigin_states.dart';
import 'package:online_exam/features/auth/presentation/views/forget_password_view.dart';
import 'package:online_exam/features/auth/presentation/views/widgets/do_not_have_an_account_widget.dart';
import 'package:online_exam/features/auth/presentation/views/widgets/remember_me_checkout_widget.dart';
import 'package:online_exam/main_view.dart';

class SiginViewBody extends StatefulWidget {
  const SiginViewBody({super.key});

  @override
  State<SiginViewBody> createState() => _SiginViewBodyState();
}

class _SiginViewBodyState extends State<SiginViewBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode validateMode = AutovalidateMode.disabled;
  bool rememberMe = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Form(
        autovalidateMode: validateMode,
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 24.h),
            TextFormField(
              onChanged: onChange,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }

                if (!value.isValidEmail) {
                  return 'invalid email format';
                }

                return null;
              },
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'email',
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(height: 24.h),
            TextFormField(
              onChanged: onChange,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }

                if (!value.isValidPassword) {
                  return "invalid password format";
                }

                return null;
              },
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'password',
                hintText: 'Enter your password',
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RememberMeCheckbox(
                  value: rememberMe,
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value!;
                    });
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ForgetPasswordView.routeName);
                  },
                  child: Text(
                    'Forget password?',
                    style: AppTextStyles.inter400_12.copyWith(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 64.h),
            ElevatedButtonBlocConsumer(),
            SizedBox(height: 16.h),
            DoNotHaveAnAccountWidget(),
          ],
        ),
      ),
    );
  }

  BlocConsumer<SiginCubit, SiginStates> ElevatedButtonBlocConsumer() {
    return BlocConsumer<SiginCubit, SiginStates>(
      listener: (context, state) async {
        if (state is SiginSuccess) {
          ShowSnackbar('login successfully', context);
          await _saveUserToken(state);

          Navigator.pushNamedAndRemoveUntil(
            context,
            MainView.routeName,
            (route) => false,
          );
        } else if (state is SiginFailure) {
          ShowErrorSnackbar(state.message, context);
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: validateMode == AutovalidateMode.disabled
                ? primayColor
                : secondaryColor,
          ),
          onPressed: () {
            sigin(context, state);
          },
          child: state is SiginLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : Text(
                  'Login',
                  style:
                      AppTextStyles.roboto500_16.copyWith(color: Colors.white),
                ),
        );
      },
    );
  }

  void onChange(String value) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        validateMode = AutovalidateMode.disabled;
      });
    } else {
      setState(() {
        validateMode = AutovalidateMode.always;
      });
    }
  }

  void sigin(BuildContext context, SiginStates state) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        validateMode = AutovalidateMode.disabled;
      });
      await context
          .read<SiginCubit>()
          .signInUser(
            email: _emailController.text,
            password: _passwordController.text,
          )
          .then((value) async {
        _resetForm();
      });
    } else {
      setState(() {
        validateMode = AutovalidateMode.always;
      });
    }
  }

  Future<void> _saveUserToken(SiginSuccess state) async {
    if (rememberMe) {
      await SecureStorageService.setValue(
          kUserTokenKey, state.userEntity.token!);
      await SecureStorageService.getValue(kUserTokenKey);
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _emailController.clear();
    _passwordController.clear();
  }
}
