import 'package:flutter/material.dart';
import 'dart:ui'; // For BackdropFilter
import 'magnet_lab_screen.dart';// Import your new lab screen
import 'pendulum_lab_screen.dart';
import 'logic_gate_lab_screen.dart';
import 'projectile_lab_screen.dart';
import 'math_animations_screen.dart';
import 'optics.dart';
import 'slit.dart';
import 'black.dart';
import 'krebs_cycle_lab_screen.dart';

class PracticalExamplesPage extends StatelessWidget {
  const PracticalExamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Practical Examples'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.blue.shade900.withOpacity(0.5)),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.purple.shade50],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
          children: [

            _buildExperimentCard(
              context,
              'Math Visualizations',
              'Pendulum, Fourier series & trig',
              Icons.functions,
              Colors.deepPurple,
              const MathAnimationsScreen(),
            ),



            _buildExperimentCard(
              context,
              'Projectile Cannon',
              'Explore Angle, Velocity & Range',
              Icons.sports_baseball, // Ball icon
              Colors.red,
              ProjectileLabScreen(),
            ),



            _buildExperimentCard(
              context,
              'Logic Gate Lab',
              'Interactive Digital Logic Circuits',
              Icons.memory,
              Colors.cyan,
              LogicGateLabScreen(),
            ),
            _buildExperimentCard(
              context,
              'Pendulum Experiment',
              'Calculate gravity (g) using phone sensors',
              Icons.waves,
              Colors.purple,
              PendulumLabScreen(),
            ),
            _buildExperimentCard(
              context,
              'Krebs Cycle Lab',
              'Interactive TCA cycle visualization',
              Icons.science,
              Colors.green,
              const KrebsCycleLabScreen(),
            ),

            _buildExperimentCard(
              context,
              'Geometric Optics Lab',
              'Explore lenses, rays & image formation',
              Icons.blur_circular, // Lens icon
              Colors.indigo,
              const GeometricOpticsLabScreen(),
            ),

            _buildExperimentCard(
              context,
              'Double Slit Wave Interference',
              'Light, slits & intensity patterns',
              Icons.waves,
              Colors.cyan,
              const WaveInterferenceLabScreen(),
            ),


            _buildExperimentCard(
              context,
              'Blackbody Spectrum',
              'Planck curve & temperature slider',
              Icons.auto_graph, // graph icon
              Colors.indigo,
              const BlackbodySpectrumLabScreen(),
            ),





            const SizedBox(height: 16),
            _buildExperimentCard(
              context,
              'Magnetic Field Mapper',
              'Visualize magnetic fields in 3D',
              Icons.explore, // Compass icon
              Colors.indigo,
              MagnetLabScreen(),
            ),




          ],
        ),
      ),
    );
  }

  Widget _buildExperimentCard(
      BuildContext context,
      String title,
      String subtitle,
      IconData icon,
      Color color,
      Widget? page,
      ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: page == null
            ? null
            : () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
