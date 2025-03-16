import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/utils/extensions.dart';
import 'package:online_exam/features/auth/presentation/cubits/signup_cubit/signup_states.dart';
import 'package:online_exam/main_view.dart';
import '../../../../../../core/helper_function/show_snackbar.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/constans.dart';
import '../../../../../../core/utils/text_styles.dart';
import '../../../cubits/signup_cubit/signup_cubit.dart';
import 'aleady_have_account_widget.dart';

class SignupBody extends StatefulWidget {
  const SignupBody({super.key});

  @override
  State<SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  AutovalidateMode validateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<SignupCubit>().signUpUser(
            username: _usernameController.text.trim(),
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            rePassword: _rePasswordController.text.trim(),
            phone: _phoneController.text.trim(),
          );
    } else {
      setState(() {
        validateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
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
                  return 'Please enter your user Name';
                }
                return null;
              },
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'user Name',
                hintText: 'Enter your user Name',
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: onChange,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first Name';
                      }
                      return null;
                    },
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'first name',
                      hintText: 'Enter your first name',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    onChanged: onChange,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'last name',
                      hintText: 'Enter your last name',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            TextFormField(
              onChanged: onChange,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Email';
                }
                if (!value.isValidEmail) {
                  return "invalid email format";
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
            Row(
              children: [
                Expanded(
                  child: TextFormField(
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
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    onChanged: onChange,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Confirm password';
                      } else if (value != _passwordController.text) {
                        return "passwords do not match";
                      }
                      return null;
                    },
                    controller: _rePasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm password',
                      hintText: 'Enter your Confirm password',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            TextFormField(
              onChanged: onChange,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone';
                }
                return null;
              },
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'phone',
                hintText: 'Enter your phone',
              ),
            ),
            SizedBox(height: 64.h),
            BlocConsumer<SignupCubit, SignupStates>(
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: validateMode == AutovalidateMode.disabled
                        ? primayColor
                        : secondaryColor,
                  ),
                  onPressed: () {
                    _submit();
                  },
                  child: state is SignupLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : Text(
                          'Sign up',
                          style: AppTextStyles.roboto500_16
                              .copyWith(color: Colors.white),
                        ),
                );
              },
              listener: (context, state) {
                if (state is SignupSuccess) {
                  ShowSnackbar("Register completed Successfully", context);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      MainView.routeName, (Route<dynamic> route) => false);
                } else if (state is SignupFailure) {
                  ShowErrorSnackbar(state.message, context);
                }
              },
            ),
            SizedBox(height: 16.h),
            AlreadyHaveAccountWidget(),
          ],
        ),
      ),
    ));
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
}
