import 'package:flutter/material.dart';
import 'package:unna/widgtes/images_field.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('inserir Anúncio'),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            ImagesField(

            )
          ],
        ),
      ),
    );
  }
}