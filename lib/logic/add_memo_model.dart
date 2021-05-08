import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddMemoModel extends ChangeNotifier {
  String currentText;
  final firestore = Firestore.instance.collection('texts');

  //追加機能を作成
  Future addData() {
    firestore.add(
      {
        'text': currentText,
        'createdAt': Timestamp.now(),
      },
    );
  }

  //更新機能
  Future updateData(String documentID) {
    firestore.document(documentID).updateData({
      'text': currentText,
      'createdAt': Timestamp.now(),
    });
  }

  //削除機能
  Future deleteData(String documentID) {
    firestore.document(documentID).delete();
  }
}
