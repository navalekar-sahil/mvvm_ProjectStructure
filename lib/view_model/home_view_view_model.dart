import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/usersModel.dart';
import 'package:mvvm/reository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {

  final _myRepo = HomeRepository();

  ApiResponse<Users> usersData = ApiResponse.loading();

  void setUsersData(ApiResponse<Users> response) {
    usersData = response;
    notifyListeners();
    print('Printing response from API: ${response.data?.data.toString()}');
  }

  Future<void> getUserData() async {
    setUsersData(ApiResponse.loading());
    try {
      Users data = await _myRepo.getUserData();
      setUsersData(ApiResponse.completed(data));
    } catch (error) {
      setUsersData(ApiResponse.error(error.toString()));
    }
  }
}
