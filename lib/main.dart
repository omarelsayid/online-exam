import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/helper_function/on_generate_route.dart';
import 'package:online_exam/core/services/custom_bloc_observer.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/services/navigation_service.dart';
import 'package:online_exam/core/utils/theming.dart';
import 'package:online_exam/features/splash_screen/splash_screen.dart';
import 'features/exam/domain/repo/exam_result_repository.dart';
import 'features/exam/presentation/cubits/exam_result_cubit/exam_result_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = CustomBlocObserver();

  configureDependencies();

  runApp(MainApp());
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
          return BlocProvider(
            create: (context) =>
                ExamResultCubit(repository: getIt<ExamResultRepository>()),
            child: MaterialApp(
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              initialRoute: SplashScreen.routeName,
              onGenerateRoute: onGenerateRoute,
              // initialRoute: SiginView.routeName,
              // initialRoute:
              //     token != null ? MainView.routeName : SiginView.routeName,

              theme: themeData,
            ),
          );
        });
  }
}
