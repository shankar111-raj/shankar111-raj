import 'package:flutter/material.dart';
import 'package:languageproject/main.dart';

class NewScreen extends StatelessWidget {
   NewScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(onPressed: (){
        MyApp.of(context)!.changeLanguage(Locale('en'));
      }, child: Text("hello"),)),
      
    );
  }
}