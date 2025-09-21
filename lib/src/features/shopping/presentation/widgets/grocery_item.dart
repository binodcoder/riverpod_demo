import 'package:flutter/material.dart';

class GroceryItem extends StatelessWidget {
  const GroceryItem({
    super.key,
    required this.name,
    required this.color,
    required this.quantity,
  });

  final String name;
  final Color color;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Theme.of(context).cardTheme.margin,
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color),
        title: Text(name),
        trailing: Text('x$quantity'),
      ),
    );
  }
}
