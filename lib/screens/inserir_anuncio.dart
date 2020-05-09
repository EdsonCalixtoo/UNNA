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

            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Titulo',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.grey,
                  fontSize: 18,
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
              ),
              validator: (text) {
                if (text.isEmpty) return 'Campo Obrigatório';
                return null;
              },
              onSaved: (t) {

              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Descrição',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.grey,
                  fontSize: 18,
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
              ),
              validator: (text) {
                if (text.trim().isEmpty) return 'Campo Obrigatório';
                if (text.trim().length <10)
                return 'Fala mais Sobre!';
                return null;
              },
              onSaved: (t) {
                
              },
            ),
            Container(
              height: 50,
              child: RaisedButton(
                color: Colors.pink,
                child: Text(
                  'Enviar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  if(_formkey.currentState.validate()){

                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}