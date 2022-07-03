import 'package:crypto_android_widget/app/app_module.dart';
import 'package:crypto_android_widget/app/app_widget.dart';
import 'package:crypto_android_widget/services/background_callback_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:home_widget/home_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HomeWidget.registerBackgroundCallback(BackgroundCallbackService.call);

  return runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}
