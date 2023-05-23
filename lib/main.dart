import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messageapp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/login.dart';
import 'pages/chatpage.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //最初に表示するWidget
  runApp(ChatApp());
}

// class ChatApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       //アプリ名
//       title: 'ChatApp',
//       theme: ThemeData(
//         //テーマカラー
//         primarySwatch: Colors.blue,
//       ),
//       //ログイン画面を表示
//       home: const LoginPage(),
//     );
//   }
// }

//ログイン判定を行うウィジェット
class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'ChatApp',
        theme: ThemeData(
          //テーマカラー
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              //スプラッシュ画面などに書き換えてもいい
              return const SizedBox();
            }
            if (snapshot.hasData) {
              //Userがnullでない、つまりサインイン済みのホーム画面へ
              final user = snapshot.data!;
              return ChatPage(user);
            }
            return const LoginPage();
          },
        ),
      );
}
