import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/tokenModel.dart';

class UserSessionManager{

  static const String _token = 'token';

  static Future<void> saveUserToken(TokenResponse token) async {
    print("user token :: ${token.token}");
    const storage = FlutterSecureStorage();
    await storage.write(key: _token, value: token.token);
  }


  static Future<String?> getUserToken() {
    const storage = FlutterSecureStorage();
    return storage.read(key: _token);
  }

  static Future<void> clearToken() async{
    const storage =FlutterSecureStorage();
    await storage.deleteAll();
  }

}