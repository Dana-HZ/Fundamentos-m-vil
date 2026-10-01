import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback onTap;
  final VoidCallback onComplete;

  const ItemCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: item.completado
          ? Colors.green.shade100
          : Colors.white,
      child: ListTile(
        leading: Icon(
          item.completado
              ? Icons.check_circle
              : Icons.bookmark_border,
          color: item.completado
              ? Colors.green
              : Colors.blue,
        ),

        title: Text(
          item.titulo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: item.completado
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),

        subtitle: Text(
          item.categoria,
        ),

        trailing: IconButton(
          icon: Icon(
            item.completado
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: item.completado
                ? Colors.green
                : Colors.grey,
          ),
          onPressed: onComplete,
        ),

        onTap: onTap,
      ),
    );
  }
}