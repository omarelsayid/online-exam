import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/helper_function/show_snackbar.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/constans.dart';
import 'package:online_exam/core/utils/extensions.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/user_profile/domain/entities/user_profile_entity.dart';
import 'package:online_exam/features/user_profile/presentation/cubits/update_profile_cubit/update_profile_cubit.dart';
import 'package:online_exam/features/user_profile/presentation/cubits/update_profile_cubit/update_profile_state.dart';
import 'package:online_exam/features/user_profile/presentation/views/change_password_view.dart';
import 'package:online_exam/features/user_profile/presentation/views/widgets/profile_image_widget.dart';

class UserProfileViewBody extends StatefulWidget {
  const UserProfileViewBody({super.key, required this.userProfileEntity});

  final UserProfileEntity userProfileEntity;

  @override
  State<UserProfileViewBody> createState() => _UserProfileViewBodyState();
}

class _UserProfileViewBodyState extends State<UserProfileViewBody> {
  late final TextEditingController _usernameController =
      TextEditingController(text: widget.userProfileEntity.username);
  late final TextEditingController _firstNameController =
      TextEditingController(text: widget.userProfileEntity.firstName);
  late final TextEditingController _lastNameController =
      TextEditingController(text: widget.userProfileEntity.lastName);
  late final TextEditingController _emailController =
      TextEditingController(text: widget.userProfileEntity.email);
  late final TextEditingController _phoneController =
      TextEditingController(text: widget.userProfileEntity.phone);
  final TextEditingController _passwordController =
      TextEditingController(text: '123456');
  UpdateProfileCubit updateProfileCubit = getIt();
  AutovalidateMode validateMode = AutovalidateMode.always;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding.w),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: validateMode,
          child: Column(
            children: [
              SizedBox(height: 24.h),
              ProfileImageWidget(),
              SizedBox(height: 24.h),
              TextFormField(
                autovalidateMode: validateMode,
                controller: _usernameController, 
                decoration: InputDecoration(labelText: 'User Name'),
                validator: (value) {
                  if (value == null || value.isEmpty == true) {
                    return "empty user name are not allowed";
                  }
                  return null;
                },
                onChanged: (value) {
                  checkValidateForTextField();
                },
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      autovalidateMode: validateMode,
                      controller: _firstNameController,
                      decoration: InputDecoration(labelText: 'First Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty == true) {
                          return "empty first name are not allowed";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        checkValidateForTextField();
                      },
                    ),
                  ),
                  SizedBox(width: 17.w),
                  Expanded(
                    child: TextFormField(
                      autovalidateMode: validateMode,
                      controller: _lastNameController,
                      decoration: InputDecoration(labelText: 'Last Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty == true) {
                          return "empty last name are not allowed";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        checkValidateForTextField();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              TextFormField(
                autovalidateMode: validateMode,
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
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
                  checkValidateForTextField();
                },
              ),
              SizedBox(height: 24.h),
              TextFormField(
                controller: _passwordController,
                obscuringCharacter: '★',
                readOnly: true,
                obscureText: true,
                decoration: InputDecoration(
                  suffixIcon: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ChangePasswordView.routeName);
                    },
                    child: Text(
                      'change',
                      style: AppTextStyles.inter400_12
                          .copyWith(color: primayColor),
                    ),
                  ),
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 24.h),
              TextFormField(
                autovalidateMode: validateMode,
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty == true) {
                    return "phone can not be empty";
                  }
                  if (value.length != 11) {
                    return "Phone number must be exactly 11 digits.";
                  }
                  if (!value.isValidPhone) {
                    return "Please enter a valid phone";
                  }
                  return null;
                },
                onChanged: (value) {
                  checkValidateForTextField();
                },
              ),
              SizedBox(height: 48.h),
              BlocProvider(
                create: (context) => updateProfileCubit,
                child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
                  listener: (context, state) {
                    if (state is UpdateProfileErrorState) {
                      String errorMessage = (state).errorMessage;
                      ShowErrorSnackbar(errorMessage, context);
                    } else if (state is UpdateProfileSuccessState) {
                      ShowSnackbar('Profile Updated Successfully', context);
                    }
                  },
                  child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                    builder: (context, state) {
                      if (state is UpdateProfileLoadingState) {
                        return Center(
                            child:
                                CircularProgressIndicator(color: primayColor));
                      } else {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  validateMode == AutovalidateMode.disabled
                                      ? primayColor
                                      : secondaryColor),
                          onPressed: () {
                            if (validateMode == AutovalidateMode.always) {
                              null;
                            } else {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  validateMode = AutovalidateMode.disabled;
                                });
                                updateProfileCubit.updateProfile(
                                  email: _emailController.text,
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  phone: _phoneController.text,
                                  username: _usernameController.text,
                                );
                                setState(() {
                                  validateMode = AutovalidateMode.always;
                                });
                              } else {
                                setState(() {
                                  validateMode = AutovalidateMode.always;
                                });
                              }
                            }
                          },
                          child: Text(
                            'update',
                            style: AppTextStyles.roboto500_16
                                .copyWith(color: Colors.white),
                          ),
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void checkValidateForTextField() {
    if (formKey.currentState!.validate()) {
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
