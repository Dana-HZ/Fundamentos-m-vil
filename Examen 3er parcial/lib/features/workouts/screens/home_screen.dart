import 'package:fit_track_pro/core/storage/local_storage_services.dart';
import 'package:fit_track_pro/features/auth/screens/login_screen.dart';
import 'package:fit_track_pro/features/workouts/models/workout_model.dart';
import 'package:fit_track_pro/features/workouts/screens/add_workout_screen.dart';
import 'package:fit_track_pro/features/workouts/services/local_workout_service.dart';
import 'package:fit_track_pro/features/weight/screens/weight_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final LocalWorkoutService _dbService = LocalWorkoutService();
  List<WorkoutModel> _workouts = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }


  Future<void> _loadWorkouts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final workouts = await _dbService.getWorkouts();


      if (!mounted) return;


      setState(() {
        _workouts = workouts;
        _isLoading = false;
      });

    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      }
      );


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al cargar rutinas: $e'),
          backgroundColor: Colors.red,
        ),

      );


    }

  }

  void _logout() async {
    final storage = LocalStorageService();
    await storage.deleteToken();

    if (!mounted) return;


    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> _navigateToAddWorkout([WorkoutModel? workout]) async {
    final result = await Navigator.push(
      context,

      MaterialPageRoute(
        builder: (context) => AddWorkoutScreen(
          workout: workout,
        ),
        
      ),

    );


    if (result != null && result is WorkoutModel) {

      if (result.localId == null) {
        await _dbService.insertWorkout(result);
      } 
      else {
        await _dbService.updateWorkout(result);
      }

      await _loadWorkouts();


      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result.localId == null
                  ? "Rutina creada exitosamente"
                  : "Rutina actualizada exitosamente",
            ),
            backgroundColor: Colors.green,
          ),
        );
      }

    }

  }

  /////
  //////////////////////////////////////////////

  void _showWorkoutDetails(WorkoutModel workout) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(workout.title),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "Categoría: ${workout.category}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12),

              Text(
                "Duración: ${workout.durationMinutes} minutos",
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(height: 12),
              Text(
                "ID: ${workout.localId}",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cerrar"),
            ),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _navigateToAddWorkout(workout);
              },
              icon: Icon(Icons.edit),
              label: Text("Modificar"),
            ),

          ],
        );

      },
    );

  }



  /////////////////////////////////////////////////

  Future<void> _deleteWorkout(int id) async {
    await _dbService.deleteWorokout(id);

    if (mounted) {
      _loadWorkouts();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Rutina eliminada")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis entrenamientos"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,

        actions: [

          
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WeightScreen(),
                ),
              );
            },
            icon: Icon(Icons.monitor_weight),
            tooltip: "Registro de peso",
          ),

         
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('¿Cerrar sesión?'),
                  content: Text('Tendrás que volver a iniciar tus datos'),
                  actions: [

                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancelar'),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _logout();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text(
                        "Salir",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                  ],
                ),
              );
            },
            icon: Icon(Icons.logout),
          ),

        ],
      ),

      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _workouts.isEmpty
              ? Center(
                  child: Text("No tienes rutinas creadas"),
                )
              : ListView.builder(
                  itemCount: _workouts.length,

                  itemBuilder: (context, index) {
                    final workout = _workouts[index];

                    return Card(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),

                      child: ListTile(
                        onTap: () {
                          _showWorkoutDetails(workout);
                        },

                        leading: CircleAvatar(
                          child: Icon(Icons.fitness_center),
                        ),

                        title: Text(
                          workout.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        trailing: IconButton(
                          onPressed: () => _deleteWorkout(workout.localId!),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),

                        subtitle: Text(
                          '${workout.category} - ${workout.durationMinutes} min',
                        ),
                      ),
                    );
                  },
                ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddWorkout(),
        child: Icon(Icons.add),
      ),
    );
  }
}
