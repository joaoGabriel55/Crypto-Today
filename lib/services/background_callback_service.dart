import 'dart:async';

import 'package:crypto_android_widget/services/cryptos_service.dart';
import 'package:home_widget/home_widget.dart';

const timerInterval = 30;

class BackgroundCallbackService {
  static void call(uri) async {
    Timer? timer;

    if (timer != null) timer.cancel();

    final cryptoService = CryptosService();

    timer = Timer.periodic(const Duration(seconds: timerInterval), (_) async {
      final cryptoSymbol = await HomeWidget.getWidgetData<String>(
        '_cryptoSymbol',
      );

      final cryptoFound = await cryptoService.fetchCryptoMetrics(cryptoSymbol);

      await HomeWidget.saveWidgetData<String>(
        '_cryptoValue',
        cryptoFound?['price'],
      );

      await HomeWidget.updateWidget(
        name: 'AppWidgetProvider',
        iOSName: 'AppWidgetProvider',
      );
    });
  }
}
