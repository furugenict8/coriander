import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  String mail = '';
  String password = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future login() async {
    //ここでバリデーションする　13:27→　入力が要件を満たしているかをチェックするという意味らしい。
    if (mail.isEmpty) {
      throw ('メールアドレスを入力してください。');
    }

    if (password.isEmpty) {
      throw ('パスワードを入力してください。');
    }

    // TODO サインインをしてユーザ情報取得
    final result = await _auth.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );

    final uid = result.user.uid;
    //TODO uidを端末に保存する。よくあるのはuidを使ってfirestoreから他の情報持ってきたりする。
  }
}
