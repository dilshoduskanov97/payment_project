import 'dart:convert';
import 'package:http/http.dart';

import '../models/model.dart';
import 'log_service.dart';

class Network {
  /// Set isTester ///
  static bool isTester = false;

  /// Servers Types ///
  static String SERVER_DEVELOPMENT = "622b02c514ccb950d22c0a02.mockapi.io";
  static String SERVER_PRODUCTION = "622b02c514ccb950d22c0a02.mockapi.io";

  /// * Http Apis *///
  static String API_LIST = "/card_model";
  static String API_CREATE = "/card_model";
  static String API_DELETE = "/card_model"; //{id}

  /// Getting Header ///
  static Map<String, String> getHeaders() {
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    return header;
  }

  /// Selecting Test Server or Production Server  ///

  static String getServer() {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  ///* Http Requests *///

  /// GET method///
  static Future<String?> GET(String api, Map<String, String> params) async {
    Uri uri = Uri.https(getServer(), api, params);
    Response response = await get(uri);
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;
    return null;
  }

  /// POST method///
  static Future<String?> POST(String api, Map<String, dynamic> params) async {
    Uri uri = Uri.https(getServer(), api, params);
    Response response = await post(uri, body: jsonEncode(params),headers: getHeaders());
    Log.d(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  /// DELETE ///
  static Future<String?> DEL(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api, params); // http or https
    var response = await delete(uri);
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;
    return null;
  }

  /// * Http Params * ///
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  /// Create Post ///
  static Map<String, String> paramsCreate(CardModel card) {
    Map<String, String> params = {};
    params.addAll({
      'name': card.name ?? "name",
      'cardNumber': card.cardNumber!,
      'data': card.data!,
      'cvv': card.cvv!
    });
    return params;
  }
}