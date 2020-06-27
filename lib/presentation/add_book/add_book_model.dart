import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corianderapp/domain/book.dart';
import 'package:flutter/material.dart';

// 11:29
class AddBookModel extends ChangeNotifier {
  String bookTitle = ''; //null回避のため初期値で''「」を入れとく

  Future addBookToFirebase() async {
    //ここでバリデーションする　13:27
    if (bookTitle.isEmpty) {
      throw ('タイトル入力してください。');
    }
    Firestore.instance.collection('books').add({
      //addの中はcloud_firestore 0.13.6参照　JSONみたいなやつ　Dictionaly型
      'title': bookTitle, //13:08
      'createdAt': Timestamp.now() //25:58 追加された時間 ソートとかできるようになる
    }); //12:02
  }

  Future updateBook(Book book) async {
    final document = Firestore.instance.collection('books').document(book
        .documentID); //bookのイニシャライザでFirestoreのdocumentIDを取得し、そこから持ってkる(14:28 Fires)
    await document.updateData(
      {'title': bookTitle, 'updateAt': Timestamp.now()},
    );
  }
}
