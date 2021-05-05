import 'package:firebase_training_app/logic/add_memo_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMemoPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddMemoModel>(
      create: (_) => AddMemoModel(),
      child: Scaffold(
        appBar: AppBar(
          leading: Consumer<AddMemoModel>(
            builder: (context, model, child) {
              return IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  //ここを条件分岐したい
                  model.addTextToFirestore();
                  Navigator.pop(context);
                },
              );
            }
          ),
        ),
        body: Consumer<AddMemoModel>(builder: (context, model, child) {
            return Container(
              child: TextField(
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