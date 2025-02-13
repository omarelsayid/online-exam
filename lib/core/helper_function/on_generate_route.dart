import 'package:flutter/material.dart';
import 'package:online_exam/features/auth/presentation/views/forget_password_view.dart';
import 'package:online_exam/features/auth/presentation/views/reset_password_view.dart';
import 'package:online_exam/features/auth/presentation/views/sigin_view.dart';
import 'package:online_exam/features/auth/presentation/views/verify_reset_code_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SiginView.routeName:
      return MaterialPageRoute(builder: (_) => const SiginView());
    case ForgetPasswordView.routeName:
      return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
    case VerifyResetCodeView.routeName:
      return MaterialPageRoute(
          builder: (_) => const VerifyResetCodeView(), settings: settings);
    case ResetPasswordView.routeName:
      return MaterialPageRoute(
          builder: (_) => const ResetPasswordView(), settings: settings);
    default:
      return MaterialPageRoute(builder: (_) => Text('Route not found'));
  }
}
