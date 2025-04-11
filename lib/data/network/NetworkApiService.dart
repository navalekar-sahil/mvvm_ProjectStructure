import 'dart:convert';
import 'dart:io';
import 'package:mvvm/data/app_exceptions.dart';
import 'BaseApiServices.dart';
import 'package:http/http.dart' as http;


class NetworkApiService extends BaseApiService{

  @override
  Future getGetApiResponse(String url) async{

    dynamic responseJson;

    try{

      final response =await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson=returnResponse(response);

    }on SocketException{
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;

  }

  @override
  Future getPostApiResponse(String url,dynamic data) async {
    dynamic responseJson;

    try{
      final response =await http.post(
          Uri.parse(url),
          body: data
      ).timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);

    }on SocketException{
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }


  dynamic returnResponse(http.Response response){
    print("status code :: ${response.statusCode}");
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        print(responseJson);
        return responseJson;

      case 400:
        String error= jsonDecode(response.body)['error'];
        throw BadRequestException(error);

      case 500:
      case 404:
        throw BadRequestException(response.body.toString());

      default:
        throw FetchDataException("Error occurred while communicating with server with status code ${response.statusCode}");
    }
  }


}