import 'package:crypto_android_widget/app/app_module.dart';
import 'package:crypto_android_widget/app/app_widget.dart';
import 'package:crypto_android_widget/services/cryptos_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:home_widget/home_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HomeWidget.registerBackgroundCallback(backgroundCallback);

  return runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}

Future<void> backgroundCallback(dynamic uri) async {
  if (uri.host == 'updatecryptovalue') {
    final cryptoService = CryptosService();

    final cryptoSymbol =
        await HomeWidget.getWidgetData<String>('_cryptoSymbol');

    final cryptoFound = await cryptoService.fetchCryptoMetrics(cryptoSymbol);

    await HomeWidget.saveWidgetData<String>(
      '_cryptoValue',
      cryptoFound?['price'],
    );

    await HomeWidget.updateWidget(
      name: 'AppWidgetProvider',
      iOSName: 'AppWidgetProvider',
    );
  }
}
