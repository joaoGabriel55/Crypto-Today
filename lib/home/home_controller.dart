// import 'dart:async';

import 'dart:convert';
import 'dart:ffi';

import 'package:crypto_android_widget/services/cryptos_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController implements Disposable {
  final cryptosService = CryptosService();
  final _preferences = SharedPreferences.getInstance();
  final ValueNotifier<List<dynamic>> cryptos = ValueNotifier([]);

  HomeController() {
    fetch();
  }

  Future<void> fetch() async {
    final SharedPreferences preferences = await _preferences;
    final String? cryptosStored = preferences.getString('cryptos');

    if (cryptosStored != null) {
      cryptos.value = jsonDecode(cryptosStored);
    } else {
      final cryptoResponse = await cryptosService.fetch();
      cryptos.value = cryptoResponse;

      preferences.setString('cryptos', jsonEncode(cryptoResponse));
    }
  }

  void updateSelectedCrypto(cryptoSelected) async {
    final updatedCryptos = [...cryptos.value].map((crypto) {
      if (crypto['symbol'] == cryptoSelected) {
        return {...crypto, 'selected': !crypto['selected']};
      }

      return {...crypto, 'selected': false};
    }).toList();

    cryptos.value = updatedCryptos;
    setCryptosSharedPreferences(updatedCryptos);
  }

  void setCryptosSharedPreferences(cryptos) async {
    final SharedPreferences preferences = await _preferences;
    preferences.setString('cryptos', jsonEncode(cryptos));
  }

  @override
  void dispose() {
    cryptos.dispose();
  }
}
