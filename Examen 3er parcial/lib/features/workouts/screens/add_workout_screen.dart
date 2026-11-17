import 'package:fit_track_pro/features/workouts/models/workout_model.dart';
import 'package:flutter/material.dart';


class AddWorkoutScreen extends StatefulWidget {
  final WorkoutModel? workout;

  const AddWorkoutScreen({
    super.key,
    this.workout,
  });

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}


class _AddWorkoutScreenState extends State<AddWorkoutScreen>{

  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _durationController = TextEditingController();

  //////////////////
  @override
  void initState() {
    super.initState();

    if (widget.workout != null) {
      _titleController.text = widget.workout!.title;
      _durationController.text =
          widget.workout!.durationMinutes.toString();

      _selectedCategory = widget.workout!.category;
    }
  }
  //////////////////
  




  String _selectedCategory = "Fuerza";
  final List<String> _categories = ["Fuerza", "Cardio", "Flexibilidad"];



void _saveWorkout() {
  if (_formKey.currentState!.validate()) {
    final newWorkout = WorkoutModel(
      localId: widget.workout?.localId,
      title: _titleController.text,
      category: _selectedCategory,
      durationMinutes: int.parse(_durationController.text),
    );

    Navigator.pop(context, newWorkout);
  }
}
//////////////////////////////////////////////////
@override
void dispose() {
  _titleController.dispose();
  _durationController.dispose();
  super.dispose();
}
/////////////////////////////////////////////////

  @override 
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        //////////////////////////////
        title: Text(
          widget.workout == null
          ? "Nueva rutina"
          : "Modificar rutina",
        ),
        ////////////////////////////
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Nombre",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Por favor ingresa un nombre";
                  }
                  if(value.length < 3){
                    return "El nombre es muy corto";
                  }
                  return null;
                },
              ),

              SizedBox(height: 20,),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  labelText: "Categoria",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category)
                ),
                items: _categories.map((String category){
                  return DropdownMenuItem<String>(
                    child: Text(category),
                    value: category,
                  );
                }).toList(), 
                onChanged: (String? newValue){
                  setState((){
                    _selectedCategory = newValue!;
                  });

                }
              ),

              SizedBox(height: 20,),
              TextFormField(
                controller: _durationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Duración (minutos)",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.timer),
                ),

                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Ingresa los minutos";
                  }
                  if(int.tryParse(value) == null){
                    return "Solo se permiten valores numéricos";
                  }
                  return null;

                },

              ),

              Spacer(),
              ElevatedButton(
                onPressed: _saveWorkout, 
                ///////////////////////////////////////////
                child: Text(
                  widget.workout == null
                  ? "Guardar rutina"
                  : "Actualizar rutina",
                  style: TextStyle(fontSize: 18),
                ),
                ////////////////////////////////////////
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          )
        ),
        )
    );
  }

}