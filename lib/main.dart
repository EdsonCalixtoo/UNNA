import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unna/Login.dart';


void main() {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark
  ));


    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'teste',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0XFF2C2B4B),
        primarySwatch: Colors.blue,
        fontFamily: "Poppins"
      ),
       debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
