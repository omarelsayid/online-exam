import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/services/di_service.dart';
import 'package:online_exam/core/theming.dart';

void main() {
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
            theme: themeData,
            home: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  ElevatedButton(onPressed: () {}, child: Text('')),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      labelText: 'Name',
                    ),
                  )
                ],
              )),
            ),
          );
        });
  }
}
