import 'package:flutter/material.dart';
import 'package:online_exam/core/utils/text_styles.dart';

import '../../sigin_view.dart';

class AlreadyHaveAccountWidget extends StatelessWidget {
  const AlreadyHaveAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: AppTextStyles.inter400_16,
        ),
        TextButton(
          style: ButtonStyle(
            padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                EdgeInsets.zero),
          ),
          onPressed: () {
            Navigator.pushNamed(context, SiginView.routeName);
          },
          child: Text(
            'Log in',
            style: AppTextStyles.inter500_16.copyWith(
              color: Color(0xff02369C),
              decoration: TextDecoration.underline,
              decorationColor: Color(0xff02369C),
              decorationThickness: 1.5,
            ),
          ),
        )
      ],
    );
  }
}
