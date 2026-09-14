import 'package:flutter/material.dart';
import 'package:mi_primer_app/features/home/models/activity.dart';
import 'package:mi_primer_app/features/home/widgets/interactive_activity_card.dart';
import 'package:mi_primer_app/features/profile/screens/profile_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  List<Activity> activityList = [

    Activity(title: "Pasos diarios", subtitle:"", trailingText: "", icon: Icons.directions_walk, iconColor: Colors.black),
    Activity(title: "Natación", subtitle:"", trailingText: "", icon: Icons.pool, iconColor: Colors.black),
    Activity(title: "Karate", subtitle:"", trailingText: "", icon: Icons.sports_martial_arts, iconColor: Colors.black),
    Activity(title: "Desayuno", subtitle:"", trailingText: "", icon: Icons.food_bank, iconColor: Colors.black),
    Activity(title: "Básquetbol", subtitle:"", trailingText: "", icon: Icons.sports_basketball, iconColor: Colors.black),
    Activity(title: "Pasos diarios", subtitle:"", trailingText: "", icon: Icons.directions_walk, iconColor: Colors.black),
    Activity(title: "Natación", subtitle:"", trailingText: "", icon: Icons.pool, iconColor: Colors.black),
    
    

  ];

  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white, //color del texto
        title: Text("Panel de actividad física"),

        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
            },
          ),
        ],
      ),
      
      

      body: 
      Padding(
        padding:EdgeInsets.all(16.0),
          
        child: ListView.builder( //Esto agrega en automático el scroll, y se muestran los elementos que se salgan de pantalla
          
          padding: EdgeInsets.all(8.0),    
          itemCount: activityList.length,          
          itemBuilder: (context, index){
            final Activity currentActivity = activityList[index];
            return InteractiveActivityCard(activity: currentActivity); //Se usa esta clase de la tarjeta interactiva
          }
        
        )
        
        
        /* Column(

          children: [
            Text("Resumen de hoy", style:TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),

            SizedBox(height: 20.0),

            Card(
              child: ListTile(
                leading: Icon(Icons.directions_walk),
                title: Text("Pasos diarios"),
                subtitle: Text("Meta 10 000 pasos"),
                trailing: Text("7,450", style:TextStyle(fontSize: 18.0))
              )

            ),

            const ActivityCard(
              title: "Pasos Diarios", 
              subtitle: "Meta 10 000 pasos", 
              trailingText: "7,450", 
              icon: Icons.directions_walk, 
              iconColor: Colors.blue
            ),

            const ActivityCard(
              title: "Rutina de Fuerza", 
              subtitle: "Tren superior", 
              trailingText: "Hecho", 
              icon: Icons.fitness_center, 
              iconColor: Colors.blue
            ),

            const ActivityCard(
              title: "Natación", 
              subtitle: "Meta 1 000 metros", 
              trailingText: "750", 
              icon: Icons.pool, 
              iconColor: Colors.blue
            ),

            const InteractiveActivityCard(title: "Pasos diarios")


          ],


        ),*/

        

        )

      
    );
  }
}

