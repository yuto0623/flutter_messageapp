import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messageapp/firebase_options.dart';
import 'pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //最初に表示するWidget
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //アプリ名
      title: 'ChatApp',
      theme: ThemeData(
        //テーマカラー
        primarySwatch: Colors.blue,
      ),
      //ログイン画面を表示
      home: const LoginPage(),
      
    );
  }
}
