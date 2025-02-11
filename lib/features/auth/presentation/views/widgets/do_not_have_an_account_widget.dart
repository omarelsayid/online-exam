import 'package:flutter/material.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/features/auth/presentation/views/sigin_up_view.dart';

class DoNotHaveAnAccountWidget extends StatelessWidget {
  const DoNotHaveAnAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account?',
          style: AppTextStyles.inter400_16,
        ),
        TextButton(
          style: ButtonStyle(
            padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                EdgeInsets.zero),
          ),
          onPressed: () {
            Navigator.pushNamed(context, SiginUpView.routeName);
          },
          child: Text(
            'Sign up',
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
