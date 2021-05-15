import 'package:firebase_training_app/AddPage/add_memo_page.dart';
import 'package:firebase_training_app/MainPage/main.dart';
import 'package:firebase_training_app/SignUp/sign_up_page.dart';
import 'package:flutter/material.dart';


//ルート管理画面
void main (){
  runApp(MaterialApp(
    initialRoute: '/',
    routes: <String, WidgetBuilder> {
      '/': (BuildContext context) => SignUpPage(),
      '/home': (BuildContext context) => MainPage(),
      '/add_memo': (BuildContext context) => AddMemoPage(),
    },
  )
  );
}