import 'package:flutter/material.dart';
import 'package:unna/models/filter.dart';
import 'package:unna/widgtes/animation_buttom.dart';
import 'package:unna/widgtes/order_by_field.dart';
import 'package:unna/widgtes/section_title.dart';



class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  
  Filter _filter = Filter(
    orderBy: OrderBy.DATE
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 13,
        title: const Text('Filtrar Busca'),
      ),
      body: Stack(
        children: <Widget>[
          Form(
            key: _formkey,
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                const SectionTitle(title:('Ordernar por')),
                OrderByField(
                  initialValue: OrderBy.DATE,
                  onSaved: (v){
                    _filter.orderBy =v;
                  },
                ),
                const SectionTitle(title:('Calendario')),
                
              ],
            ),
          ),
          AnimatedButton(
            scrollController: _scrollController,
            onTap: () {
              if(_formkey.currentState.validate()){
                _formkey.currentState.save();
              }
            },
          )
        ]
      ),
    );
  }
}