import 'package:flutter/material.dart';

class ProfileStatCard extends StatelessWidget {
  final String title;
  final String value;

  const ProfileStatCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 10),

            Text(
              value,
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

