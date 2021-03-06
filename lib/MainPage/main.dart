import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_training_app/AddPage/add_memo_model.dart';
import 'package:firebase_training_app/AddPage/add_memo_page.dart';
import 'package:firebase_training_app/SignUp/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(MainPage());
// }

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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddMemoModel>(
        create: (_) => AddMemoModel(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text('メモ一覧'),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('texts')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                return ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    // TODO: documentにnullが入っている時のハンドリングを行う
                    if (!snapshot.hasData) {
                      return Text('loading...');
                    }
                    return Column(
                      children: [
                        ListTile(
                          title: Text(document['text']),
                          leading: document['imageURL'] == null
                              ? Container(
                                  color: Colors.red,
                                  width: 60,
                                )
                              : Image.network(document['imageURL']),
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
                        Divider(),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.blue,
              child: IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushNamed('/add_memo');
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => AddMemoPage()
                  //     )
                  // );

                },
              ),
            ),
          );
        });
  }
}
