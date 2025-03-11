import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:online_exam/features/auth/presentation/views/sigin_view.dart';

import '../../core/services/secure_storage_service.dart';
import '../../core/utils/constans.dart';
import '../../main_view.dart';
class SplashScreen extends StatefulWidget {

  static const routeName= "splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    executeNavigation();
    super.initState();
  }

  void executeNavigation(){


    Future.delayed(Duration(seconds: 5),() async{
      String? token = await SecureStorageService.getValue(kUserTokenKey);
      if(token!= null)
        {
          Navigator.pushNamedAndRemoveUntil(context, MainView.routeName, (route) => false,);
        }

      else {
        Navigator.pushNamedAndRemoveUntil(context, SiginView.routeName, (route) => false,);

      }

    },);


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
         child: Lottie.asset(
             'assets/slpash/splash_animation.json',


         )
      ),
    );
  }
}
