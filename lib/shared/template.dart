import 'package:flutter/material.dart';

class Template extends StatelessWidget {
  const Template({Key? key, required this.body}) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Today'),
        foregroundColor: Colors.yellow,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black54,
      body: body,
    );
  }
}
