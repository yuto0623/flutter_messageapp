import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//投稿画面
class AddPostPage extends StatefulWidget {
  //引数からユーザー情報を受け取る
  AddPostPage(this.user);
  //ユーザー情報
  final User user;

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  //入力した投稿ページ
  String messageText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('チャット画面'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //投稿メッセージ入力
              TextFormField(
                decoration: const InputDecoration(labelText: '投稿メッセージ'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onChanged: (String value) {
                  setState(() {
                    messageText = value;
                  });
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('投稿'),
                  onPressed: () async {
                    final date =
                        DateTime.now(); //現在の日時
                    final dateText = date.year.toString() + '年' + date.month.toString() + '月' + date.day.toString() + '日' + date.hour.toString() + '時' + date.minute.toString() + '分';
                    final email = widget.user.email; //AddPostPageのデータを参照
                    //投稿メッセージ用ドキュメント作成
                    await FirebaseFirestore.instance
                        .collection('posts') //コレクションID指定
                        .doc() //ドキュメントID自動生成
                        .set({
                      'text': messageText,
                      'email': email,
                      'date': dateText
                    });
                    //1つ前の画面に戻る
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
