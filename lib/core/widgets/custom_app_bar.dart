import 'package:flutter/material.dart';
import 'package:online_exam/core/utils/text_styles.dart';

AppBar buildCustomAppBar(
    {required String title,
    required bool isVisible,
    required BuildContext context}) {
  return AppBar(
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
