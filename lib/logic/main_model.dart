import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_training_app/domain/Text.dart';
import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier{
  List<String> texts = [];
//<>の中の謎　KboyさんはBookにしていたけどこれがどこから来ているのか ->Bookというドメインを作っていた。レポジトリ？

  //ここら辺何やっているのかわからない

  //呼び出し機能を作成
Future getTexts() async{
  final textsA = await Firestore.instance.collection('books').getDocuments();

  //docの中のtext Keyとついになっているものをひたすらさらってそれをリスト化してtextsに格納している
  //documentsSnapShot型をlist型に変換して返している。
  final texts = textsA.documents.map((text) => text['title']).toList();
  print(texts);
  print("ヤンバルクイナ");
  this.texts = texts;
  notifyListeners();
}

//ここまでやった！→create, 読み込み機能（未完成）
//ひとまずここまでやりたい

}