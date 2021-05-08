import 'package:firebase_training_app/Pages/main.dart';
import 'package:firebase_training_app/logic/add_memo_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMemoPage extends StatelessWidget{
  final myApp = MyApp();

  AddMemoPage({this.passedText, this.passedID});
  String passedText;
  String passedID;

  @override
  Widget build(BuildContext context) {
    // print(passedText + '楽しいよ');
    // print(passedID + '楽しくないよ');
    return ChangeNotifierProvider<AddMemoModel>(
      create: (_) => AddMemoModel(),
      child: Scaffold(
        appBar: AppBar(
          leading: Consumer<AddMemoModel>(
            builder: (context, model, child) {
              model.currentText = passedText;
              if (passedID == null){
                model.focus = false;
                print(model.focus);
              }
              return IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {

                  //このロジックは間違ってない
                  if (passedID == null){
                    if(model.currentText == null || model.currentText == ''){
                      //挙動なし
                      print('挙動1:　値作成なし');
                    }else{
                      model.addData();
                      print('挙動2:　値作成');
                    }
                  }else{
                    if(passedText == model.currentText){
                      //挙動なし
                      print('挙動3:　値更新なし');
                    } else if(model.currentText == '') {
                      model.deleteData(passedID);
                      print('挙動4:　削除');
                    }else{
                      model.updateData(passedID);
                      print('挙動5:　値更新');
                    }
                  }
                Navigator.pop(context);
                  },
              );
            }
          ),
        ),
        body: Consumer<AddMemoModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                autofocus: model.focus,
                // 初期値を持つ
                controller: TextEditingController(text: passedText),

                //改行を可能にするコード
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 20,
                ),
                onChanged: (text){
                  //変わるたびにStateに管理してもらいたい->そもそも管理できている→変数代入でいけそう
                    print(model.currentText = text);
                },
              ),
            );
          }
        ),
      ),
    );
  }
}