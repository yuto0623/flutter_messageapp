import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  String setName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('設定画面')),
      body: Center(
        child: Column(children: [
          const Text('ユーザー名変更'),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: TextField(
              onChanged: (String value) {
                setName = value;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {},
            child: Text('test'),
          )
        ]),
      ),
    );
  }
}
