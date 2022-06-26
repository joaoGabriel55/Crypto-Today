import 'package:crypto_android_widget/shared/theme.dart';
import 'package:flutter/material.dart';

class CryptosList extends StatefulWidget {
  const CryptosList({
    Key? key,
    required this.cryptos,
    required this.hasData,
    required this.hasError,
    required this.onSelected,
  }) : super(key: key);

  final List<dynamic> cryptos;
  final bool hasData;
  final bool hasError;
  final Function onSelected;

  @override
  State<CryptosList> createState() => _CryptosListState();
}

class _CryptosListState extends State<CryptosList> {
  @override
  Widget build(BuildContext context) {
    if (widget.hasError) {
      return Text('Error loading data', style: defaultTextStyle);
    }
    if (!widget.hasData) return const Text('Loading...');

    return ListView(
      children: widget.cryptos.map(
        (crypto) {
          final cryptoPrice = "${crypto['symbol']} - USD: ${crypto['price']}";

          return ListTile(
            title: Text(crypto['name'], style: defaultTextStyle),
            subtitle: Text(cryptoPrice, style: defaultTextStyle),
            trailing: Checkbox(
              fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.yellow.withOpacity(.32);
                }
                return Colors.yellow;
              }),
              value: crypto['selected'],
              onChanged: (_) {
                if (!crypto['selected']) {
                  widget.onSelected(crypto['symbol'], crypto['price']);
                }
              },
            ),
          );
        },
      ).toList(),
    );
  }
}
