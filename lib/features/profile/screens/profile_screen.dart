import 'package:flutter/material.dart';
import 'package:mi_primer_app/features/profile/widgets/profile_header.dart';
import 'package:mi_primer_app/features/profile/widgets/profile_stat_card.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Perfil"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProfileHeader(),

            SizedBox(height: 20),

            Divider(),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ProfileStatCard(
                    title: "Entrenamientos completados:",
                    value: "15",
                  ),
                ),

                Expanded(
                  child: ProfileStatCard(
                    title: "Último registro:",
                    value: "Máquina abductora",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

