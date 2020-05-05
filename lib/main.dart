import 'package:flutter/material.dart';
import 'package:unna/Login.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UNNA', //erros nos nomes corrigidos
      debugShowCheckedModeBanner: false,
      home: Login()
    );
  }
}
