import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_training_app/AddPage/add_memo_model.dart';
import 'package:firebase_training_app/AddPage/add_memo_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MainPage extends StatelessWidget {
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

//AddMemoのMaterialAppを消した



class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddMemoModel>(
        create: (_) => AddMemoModel(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('メモ一覧'),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('texts')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                return Container(
                  //Body全体の色指定
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30,right: 30, left: 30),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Container(

                        child: Container(
                          color: Colors.grey,
                          child: ListView(
                            children:
                                snapshot.data.documents.map((DocumentSnapshot document) {
                              // TODO: documentにnullが入っている時のハンドリングを行う
                              if (!snapshot.hasData) {
                                //ダメだった
                              }
                              return Consumer<AddMemoModel>(
                                builder: (context, model, child) {
                                  //横から削除が出るようにしているやつ
                                  return Slidable(
                                    actionPane: SlidableDrawerActionPane(),
                                    actionExtentRatio: 0.25,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            document['text'],
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => AddMemoPage(
                                                        passedText: document['text'],
                                                        passedID: document.documentID
                                                    )
                                                )
                                            );
                                          },
                                        ),
                                        //Listの間の線を入れている
                                        Divider(),
                                      ],
                                    ),
                                    //削除のやつ
                                    secondaryActions: <Widget>[
                                      IconSlideAction(
                                        caption: '削除',
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: (){
                                          model.deleteData(document.documentID);
                                        },
                                      ),
                                    ],
                                  );
                                }
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.blue,
              child: IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddMemoPage()
                    )
                  );
                },
              ),
            ),
          );
        });
  }
}

class SearchTextWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

  }
}
