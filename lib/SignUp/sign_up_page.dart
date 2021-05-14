import 'package:firebase_training_app/SignUp/sign_up_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class SignUpPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<SignUpModel>(
        create: (_) => SignUpModel(),
          child: Scaffold(
            appBar: AppBar(
              title: Text('SignUp'),
            ),
            body: Consumer<SignUpModel>(
              builder: (context, model, child) {
                return Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Suzu@yamanouchi.com'
                      ),
                      onChanged: (text){
                        model.mail = text;
                        print(model.mail);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'pass word'
                      ),
                      onChanged: (text){
                        model.password = text;
                        print(model.password);
                      },
                    obscureText: true,
                    ),
                    RaisedButton(
                      child: Text('Sign Up'),
                        onPressed: () async {
                        try{
                          await model.signUp();
                          _showDialog(context, '登録完了しました');
                        } catch (e) {
                          _showDialog(context, e.toString());
                        }
                       }
                      ),
                  ],
                );
              }
            ),
          ),
      ),
    );
  }
  Future _showDialog(
      BuildContext context,
      String title,
      ){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            actions: <Widget>[
              FlatButton(
                  child: Text('OK'),
                  onPressed: (){
                    Navigator.of(context).pushNamed('/home');
                  })
            ],
          );
        }
        );
  }
}