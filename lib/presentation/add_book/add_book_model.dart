import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corianderapp/domain/book.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// 11:29
class AddBookModel extends ChangeNotifier {
  String bookTitle = ''; //null回避のため初期値で「''」を入れとく
  File imageFile;

  //Firebase strageに画像を追加　12：09
  Future showImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    notifyListeners();
  }

  Future addBookToFirebase() async {
    //ここでバリデーションする　13:27
    if (bookTitle.isEmpty) {
      throw ('タイトル入力してください。');
    }
    FirebaseFirestore.instance.collection('books').add({
      //addの中はcloud_firestore 0.13.6参照　JSONみたいなやつ　Dictionaly型
      'title': bookTitle, //13:08
      'createdAt': Timestamp.now() //25:58 追加された時間 ソートとかできるようになる
    }); //12:02
  }

  Future updateBook(Book book) async {
    final document = FirebaseFirestore.instance.collection('books').doc(book
        .documentID); //bookのイニシャライザでFirestoreのdocumentIDを取得し、そこから持ってkる(14:28 Fires)
    await document.update(
      {'title': bookTitle, 'updateAt': Timestamp.now()},
    );
  }
}
