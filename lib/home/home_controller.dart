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
    final cryptoResponse = await cryptosService.fetch();
    final cryptoSelected = await getCryptoSelectedSharedPreferences();

    cryptos.value = cryptoResponse;

    if (cryptoSelected != null) {
      updateSelectedCrypto(cryptoSelected);
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

    setCryptoSelectedSharedPreferences(cryptoSelected);
  }

  Future<String?> getCryptoSelectedSharedPreferences() async {
    final SharedPreferences preferences = await _preferences;

    return preferences.getString('crypto_selected');
  }

  void setCryptoSelectedSharedPreferences(String cryptoSelected) async {
    final SharedPreferences preferences = await _preferences;

    preferences.setString('crypto_selected', cryptoSelected);
  }

  @override
  void dispose() {
    cryptos.dispose();
  }
}
