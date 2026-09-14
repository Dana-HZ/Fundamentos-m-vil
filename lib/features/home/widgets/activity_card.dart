//No se está usanod, es el que se usaba antes
import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget{

  final String title;
  final String subtitle;
  final String trailingText;
  final IconData icon;
  final Color iconColor;

  const ActivityCard(    
    {super.key, required this.title, 
    required this.subtitle, required this.trailingText, 
    required this.icon, required this.iconColor});

  @override
  Widget build(BuildContext context){
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
      
        title: Text(title, style:TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Text(trailingText, style:TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        leading: Icon(icon, size: 40, color: iconColor)
        

      )
    );
  }

}