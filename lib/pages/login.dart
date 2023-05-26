import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chatpage.dart';

//ログイン画面用Widget
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //メッセージ表示用
  String infoText = '';
  //入力したメールアドレス・パスワード
  String email = '';
  String password = '';
  //入力したユーザー名
  String userName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //ユーザー名入力
                TextFormField(
                  decoration: const InputDecoration(labelText: 'ユーザー名'),
                  onChanged: (String value) {
                    setState(() {
                      userName = value;
                    });
                  },
                ),
                //メールアドレス入力
                TextFormField(
                  decoration: const InputDecoration(labelText: 'メールアドレス'),
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                //パスワード入力
                TextFormField(
                  decoration: const InputDecoration(labelText: 'パスワード'),
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  //メッセージ表示
                  child: Text(infoText),
                ),
                Container(
                    width: double.infinity,
                    //ユーザー登録ボタン
                    child: ElevatedButton(
                      child: const Text('ユーザー登録'),
                      onPressed: () async {
                        try {
                          //メール/パスワードでユーザー登録
                          final FirebaseAuth auth = FirebaseAuth.instance;
                          final result =
                              await auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          //投稿メッセージ用ドキュメント作成
                          await FirebaseFirestore.instance
                              .collection('users') //コレクションID指定
                              .doc() //ドキュメントID自動生成
                              .set({
                            'user': userName,
                            'uid' : auth.currentUser?.uid.toString(),
                          });
                          //ユーザー登録に成功した場合
                          //チャット画面に遷移＋ログイン画面を破棄
                          await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return ChatPage(result.user!);
                          }));
                        } catch (e) {
                          //ユーザー登録に失敗した場合
                          setState(() {
                            infoText = "登録に失敗しました:${e.toString()}";
                          });
                        }
                      },
                    )),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  //ログインボタン
                  child: OutlinedButton(
                    child: const Text('ログイン'),
                    onPressed: () async {
                      try {
                        //メール/パスワードでログイン
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        final result = await auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        //ログインに成功した場合
                        //チャット画面に遷移＋ログイン画面を破棄
                        await Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return ChatPage(result.user!);
                        }));
                      } catch (e) {
                        //ログインに失敗した場合
                        setState(() {
                          infoText = "ログインに失敗しました:${e.toString()}";
                        });
                      }
                    },
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
