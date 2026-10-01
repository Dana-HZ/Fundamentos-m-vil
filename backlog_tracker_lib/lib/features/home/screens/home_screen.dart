import 'package:flutter/material.dart';

import '../models/item.dart';
import '../widgets/item_card.dart';
import '../../details/screens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   List<Item> itemList = [];


  final List<String> categorias = [
    "PC",
    "Consola",
    "Móvil",
  ];


  final TextEditingController tituloController =
      TextEditingController();


  String categoriaSeleccionada = "PC";

  @override
  void dispose() {
    tituloController.dispose();
    super.dispose();
  }


  void mostrarDialogoAgregar() {

    tituloController.clear();
    categoriaSeleccionada = "PC";

    showDialog(
      context: context,
      builder: (context) {

        return StatefulBuilder(
          builder: (context, setDialogState) {

            return AlertDialog(
              title: const Text("Agregar elemento"),

              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  
                  TextField(
                    controller: tituloController,
                    decoration: const InputDecoration(
                      labelText: "Título",
                      hintText: "Ej. Minecraft",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

              
                  DropdownButtonFormField<String>(
                    value: categoriaSeleccionada,

                    decoration: const InputDecoration(
                      labelText: "Categoría",
                      border: OutlineInputBorder(),
                    ),

                    items: categorias.map((categoria) {
                      return DropdownMenuItem<String>(
                        value: categoria,
                        child: Text(categoria),
                      );
                    }).toList(),

                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() {
                          categoriaSeleccionada = value;
                        });
                      }
                    },
                  ),
                ],
              ),

              actions: [

           
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar"),
                ),

             
                ElevatedButton(
                  onPressed: () {

                    if (tituloController.text.trim().isEmpty) {
                      return;
                    }

                    final nuevoItem = Item(
                      titulo: tituloController.text.trim(),
                      categoria: categoriaSeleccionada,
                    );

                    setState(() {
                      itemList.add(nuevoItem);
                    });

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Elemento agregado correctamente",
                        ),
                      ),
                    );
                  },

                  child: const Text("Agregar"),
                ),
              ],
            );
          },
        );
      },
    );
  }


  void cambiarEstado(Item item) {

    setState(() {
      item.completado = !item.completado;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          item.completado
              ? "Elemento completado"
              : "Elemento marcado como pendiente",
        ),
      ),
    );
  }


  void eliminarItem(int index) {

    final String titulo = itemList[index].titulo;

    setState(() {
      itemList.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$titulo eliminado correctamente",
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Backlog Tracker"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: itemList.isEmpty

            ? const Center(
                child: Text(
                  "No hay elementos en tu backlog",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )

            : ListView.builder(

                itemCount: itemList.length,

                itemBuilder: (context, index) {

                  final Item currentItem = itemList[index];

                  return Dismissible(

                    key: ValueKey(currentItem),

                    direction: DismissDirection.horizontal,

                    background: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      color: Colors.red,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),

                    secondaryBackground: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      color: Colors.red,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),

                    onDismissed: (direction) {
                      eliminarItem(index);
                    },

                    child: ItemCard(
                      item: currentItem,

                      onComplete: () {
                        cambiarEstado(currentItem);
                      },

                      onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(
                                  item: currentItem,
                                ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),



      floatingActionButton: FloatingActionButton(
        onPressed: mostrarDialogoAgregar,

        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}