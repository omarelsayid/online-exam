import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ShowErrorSnackbar(String message, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: EdgeInsets.only(bottom: 5.h),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      elevation: 1,
      content: Text(message),
      backgroundColor: Colors.red,
    ),
  );
}

ShowSnackbar(String message, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
