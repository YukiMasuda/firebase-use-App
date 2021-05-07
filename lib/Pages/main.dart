import 'package:firebase_training_app/Pages/add_memo_page.dart';
import 'package:firebase_training_app/logic/add_memo_model.dart';
import 'package:firebase_training_app/logic/main_model.dart';
import 'package:firebase_training_app/sample/book_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // ブラックにするとダメになっちゃった

      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel()..getTexts(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('メモ一覧'),
        ),
        body: Consumer<MainModel>
          (builder: (context, model, child) {
            //Stringのリスト
            final texts = model.texts;
            final listTiles = texts.map((doc) => ListTile(title: Text(doc),))
                .toList();

            return ListView(
              children:
                listTiles
              ,
            );
          }
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          child: IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: (){
              Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => AddMemoPage())
              );
              print('メモ追加へ');
            },
          ),
        ),
      ),
    );
  }
}


