import 'package:crypto_android_widget/infra/http_request/http_request.dart';
import 'package:dio/dio.dart';

class CryptosService {
  final request = HttpRequest();

  Future<List> fetch() async {
    try {
      Response response = await request.httpGet('/v2/assets');

      return response.data['data'].map((e) {
        final priceFormatted =
            e['metrics']['market_data']['price_usd'].toStringAsFixed(2);

        return {
          'name': e['name'],
          'symbol': e['symbol'],
          'price': priceFormatted,
          'selected': false,
        };
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Future fetchCryptoMetrics(cryptoSymbol) async {
    try {
      final url = "/v1/assets/$cryptoSymbol/metrics";
      Response response = await request.httpGet(url);

      final crypto = response.data['data'];

      final priceFormatted =
          crypto['market_data']['price_usd'].toStringAsFixed(2);

      return {
        'name': crypto['name'],
        'symbol': crypto['symbol'],
        'price': priceFormatted,
        'selected': false,
      };
    } catch (e) {
      return null;
    }
  }
}
