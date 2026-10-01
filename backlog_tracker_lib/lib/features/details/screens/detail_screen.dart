import 'package:flutter/material.dart';

import '../../home/models/item.dart';

class DetailScreen extends StatelessWidget {

  final Item item;

  const DetailScreen({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Detalles"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Título",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              item.titulo,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Categoría",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              item.categoria,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Estado",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              item.completado
                  ? "Completado"
                  : "Pendiente",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),

          ],
        ),
      ),
    );
  }
}