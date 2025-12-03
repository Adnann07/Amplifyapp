import 'package:flutter/material.dart';
import 'chemistry_quiz_page.dart';
import 'physics_quiz_page.dart';
import 'biology_quiz_page.dart';
import 'ict_quiz_page.dart'; // ✅ ICT পেজ ইমপোর্ট

class HSCExamPage extends StatelessWidget {
  const HSCExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HSC পরীক্ষা ২০২৬'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade50,
              Colors.white,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 20),
            const Text(
              'বিষয় নির্বাচন করুন',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 30),
            _buildSubjectCard(
              context,
              'রসায়ন (Chemistry)',
              'রসায়ন ১ম ও ২য় পত্র',
              Icons.science,
              Colors.blue,
              const ChemistryQuizPage(),
            ),
            const SizedBox(height: 16),
            _buildSubjectCard(
              context,
              'পদার্থবিজ্ঞান (Physics)',
              'পদার্থবিজ্ঞান ১ম ও ২য় পত্র',
              Icons.analytics,
              Colors.green,
              PhysicsQuizPage(),
            ),
            const SizedBox(height: 16),
            _buildSubjectCard(
              context,
              'ICT',
              ' ',
              Icons.computer,
              Colors.deepPurple,
              IctQuizPage(), // ✅ এখন ঠিকমতো কাজ করবে
            ),
            const SizedBox(height: 16),
            _buildSubjectCard(
              context,
              'জীববিজ্ঞান (Biology)',
              'জীববিজ্ঞান ১ম ও ২য় পত্র',
              Icons.biotech,
              Colors.teal,
              BiologyQuizPage(),
            ),
            const SizedBox(height: 16),
            _buildSubjectCard(
              context,
              'উচ্চতর গণিত (Higher Math)',
              'উচ্চতর গণিত ১ম ও ২য় পত্র',
              Icons.calculate,
              Colors.orange,
              null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectCard(
      BuildContext context,
      String title,
      String subtitle,
      IconData icon,
      Color color,
      Widget? page,
      ) {
    final bool isAvailable = page != null;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: isAvailable
            ? () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
            : () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Subscribe to unlock!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isAvailable
                  ? [color.withOpacity(0.7), color.withOpacity(0.9)]
                  : [Colors.grey.shade300, Colors.grey.shade400],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 40, color: Colors.white),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    if (!isAvailable)
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'Subscribe to unlock!',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                isAvailable ? Icons.arrow_forward_ios : Icons.lock_outline,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
