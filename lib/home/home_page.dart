import 'package:crypto_android_widget/home/components/cryptos_list.dart';
import 'package:crypto_android_widget/home/home_controller.dart';
import 'package:crypto_android_widget/shared/template.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> updateAppWidget(cryptoSymbolSelected, cryptoValue) async {
    await HomeWidget.saveWidgetData<String>(
      '_cryptoSymbol',
      cryptoSymbolSelected,
    );
    await HomeWidget.saveWidgetData<String>('_cryptoValue', cryptoValue);
    await HomeWidget.updateWidget(
      name: 'AppWidgetProvider',
      iOSName: 'AppWidgetProvider',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Template(
      body: ValueListenableBuilder<List<dynamic>>(
        valueListenable: controller.cryptos,
        builder: (_, cryptos, __) {
          return CryptosList(
            cryptos: cryptos,
            hasData: cryptos.isNotEmpty,
            hasError: false,
            onSelected: (cryptoSymbol, cryptoPrice) {
              controller.updateSelectedCrypto(cryptoSymbol);

              updateAppWidget(cryptoSymbol, cryptoPrice);
            },
          );
        },
      ),
    );
  }
}
