import 'package:crypto_android_widget/app/app_module.dart';
import 'package:crypto_android_widget/app/app_widget.dart';
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
  if (uri.host == 'updatecounter') {
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
        .then((value) {
      print(value);
    });

    await HomeWidget.saveWidgetData<int>('_counter', 0);
    await HomeWidget.updateWidget(
      name: 'AppWidgetProvider',
      iOSName: 'AppWidgetProvider',
    );
  }
}
