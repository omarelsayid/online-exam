import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/utils/text_styles.dart';

AppBar buildCustomAppBar(
    {required String title,
    required bool isVisible,
    List<Widget>? actions,
    required BuildContext context}) {
  return AppBar(
    actions: actions,
    backgroundColor: Colors.white,
    elevation: 0,
    titleSpacing: 2.w,
    leading: Visibility(
      visible: isVisible,
      child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios)),
    ),
    title: Text(
      title,
      style: AppTextStyles.inter500_20,
    ),
  );
}
