import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  String mail = '';
  String password = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUp() async {
    //ここでバリデーションする　13:27→　入力が要件を満たしているかをチェックするという意味らしい。
    if (mail.isEmpty) {
      throw ('メールアドレスを入力してください。');
    }

    if (password.isEmpty) {
      throw ('パスワードを入力してください。');
    }

    // TODO 新規登録、ログインでFirebaseと連携する。
    // firebase_auth 0.16.1 Register a user 　からいったんコピペ
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: mail,
      password: password,
    ))
        .user;
    //
    final email = user.email;

    // add_book_modelから持ってきた。　（FirebaseAuth 動画　12:32あたり　）
    Firestore.instance.collection('users').add({
      'email': email,
      'createdAt': Timestamp.now(),
    });
  }
}
