import 'package:flutter/material.dart';
import 'package:online_exam/features/auth/presentation/views/forget_password_view.dart';
import 'package:online_exam/features/auth/presentation/views/sigin_up_view.dart';
import 'package:online_exam/features/auth/presentation/views/sigin_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SiginView.routeName:
      return MaterialPageRoute(builder: (_) => const SiginView());
    case SiginUpView.routeName:
      return MaterialPageRoute(builder: (_) => const SiginUpView());
    case ForgetPasswordView.routeName:
      return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
    default:
      return MaterialPageRoute(builder: (_) => Text('Route not found'));
  }
}
