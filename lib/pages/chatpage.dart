import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'addpost.dart';

//チャット画面用Widget
class ChatPage extends StatelessWidget {
  //引数からユーザー情報を受け取れるようにする
  ChatPage(this.user);
  //ユーザー情報
  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('チャット'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              //ログアウト処理
              //内部で保持しているログイン情報などが初期化される
              await FirebaseAuth.instance.signOut();
              //ログイン画面に遷移＋チャット画面を破棄
              await Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return const LoginPage();
              }));
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Text('ログイン情報${user.email}'),
          ),
          Expanded(
            //FuterBuilder
            //非同期処理の結果をもとにWidgetを作れる
            child: StreamBuilder<QuerySnapshot>(
              //投稿メッセージ一覧を取得(非同期処理)
              //投稿日時でソート
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                //データが取得出来た場合
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  //取得した投稿メッセージ一覧をもとにリスト表示
                  return ListView(
                    children: documents.map((document) {
                      return Card(
                        child: ListTile(
                          title: Text(document['text']),
                          subtitle:
                              Text(document['email'] + '  ' + document['date']),
                          //自分の投稿メッセージの場合は削除ボタンを表示
                          trailing: document['email'] == user.email
                              ? IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    //投稿メッセージのドキュメントを削除
                                    await FirebaseFirestore.instance
                                        .collection('posts')
                                        .doc(document.id)
                                        .delete();
                                  },
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  );
                }
                //データが読み込み中の場合
                return const Center(
                  child: Text('読み込み中...'),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          //投稿画面に遷移
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return AddPostPage(user);
          }));
        },
      ),
    );
  }
}
