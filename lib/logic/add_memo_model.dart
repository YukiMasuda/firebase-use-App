import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddMemoModel extends ChangeNotifier {
  String currentText;
  void changeText(){

    notifyListeners();
  }


  //追加機能を作成
  Future addTextToFirestore(){
    final firestore = Firestore.instance.collection('texts');
    firestore.add(
      {
        'text': currentText,
        'createdAt': Timestamp.now(),
      },
    );
  }
}