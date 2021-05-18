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
  final picker = ImagePicker();


  final firestore = Firestore.instance.collection('texts');

  //追加機能を作成
  Future addData() async{
    final imageURL = await uploadFile();
    print('add呼ばれた');

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
  Future<String> uploadFile() async {
    if (image == null){
      print('アップロードでnull');
      return '';
    }
    print('アップロード呼ばれた');
    final storage = FirebaseStorage();
    final ref = storage.ref().child('texts').child('ko');
    final snapshot = await ref.putFile(image).onComplete;
    final downloadURL = await snapshot.ref.getDownloadURL();
    print(downloadURL);
    return downloadURL;
  }

  //imagePickerで画像を選択し、imageFILEに挿入
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
      print('画像を選択しました');
    }else{
      print('画像がありません');
    }
  }

  DateTime now = DateTime.now();



//todo 画像をアップロードするコード書いたけどうまくいかない。コード自体は難しくないが呪文レベル。(FirebaseStorage)
}
