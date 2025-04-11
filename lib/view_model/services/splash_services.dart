import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/userSession.dart';

class SplashService{

  void checkAuthentication(BuildContext context) async{

    String? token= await UserSessionManager.getUserToken();

    print("token form storage :: $token");

    if(token==null || token.isEmpty){
     Timer(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, RoutesName.login,(route) => false,);
     });

    }else{
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(context, RoutesName.home,(route) => false,);
      });

    }
  }
}