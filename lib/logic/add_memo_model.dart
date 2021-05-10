import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMemoModel extends ChangeNotifier {
  String currentText;
  File image;
  bool focus = true;
  String downloadURL;
  final picker = ImagePicker();


  final firestore = Firestore.instance.collection('texts');

  //追加機能を作成
  Future addData() async{
    final imageURL = await _uploadFile();

    firestore.add(
      {
        'text': currentText,
        'imageURL': imageURL,
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

  //FirebaseStorageへアップロード
  Future<String> _uploadFile() async {
    if (image == null){
      return '';
    }
    final storage = FirebaseStorage();
    final ref = storage.ref().child('texts').child('text');
    final snapshot = await ref.putFile(image).onComplete;
    final downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  //imagePickerで画像を取ってくる
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      print('画像を選択しました');
    }else{
      print('画像がありません');
    }
  }



}
