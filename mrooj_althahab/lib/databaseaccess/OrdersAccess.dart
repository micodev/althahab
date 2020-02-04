import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:mrooj_althahab/models/Orders.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersAccess {
  String apitoken;
  static final url = "http://34.82.1.171/api/";
  //static final url = "http://192.168.0.100:8000/api/";
  OrdersAccess() {
    apitoken = "crazy";
  }

  Future<Orders> createOrder(Orders order) async {
    try {
      var body = json.encode(order.toDatabaseJson());
      String urll = url + "order?api_token=$apitoken";
      var str = await postClient(urll, body);
      var isMap = str is Map<String, dynamic>;
      if (!isMap) {
        var res = str.toString();
        return Orders(
            error: res
                .replaceAll("error", "")
                .replaceAll("201", "لا يمكن اضافه طلب راجع الشركة"));
      }

      var ret = Orders.fromDatabaseJson(str);
      return ret.customNumber == null
          ? Orders(error: "تحقق من صحة الحقول رجاءا")
          : ret;
    } catch (e) {
      return Orders(error: "خطأ غير معروف أعد المحاولة");
    }
  }

  Future<List<Orders>> getOrders(int condition) async {
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      apitoken = shared.getString("api_token");
      String urll = url + "order/$condition?api_token=$apitoken";
      List<dynamic> result = await getClient(urll);
      var vesult = result != null
          ? result.map((item) => Orders.fromDatabaseJson(item)).toList()
          : [];
      return vesult;
    } catch (e) {
      return [];
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
