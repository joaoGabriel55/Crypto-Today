import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

class WidgetData<T> {
  static Future getWidgetData(key, defaultValue) async {
    return await HomeWidget.getWidgetData(
      key,
      defaultValue: defaultValue,
    );
  }
}
