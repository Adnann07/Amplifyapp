import 'package:flutter/material.dart';
// Imports for Class 11-12 (HSC) Subject Pages
import 'hsc_physics.dart';
import 'hsc_chemistry.dart';
import 'hsc_math.dart';
import 'hsc_biology.dart';

class Class1011Page extends StatelessWidget {
  const Class1011Page({super.key});

  // Subject list mapped to HSC pages with consistent styling
  final List<Map<String, dynamic>> subjects = const [
    {
      'title': 'Physics',
      'icon': Icons.flash_on,
      'color': Colors.lightBlue,
      'page': HscPhysicsPage(),
    },
    {
      'title': 'Chemistry',
      'icon': Icons.science,
      'color': Colors.green,
      'page': HscChemistryPage(),
    },
    {
      'title': 'Biology',
      'icon': Icons.spa,
      'color': Colors.orange,
      'page': HscBiologyPage(),
    },
    {
      'title': 'Higher Math',
      'icon': Icons.functions,
      'color': Colors.deepPurple,
      'page': HscMathPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Class 10-11 Subjects',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // Matching the deep purple/pink gradient from the Class 9-10 page
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4A148C), Color(0xFF880E4F)],
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
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 1.0,
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

// --- Reused Custom Widget for Consistency ---

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
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        splashColor: color.withOpacity(0.3),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: color,
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
