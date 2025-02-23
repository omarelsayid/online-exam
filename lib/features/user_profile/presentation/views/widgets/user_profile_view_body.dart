import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/constans.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/user_profile/domain/entities/user_profile_entity.dart';
import 'package:online_exam/features/user_profile/presentation/views/chnage_password_view.dart';
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
      child: Column(
        children: [
          SizedBox(height: 24.h),
          ProfileImageWidget(),
          SizedBox(height: 24.h),
          TextFormField(
            controller: _usernameController, // ✅ Assigned controller
            decoration: InputDecoration(labelText: 'User Name'),
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                ),
              ),
              SizedBox(width: 17.w),
              Expanded(
                child: TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
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
                  Navigator.pushNamed(context, ChangePasswordView.routeName);
                },
                child: Text(
                  'change',
                  style: AppTextStyles.inter400_12.copyWith(color: primayColor),
                ),
              ),
              labelText: 'Password',
            ),
          ),
          SizedBox(height: 24.h),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: 'Phone Number'),
          ),
          SizedBox(height: 48.h),
          ElevatedButton(
              onPressed: () {},
              child: Text(
                'update',
                style: AppTextStyles.roboto500_16.copyWith(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
