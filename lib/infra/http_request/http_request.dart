import 'package:crypto_android_widget/constants/api_url.dart';
import 'package:dio/dio.dart';

class HttpRequest {
  Future<Response> httpGet(String urlPath) async {
    String url = "$API_URL$urlPath";

    return Dio().get(url);
  }
}
