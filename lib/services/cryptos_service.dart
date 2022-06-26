import 'package:crypto_android_widget/infra/http_request/http_request.dart';
import 'package:dio/dio.dart';

class CryptosService {
  final request = HttpRequest();

  Future<List> fetch() async {
    try {
      Response response = await request.httpGet('/assets');

      return response.data['data']
          .map(
            (e) => {
              'name': e['name'],
              'symbol': e['symbol'],
              'selected': false,
            },
          )
          .toList();
    } catch (e) {
      return [];
    }
  }
}
