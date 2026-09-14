import 'package:flutter/material.dart';
import 'package:mi_primer_app/features/home/screens/home_screen.dart';


void main() {
  runApp(const MyApp()); //crea la app
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),

      home: const MyHomePage() //crea el home page
    );
  }
}


