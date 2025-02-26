import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/features/user_profile/presentation/cubits/change_password_cubit/change_password_cubit.dart';

import '../../../../../../core/helper_function/show_error_snackbar.dart';
import '../../../../../../core/services/secure_storage_service.dart';
import '../../../../../../core/utils/constans.dart';
import '../../../../../../core/utils/text_styles.dart';
import '../../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../auth/presentation/views/sigin_view.dart';

class ChangePasswordBody extends StatefulWidget {
  ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  final TextEditingController _oldPassword = TextEditingController();

  final TextEditingController _newPassword = TextEditingController();

  final TextEditingController _reNewPassword = TextEditingController();


  @override
  void dispose() {

    _oldPassword.clear();
    _newPassword.clear();
    _reNewPassword.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
          title: 'Change Password', isVisible: true, context: context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding.w),
        child: Column(
          children: [
            SizedBox(height: 24.h),
            TextFormField(
              controller: _oldPassword,
              decoration: InputDecoration(
                  hintText: "Current password",
                  labelText: 'Current password'),
            ),
            SizedBox(height: 24.h),
            TextFormField(
              controller: _newPassword,
              decoration: InputDecoration(
                  hintText: "New password",
                  labelText: 'new password'),
            ),
            SizedBox(height: 24.h),
            TextFormField(
              controller: _reNewPassword,
              decoration: InputDecoration(
                  hintText: "Confirm password",
                  labelText: 'Confirm password'),
            ),
            SizedBox(height: 48.h),


            BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
              listener: (context, state) {
                if (state is ChangePasswordError) {
                  ShowErrorSnackbar(state.errorMessage, context);
                }
                else if(state is ChangePasswordSuccess)
                  {
                    ShowSnackbar("The Password changed successfully", context);
                    context.read<ChangePasswordCubit>().logout();
                    Navigator.pushReplacementNamed(context, SiginView.routeName);
                  }
              },
              builder: (context, state) {

                return ElevatedButton(
                  onPressed: () async {
                    context.read<ChangePasswordCubit>().changePassword(
                      oldPassword: _oldPassword.text.trim(),
                      newPassword: _newPassword.text.trim(),
                      reNewPassword: _reNewPassword.text.trim()
                    );
                  },
                  child: state is ChangePasswordLoading ?const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ):Text(
                    'update',
                    style: AppTextStyles.roboto500_16
                        .copyWith(color: Colors.white),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
