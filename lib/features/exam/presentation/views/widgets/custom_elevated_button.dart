import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/utils/text_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.backgroundColor,
      required this.textColor,
      required this.borderColor});
  final String text;
  final void Function() onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 163.w,
      height: 48.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(10.r),
            )),
        onPressed: onPressed,
        child: Text(
          text,
          style: AppTextStyles.roboto500_16.copyWith(color: textColor),
        ),
      ),
    );
  }
}
