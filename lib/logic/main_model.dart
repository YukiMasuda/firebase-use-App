import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier{
  List<String> texts = [];
//<>の中の謎　KboyさんはBookにしていたけどこれがどこから来ているのか ->Bookというドメインを作っていた。レポジトリ？

  //ここら辺何やっているのかわからない

  //呼び出し機能を作成
Future getTexts() async{
  final docs = await Firestore.instance.collection('texts').getDocuments();
  final texts = docs.documents.map((doc) => doc['text']).toList();
  this.texts = texts;
  notifyListeners();
}

}