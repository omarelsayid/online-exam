import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/helper_function/show_error_snackbar.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/constans.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/auth/presentation/cubits/sigin_cubit/sigin_cubit.dart';
import 'package:online_exam/features/auth/presentation/cubits/sigin_cubit/sigin_states.dart';
import 'package:online_exam/features/auth/presentation/views/forget_password_view.dart';
import 'package:online_exam/features/auth/presentation/views/sigin_up_view.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SiginCubit, SiginStates>(
      listener: (context, state) {
        if (state is SiginSuccess) {
          ShowErrorSnackbar('login successfully', context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SiginUpView(),
            ),
          );
        } else if (state is SiginFailure) {
          ShowErrorSnackbar(state.message, context);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Form(
            autovalidateMode: validateMode,
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'email',
                    hintText: 'Enter your email',
                  ),
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
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
                SizedBox(height: 10.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: validateMode == AutovalidateMode.disabled
                        ? primayColor
                        : secondaryColor,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        validateMode = AutovalidateMode.disabled;
                      });
                      context.read<SiginCubit>().signInUser(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                    } else {
                      setState(() {
                        validateMode = AutovalidateMode.always;
                      });
                    }
                  },
                  child: state is SiginLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Login',
                          style: AppTextStyles.roboto500_16
                              .copyWith(color: Colors.white),
                        ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgetPasswordView(),
                      ),
                    );
                  },
                  child: Text(
                    'Forget Password',
                    style: AppTextStyles.roboto500_16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
