// class910.dart
import 'package:flutter/material.dart';
// Ensure these imports point to your actual subject pages
import 'class910_physics.dart';
import 'class910_chemistry.dart';
import 'class910_biology.dart';
import 'class910_highermath.dart';

class Class910Page extends StatelessWidget {
  const Class910Page({super.key});

  // Updated list with only Physics, Chemistry, Biology, and Higher Math
  final List<Map<String, dynamic>> subjects = const [
    {
      'title': 'Physics',
      'icon': Icons.flash_on,
      'color': Colors.lightBlue,
      'page': PhysicsExperimentsPage(),
    },
    {
      'title': 'Chemistry',
      'icon': Icons.science,
      'color': Colors.green,
      'page': ChemistryExperimentsPage(),
    },
    {
      'title': 'Biology',
      'icon': Icons.spa,
      'color': Colors.orange,
      'page': BiologyExperimentsPage(),
    },
    {
      'title': 'Higher Math',
      'icon': Icons.functions,
      'color': Colors.deepPurple,
      'page': HigherMathExperimentsPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Class 9-10 Subjects',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // Adding a subtle gradient or elevation for flair
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4A148C), Color(0xFF880E4F)], // Deep Purple to Deep Pink
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two tiles per row
            crossAxisSpacing: 12.0, // Horizontal space between tiles
            mainAxisSpacing: 12.0, // Vertical space between rows
            childAspectRatio: 1.0, // Square tiles
          ),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return SubjectTile(
              title: subject['title'] as String,
              icon: subject['icon'] as IconData,
              color: subject['color'] as Color,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => subject['page'] as Widget,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// --- Custom Widget for the Subject Tiles (remains the same) ---

class SubjectTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const SubjectTile({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0, // Deeper shadow for visual pop
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        // Splash color from the tile's main color
        splashColor: color.withOpacity(0.3),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            // Light background for the card body
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15), // Light background for icon
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: color, // Subject-specific color
                ),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}