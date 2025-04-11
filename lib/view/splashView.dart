import 'package:flutter/material.dart';

import '../view_model/services/splash_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  SplashService splashService= SplashService();

  @override
  void initState() {
    splashService.checkAuthentication(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Splash Screen",style: TextStyle(fontSize: 30,color: Colors.deepPurple),),
      ),
    );
  }
}
