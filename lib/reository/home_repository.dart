
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/usersModel.dart';
import '../res/app_urls.dart';

class HomeRepository{

  final BaseApiService _apiService = NetworkApiService();

  //get All user
  Future<Users> getUserData() async{
    try{
      dynamic response = await _apiService.getGetApiResponse(AppUrl.userData);
      return Users.fromJson(response); // parse to model
    }catch(e){
      throw e;
    }
  }


}