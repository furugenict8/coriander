import 'package:cloud_firestore/cloud_firestore.dart';

// エンティテイモデル　要素(Listに入れる要素ってことかな)としてのモデル8:41
// ロジックを書いているのかbook_list_modelになり、こっちは要素のみ(ロジックはない。)
// Kboyさんはこれをエンティティと読んでいる。
// エンティティはFirestoreのドキュメントの総称みたいなもの。

// 以下Firestoreとこのプロジェクトのコードの対比表。
// Firestoreのコレクション == List books
// Firestoreのドキュメント == class Book
// Firestoreのフィールド == title, documentID

// エンティティ(コレクションのListの各要素。今回はbook)で定義するのは
// 持たせるフィールドと、初期化のためのコンストラクタ
class Book {
  //(Firestoreの値を更新　15：54)(イニシャライザ　8:47)
  Book(DocumentSnapshot doc) {
    documentID = doc.id;
    title = doc['title'];
  }

  String documentID;
  String title;
  String imageURL;
}
