import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoryCardSimple extends StatelessWidget {
  final CategoryModel category;

  const CategoryCardSimple({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 10,
                  child: Text(
                    category.order.toString(),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  )),
              Expanded(
                flex: 20,
                child: Icon(
                  IconData(
                    int.parse(category.icon),
                    fontFamily: 'MaterialIcons',
                  ),
                ),
              ),
              Expanded(
                flex: 70,
                child: Text(
                  category.name,
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
