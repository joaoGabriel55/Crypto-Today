import 'package:crypto_android_widget/infra/http_request/http_request.dart';
import 'package:crypto_android_widget/services/cryptos_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockHttpRequest extends Mock implements HttpRequest {}

void main() {
  group('fetch', () {
    test('Should returns crypto options', () async {
      final service = CryptosService();
      final request = MockHttpRequest();

      var response = Response<dynamic>(
        data: {
          'BTC': {
            'symbol': 'BTC',
            'name': 'Bitcoin',
            'price': '\$6800.00',
            'percent_change_1h': '-0.01',
          }
        },
        requestOptions: RequestOptions(path: ''),
      );

      when(request.httpGet('/assets')).thenReturn(Future.value(response));

      var result = await service.fetch();

      expect(result.length, 20);
    });
  });
}
