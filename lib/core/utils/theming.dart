import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/text_styles.dart';

ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintStyle: AppTextStyles.roboto400_14.copyWith(
        color: Color(0xffA6A6A6),
      ),
      labelStyle: AppTextStyles.roboto400_12.copyWith(
        color: Color(0xff535353),
      ),
      contentPadding: EdgeInsets.fromLTRB(
        16.w,
        4.h,
        0.w,
        4.h,
      ),
      focusedBorder: textFiledInputBorder(),
      enabledBorder: textFiledInputBorder(),
      border: textFiledInputBorder(),
      filled: true,
      fillColor: Colors.transparent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primayColor,
        minimumSize: Size(343.w, 48.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
      ),
    ));

OutlineInputBorder textFiledInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(4.r),
      topRight: Radius.circular(4.r),
    ),
    borderSide: BorderSide(
      color: Colors.grey,
      width: 1.w,
    ),
  );
}
