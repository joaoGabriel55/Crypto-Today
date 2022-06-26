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
    HomeWidget.widgetClicked.listen(loadData);
    loadData(null); // This will load data from widget every time app is opened
  }

  void loadData(Uri? uri) async {
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0).then(
      (value) {
        print(value);
      },
    );
    setState(() {});
  }

  Future<void> updateAppWidget() async {
    await HomeWidget.saveWidgetData<int>('_counter', 0);
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
            onSelected: (crypto) {
              controller.updateSelectedCrypto(crypto);
            },
          );
        },
      ),
    );
  }
}
