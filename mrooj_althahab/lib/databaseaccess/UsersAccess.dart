import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:mrooj_althahab/models/ApiToken.dart';
import 'package:mrooj_althahab/models/Users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersAccess {
  static final url = "http://34.82.1.171/api/";
  //static final url = "http://192.168.0.100:8000/api/";

  Future<ApiToken> createUser(Users user) async {
    try {
      var body = json.encode(user.toDatabaseJson());
      String urll = url + "signup";
      var str = await postClient(urll, body);
      var isMap = str is Map<String, dynamic>;
      if (!isMap) {
        var res = str.toString();
        return ApiToken(
            error: res
                .replaceAll("error", "")
                .replaceAll("201", "يوجد حساب بهذا الرقم"));
      }

      var ret = ApiToken.fromDatabaseJson(str);
      return ret.apitoken == null
          ? ApiToken(error: "تحقق من الرقم رجاءا")
          : ret;
    } catch (e) {
      return ApiToken(error: "خطأ غير معروف أعد المحاولة");
    }
  }

  Future<Users> getBalance() async {
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      var apitoken = shared.getString("api_token");
      String urll = url + "getuser?api_token=$apitoken";
      var str = await getClient(urll);

      var isMap = str is Map<String, dynamic>;
      if (!isMap) {
        var res = str.toString();
        return Users(
            error: res
                .replaceAll("error", "")
                .replaceAll("201", "يوجد مشكلة باسترداد الرصيد"));
      }

      var ret = Users.fromDatabaseJson(str);
      return ret.apitoken == null
          ? Users(error: "تحقق من حسابك عند الشركة رجاءا")
          : ret;
    } catch (e) {
      return Users(error: "خطأ غير معروف أعد المحاولة");
    }
  }

  Future<Users> loginUser(String number, String password) async {
    var body = json.encode({"number": number, "password": password});
    String urll = url + "login?";
    try {
      var str = await postClient(urll, body);
      var isMap = str is Map<String, dynamic>;
      if (!isMap) {
        var res = str.toString();
        return Users(
            error: res
                .replaceAll("error", "")
                .replaceAll("201", "لا يوجد حساب بهذا رقم او رمز خاطئ"));
      }

      var ret = Users.fromDatabaseJson(str);
      return ret.apitoken == null
          ? Users(error: "لا يوجد حساب بهذا رقم او رمز خاطئ")
          : ret;
    } catch (e) {
      return Users(error: "خطأ غير معروف أعد المحاولة");
    }
  }

  Future<dynamic> postClient(url, body) async {
    try {
      var httpclient = new HttpClient();
      httpclient.connectionTimeout = const Duration(seconds: 5);
      HttpClientRequest request = await httpclient.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(body));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      if (response.statusCode != 200) {
        httpclient.close();
        return "201 error";
      }
      httpclient.close();
      return json.decode(reply);
    } on TimeoutException catch (_) {
      return "ضعف في النت يرجى المحاولة error";
    } on SocketException catch (_) {
      return "مشكلة بالسيرفر error";
    }
  }

  Future<dynamic> getClient(url) async {
    try {
      var httpclient = new HttpClient();
      httpclient.connectionTimeout = const Duration(seconds: 5);
      HttpClientRequest request = await httpclient.getUrl(Uri.parse(url));
      HttpClientResponse response = await request.close();
      if (response.statusCode != 200) {
        httpclient.close();
        return "201 error";
      }
      String reply = await response.transform(utf8.decoder).join();
      httpclient.close();
      return json.decode(reply);
    } on TimeoutException catch (_) {
      return "ضعف في النت يرجى المحاولة error";
    } on SocketException catch (_) {
      return "مشكلة بالسيرفر error";
    }
  }
}
