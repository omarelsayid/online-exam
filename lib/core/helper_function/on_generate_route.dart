import 'package:flutter/material.dart';
import 'package:online_exam/features/auth/presentation/views/forget_password_view.dart';
<<<<<<< HEAD
import 'package:online_exam/features/auth/presentation/views/reset_password_view.dart';
import 'package:online_exam/features/auth/presentation/views/sigin_view.dart';
import 'package:online_exam/features/auth/presentation/views/verify_reset_code_view.dart';
=======
import 'package:online_exam/features/auth/presentation/views/sigin_up_view.dart';
import 'package:online_exam/features/auth/presentation/views/sigin_view.dart';
>>>>>>> 6a61a8d (finish UI of login feature)

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SiginView.routeName:
      return MaterialPageRoute(builder: (_) => const SiginView());
<<<<<<< HEAD
    case ForgetPasswordView.routeName:
      return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
    case VerifyResetCodeView.routeName:
      return MaterialPageRoute(
          builder: (_) => const VerifyResetCodeView(), settings: settings);
    case ResetPasswordView.routeName:
      return MaterialPageRoute(
          builder: (_) => const ResetPasswordView(), settings: settings);
=======
    case SiginUpView.routeName:
      return MaterialPageRoute(builder: (_) => const SiginUpView());
    case ForgetPasswordView.routeName:
      return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
>>>>>>> 6a61a8d (finish UI of login feature)
    default:
      return MaterialPageRoute(builder: (_) => Text('Route not found'));
  }
}
