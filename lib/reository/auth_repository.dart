import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/res/app_urls.dart';

class AuthRepository{
  BaseApiService _apiServioce = NetworkApiService();

  //login api
  Future<dynamic> loginApi(dynamic data) async{
    try{
      dynamic response = await _apiServioce.getPostApiResponse(AppUrl.loginUrl, data);
      return response;
    }catch(e){
      throw e;
    }
  }



  //register api
  Future<dynamic> registerApi(dynamic data) async{
    try{
      dynamic response = await _apiServioce.getPostApiResponse(AppUrl.registerUrl, data);
      return response;
    }catch(e){
      throw e;
    }
  }

}