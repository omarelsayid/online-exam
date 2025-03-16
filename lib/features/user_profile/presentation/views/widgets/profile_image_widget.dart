import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_exam/core/utils/app_images.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 45.r,
          backgroundColor: Color(0xffc9cdd6),
          child:
              Icon(Icons.person_outline_sharp, size: 60.r, color: Colors.black),
        ),
        SvgPicture.asset(
          Assets.imagesCamera,
        )
      ],
    );
  }
}
