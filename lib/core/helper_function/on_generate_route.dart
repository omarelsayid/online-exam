import 'package:flutter/material.dart';
import 'package:online_exam/features/auth/presentation/views/forget_password_view.dart';
import 'package:online_exam/features/auth/presentation/views/sigin_up_view.dart';
import 'package:online_exam/features/auth/presentation/views/sigin_view.dart';
import 'package:online_exam/features/exam/presentation/views/exam_details_view.dart';
import 'package:online_exam/features/exam/presentation/views/exam_qustions_view.dart';
import 'package:online_exam/features/exam/presentation/views/exam_score_view.dart';
import 'package:online_exam/features/exam/presentation/views/exams_on_subjects_view.dart';
import 'package:online_exam/features/splash_screen/splash_screen.dart';
import 'package:online_exam/features/user_profile/presentation/views/change_password_view.dart';
import 'package:online_exam/main_view.dart';

import '../../features/auth/presentation/views/reset_password_view.dart';
import '../../features/auth/presentation/views/verify_reset_code_view.dart';
import '../../features/exam/presentation/views/exam_result/exam_result_details.dart';

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

    case ExamQustionsView.routeName:
      return MaterialPageRoute(
          builder: (_) => const ExamQustionsView(), settings: settings);

    case ChangePasswordView.routeName:
      return MaterialPageRoute(builder: (_) => const ChangePasswordView());

    case VerifyResetCodeView.routeName:
      return MaterialPageRoute(
          builder: (_) => const VerifyResetCodeView(), settings: settings);

    case ResetPasswordView.routeName:
      return MaterialPageRoute(
          builder: (_) => const ResetPasswordView(), settings: settings);

    case ExamsOnSubjectsView.routeName:
      return MaterialPageRoute(
          builder: (_) => const ExamsOnSubjectsView(), settings: settings);

    case ExamDetailsView.routeName:
      return MaterialPageRoute(
          builder: (_) => const ExamDetailsView(), settings: settings);

    case ExamScoreView.routeName:
      return MaterialPageRoute(
          builder: (_) => const ExamScoreView(), settings: settings);


    case ExamResultDetails.routeName:
      final examMap = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(builder: (_)=>ExamResultDetails(examResult: examMap),settings: settings);

    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_)=>SplashScreen());
    default:
      return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text('Route not found'))));
  }
}
