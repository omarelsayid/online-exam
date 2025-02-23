import 'package:flutter/material.dart';
import 'package:online_exam/features/auth/presentation/views/forget_password_view.dart';
import 'package:online_exam/features/auth/presentation/views/sigin_up_view.dart';
import 'package:online_exam/features/auth/presentation/views/sigin_view.dart';
import 'package:online_exam/features/user_profile/presentation/views/chnage_password_view.dart';
import 'package:online_exam/main_view.dart';

import '../../features/auth/presentation/views/reset_password_view.dart';
import '../../features/auth/presentation/views/verify_reset_code_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SiginView.routeName:
      return MaterialPageRoute(builder: (_) => const SiginView());
    case MainView.routeName:
      return MaterialPageRoute(builder: (_) => const MainView());
    case SiginUpView.routeName:
      return MaterialPageRoute(builder: (_) => const SiginUpView());
    case ForgetPasswordView.routeName:
      return MaterialPageRoute(builder: (_) => const ForgetPasswordView());

    case ChangePasswordView.routeName:
      return MaterialPageRoute(builder: (_) => const ChangePasswordView());
    case VerifyResetCodeView.routeName:
      return MaterialPageRoute(
          builder: (_) => const VerifyResetCodeView(), settings: settings);
    case ResetPasswordView.routeName:
      return MaterialPageRoute(
          builder: (_) => const ResetPasswordView(), settings: settings);
    default:
      return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text('Route not found'))));
  }
}
