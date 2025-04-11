
import 'package:flutter/cupertino.dart';
import 'package:mvvm/reository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';

import '../model/tokenModel.dart';
import '../utils/userSession.dart';

class AuthViewModel with ChangeNotifier{

  final _myRepo= AuthRepository();

  bool _isLoading=false;
  bool _signUpLoading=false;

  bool get isLoading =>_isLoading;
  bool get isSignUpLoading => _signUpLoading;

  setLoading(bool value){
    _isLoading=value;
    notifyListeners();
  }

  setSignUpLoading(bool value){
    _signUpLoading=value;
    notifyListeners();
  }

  //login api
  Future<void> loginApi({required dynamic data, required BuildContext context}) async{
    setLoading(true);

    _myRepo.loginApi(data).then((value){
      setLoading(false);
      Util.snackBar(message: "Login Successfully", context: context);

      //convert user login data to TokenResponse model
      TokenResponse tokenResponse = TokenResponse.fromJson(value);

      //save use token
      UserSessionManager.saveUserToken(tokenResponse);

      Navigator.pushNamedAndRemoveUntil(context, RoutesName.home,(route) => false,);
      return;
    }).onError((error, stackTrace){
      setLoading(false);
      Util.flushBarErrorMessages(message: error.toString(), context: context);
    });
  }


  //sign up api
  Future<void> register({required dynamic data, required BuildContext context}) async{
    setSignUpLoading(true);

    _myRepo.registerApi(data).then((value){
      setSignUpLoading(false);
      Util.snackBar(message: "Register Successfully", context: context);
      Navigator.pop(context);
      return;

    }).onError((error, stackTrace){
      setSignUpLoading(false);
      Util.flushBarErrorMessages(message: error.toString(), context: context);
    });
  }
}