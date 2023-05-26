import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('設定画面')),
      body: Center(child: Column(children: [
        TextField(),
        ElevatedButton(onPressed: () {}, child: Text('test'))
      ]),),
    );
  }
}
