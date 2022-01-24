//エンティテイモデル　要素としてのモデル8:41
import 'package:cloud_firestore/cloud_firestore.dart';

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
