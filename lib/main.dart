import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/helper_function/on_generate_route.dart';
import 'package:online_exam/core/services/custom_bloc_observer.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/services/shared_preference_service.dart';
import 'package:online_exam/core/utils/theming.dart';
import 'package:online_exam/features/auth/presentation/views/sigin_view.dart';

void main() {
  SharedPreferenceService.init();
  Bloc.observer = CustomBlocObserver();
  configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: onGenerateRoute,
            initialRoute: SiginView.routeName,
            theme: themeData,
          );
        });
  }
}
