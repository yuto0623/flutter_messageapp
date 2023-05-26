import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messageapp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/login.dart';
import 'pages/chatpage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //最初に表示するWidget
  runApp(ChatApp());
}

//ログイン判定を行うウィジェット
class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ChatApp',
        theme: ThemeData.dark(
          //テーマカラー

          useMaterial3: true,
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
