// hsc_physics_page.dart
// Interactive HSC Physics lab simulators - Modern Grid UI Design

import 'dart:math';
import 'package:flutter/material.dart';

class HscPhysicsPage extends StatefulWidget {
  const HscPhysicsPage({super.key});

  @override
  State<HscPhysicsPage> createState() => _HscPhysicsPageState();
}

class _HscPhysicsPageState extends State<HscPhysicsPage> {
  final List<_Experiment> experiments = [
    _Experiment('Spherometer', 'Radius of Curvature', Icons.circle, Colors.blue, _ExperimentType.spherometer),
    _Experiment('Mass-Spring', 'Oscillation System', Icons.sync_alt, Colors.orange, _ExperimentType.massSpring),
    _Experiment('Inclined Plane', 'Galileo\'s Experiment', Icons.terrain, Colors.green, _ExperimentType.inclinedPlane),
    _Experiment('Hooke\'s Law', 'Spring Energy', Icons.linear_scale, Colors.purple, _ExperimentType.hookeLaw),
    _Experiment('Ohm\'s Law', 'Electric Circuit', Icons.electrical_services, Colors.red, _ExperimentType.ohmsLaw),
    _Experiment('Diffraction', 'Double-Slit Pattern', Icons.waves, Colors.teal, _ExperimentType.diffraction),
    _Experiment('Young\'s Modulus', 'Vernier Caliper', Icons.architecture, Colors.indigo, _ExperimentType.youngsModulus),
    _Experiment('Wheatstone Bridge', 'Resistance Network', Icons.grid_on, Colors.brown, _ExperimentType.wheatstoneBridge),
    _Experiment('Photoelectric Effect', 'Light & Energy', Icons.flash_on, Colors.amber, _ExperimentType.photoelectric),
    _Experiment('Capacitor', 'Charge/Discharge', Icons.battery_charging_full, Colors.cyan, _ExperimentType.capacitor),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _select(_Experiment exp) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _ExperimentPanel(
          experiment: exp,
          onClose: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _closePanel() {
    // Not used anymore since we use Navigator
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[50]!,
              Colors.purple[50]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue[600],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.science, color: Colors.white, size: 32),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'HSC Physics Lab',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Interactive Virtual Experiments',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Select any experiment below to start learning',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Grid of experiments
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: experiments.length,
                  itemBuilder: (context, i) {
                    final e = experiments[i];
                    return _ExperimentCard(
                      experiment: e,
                      onTap: () => _select(e),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Experiment {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final _ExperimentType type;
  _Experiment(this.title, this.subtitle, this.icon, this.color, this.type);
}

enum _ExperimentType {
  spherometer, massSpring, inclinedPlane, hookeLaw, ohmsLaw,
  diffraction, youngsModulus, wheatstoneBridge, photoelectric, capacitor
}

/* ----------------------------- Experiment Card ---------------------------- */

class _ExperimentCard extends StatelessWidget {
  final _Experiment experiment;
  final VoidCallback onTap;

  const _ExperimentCard({required this.experiment, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                experiment.color.withOpacity(0.1),
                experiment.color.withOpacity(0.05),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: experiment.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: experiment.color.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(experiment.icon, size: 36, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  experiment.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* ---------------------------- Experiment Panel --------------------------- */

class _ExperimentPanel extends StatelessWidget {
  final _Experiment experiment;
  final VoidCallback onClose;
  const _ExperimentPanel({required this.experiment, required this.onClose});

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (experiment.type) {
      case _ExperimentType.spherometer:
        body = const SpherometerSimulator();
        break;
      case _ExperimentType.massSpring:
        body = const MassSpringSimulator();
        break;
      case _ExperimentType.inclinedPlane:
        body = const InclinedPlaneSimulator();
        break;
      case _ExperimentType.hookeLaw:
        body = const HookeLawSimulator();
        break;
      case _ExperimentType.ohmsLaw:
        body = const OhmsLawSimulator();
        break;
      case _ExperimentType.diffraction:
        body = const DiffractionSimulator();
        break;
      case _ExperimentType.youngsModulus:
        body = const YoungsModulusSimulator();
        break;
      case _ExperimentType.wheatstoneBridge:
        body = const WheatstoneBridgeSimulator();
        break;
      case _ExperimentType.photoelectric:
        body = const PhotoelectricSimulator();
        break;
      case _ExperimentType.capacitor:
        body = const CapacitorSimulator();
        break;
      default:
        body = _PlaceholderDetails(title: experiment.title);
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              experiment.color.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with back button
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: onClose,
                      icon: const Icon(Icons.arrow_back),
                      style: IconButton.styleFrom(
                        backgroundColor: experiment.color.withOpacity(0.1),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: experiment.color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(experiment.icon, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            experiment.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            experiment.subtitle,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Experiment content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: body,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceholderDetails extends StatelessWidget {
  final String title;
  const _PlaceholderDetails({required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.construction, color: Colors.orange[700]),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Coming Soon',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '$title — Lab Guide',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'This simulator is under development. Soon you\'ll be able to perform interactive experiments with:',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 16),
            _FeatureItem(icon: Icons.tune, text: 'Interactive parameter controls'),
            _FeatureItem(icon: Icons.animation, text: 'Real-time animated apparatus'),
            _FeatureItem(icon: Icons.calculate, text: 'Automatic calculations and error analysis'),
            _FeatureItem(icon: Icons.table_chart, text: 'Data tables and exportable results'),
            _FeatureItem(icon: Icons.quiz, text: 'Interactive quizzes and challenges'),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: Colors.blue[700]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

/* --------------------------- Spherometer Widget -------------------------- */

class SpherometerSimulator extends StatefulWidget {
  const SpherometerSimulator({super.key});

  @override
  State<SpherometerSimulator> createState() => _SpherometerSimulatorState();
}

class _SpherometerSimulatorState extends State<SpherometerSimulator> with SingleTickerProviderStateMixin {
  double sagitta = 1.2;
  double legDistance = 20;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double _radiusOfCurvature(double h, double a) {
    final safeH = max(1e-6, h);
    final a_eff = a / sqrt(3);
    final R = (a_eff * a_eff + safeH * safeH) / (2 * safeH);
    return R;
  }

  @override
  Widget build(BuildContext context) {
    final R = _radiusOfCurvature(sagitta, legDistance);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Simulation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final pulse = 0.5 + 0.5 * sin(_animationController.value * 2 * pi);
                  return CustomPaint(
                    painter: _SpherometerPainter(
                      sagitta: sagitta,
                      legDistance: legDistance,
                      pulseValue: pulse,
                    ),
                    child: Container(),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            _ControlSection(
              title: 'Sagitta (h)',
              value: sagitta,
              unit: 'mm',
              min: 0.2,
              max: 10,
              onChanged: (v) => setState(() => sagitta = v),
            ),
            const SizedBox(height: 16),
            _ControlSection(
              title: 'Leg Distance',
              value: legDistance,
              unit: 'mm',
              min: 10,
              max: 60,
              onChanged: (v) => setState(() => legDistance = v),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Results',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Radius of Curvature: ${R.toStringAsFixed(2)} mm',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  const Text('Formula: R = (a² + h²) / (2h)'),
                  const Text('where a = distance from center to leg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ControlSection extends StatelessWidget {
  final String title;
  final double value;
  final String unit;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const _ControlSection({
    required this.title,
    required this.value,
    required this.unit,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              Text(
                '${value.toStringAsFixed(2)} $unit',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
            activeColor: Colors.blue[700],
          ),
        ],
      ),
    );
  }
}

class _SpherometerPainter extends CustomPainter {
  final double sagitta;
  final double legDistance;
  final double pulseValue;

  _SpherometerPainter({
    required this.sagitta,
    required this.legDistance,
    required this.pulseValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final fill = Paint()..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2 + 20;

    final scale = size.width / 150;
    final safeSag = max(0.001, sagitta);
    final h = safeSag * scale;
    final a = legDistance * scale / sqrt(3);

    final R = (a * a + h * h) / (2 * h);
    final center = Offset(cx, cy + (R - h));

    final drawR = R.clamp(4.0, size.width * 2);

    // Draw curved surface with gradient effect
    for (double r = drawR; r > drawR - 10; r -= 2) {
      final alpha = ((r - (drawR - 10)) / 10 * 50).toInt();
      canvas.drawCircle(
        center,
        r,
        stroke..color = Colors.blueAccent.withAlpha(alpha),
      );
    }

    // Draw sagitta measurement with pulsing effect
    final top = Offset(cx, cy - h);
    final bottom = Offset(cx, cy);
    canvas.drawLine(
      top,
      bottom,
      stroke
        ..color = Colors.red
        ..strokeWidth = 3 + pulseValue * 2,
    );

    // Draw legs with 3D effect
    final legPaint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.fill;
    final highlightPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 3; i++) {
      final angle = i * 2 * pi / 3 - pi / 2;
      final lx = cx + cos(angle) * a;
      final ly = cy + sin(angle) * a;

      // Leg base
      canvas.drawCircle(Offset(lx, ly), 8, legPaint);
      // Leg highlight
      canvas.drawCircle(Offset(lx - 2, ly - 2), 3, highlightPaint);
    }

    // Animated measurement text
    final txt = TextPainter(
      text: TextSpan(
        text: 'h = ${sagitta.toStringAsFixed(1)}mm',
        style: TextStyle(
          color: Colors.red[700],
          fontSize: 16,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              blurRadius: pulseValue * 4,
              color: Colors.red.withOpacity(0.5),
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    txt.layout();
    txt.paint(canvas, Offset(cx + 12, cy - h / 2 - 12));
  }

  @override
  bool shouldRepaint(covariant _SpherometerPainter old) =>
      old.sagitta != sagitta || old.legDistance != legDistance || old.pulseValue != pulseValue;
}

/* ------------------------- Mass-Spring Simulator ------------------------- */

class MassSpringSimulator extends StatefulWidget {
  const MassSpringSimulator({super.key});

  @override
  State<MassSpringSimulator> createState() => _MassSpringSimulatorState();
}

class _MassSpringSimulatorState extends State<MassSpringSimulator> with SingleTickerProviderStateMixin {
  double mass = 1.0;
  double k = 20.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get period {
    final safeK = max(1e-6, k);
    final safeM = max(1e-6, mass);
    return 2 * pi * sqrt(safeM / safeK);
  }

  double get omega {
    final safeK = max(1e-6, k);
    final safeM = max(1e-6, mass);
    return sqrt(safeK / safeM);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Simulation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, __) {
                  final simTime = _controller.value * period;
                  final displacement = 0.6 * sin(omega * simTime);
                  final springCompression = 0.3 * (1.0 + sin(omega * simTime + pi/2));
                  return CustomPaint(
                    painter: _MassSpringPainter(
                      displacement: displacement,
                      springCompression: springCompression,
                      animationValue: _controller.value,
                    ),
                    child: Container(),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            _ControlSection(
              title: 'Mass',
              value: mass,
              unit: 'kg',
              min: 0.2,
              max: 5,
              onChanged: (v) => setState(() => mass = v),
            ),
            const SizedBox(height: 16),
            _ControlSection(
              title: 'Spring Constant (k)',
              value: k,
              unit: 'N/m',
              min: 5,
              max: 200,
              onChanged: (v) => setState(() => k = v),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Results',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Period: ${period.toStringAsFixed(2)} s',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Frequency: ${(1/period).toStringAsFixed(2)} Hz',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  const Text('Formula: T = 2π √(m/k)'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _controller.repeat(reverse: true),
                icon: const Icon(Icons.replay),
                label: const Text('Restart Animation'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MassSpringPainter extends CustomPainter {
  final double displacement;
  final double springCompression;
  final double animationValue;

  _MassSpringPainter({
    required this.displacement,
    required this.springCompression,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height / 2;
    final leftX = 20.0;

    // Draw wall with 3D effect
    final wallPaint = Paint()..color = Colors.grey[800]!;
    final wallShadow = Paint()..color = Colors.grey[600]!;
    canvas.drawRect(Rect.fromLTWH(0, centerY - 40, 16, 80), wallShadow);
    canvas.drawRect(Rect.fromLTWH(4, centerY - 36, 12, 72), wallPaint);

    final massX = leftX + 80 + (displacement.clamp(-1.0, 1.0) * 40);

    // Draw spring with realistic compression
    final path = Path();
    path.moveTo(leftX + 16, centerY);
    final segments = 12;
    final springLength = massX - leftX - 16;
    for (int i = 0; i <= segments; i++) {
      final t = i / segments;
      final x = leftX + 16 + t * springLength;
      final amplitude = 15.0 * (1.0 - t * 0.3); // Decreasing amplitude
      final y = centerY + (i.isOdd ? -amplitude : amplitude) * springCompression;
      path.lineTo(x, y);
    }

    final springPaint = Paint()
      ..color = Colors.blueGrey[700]!
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, springPaint);

    // Draw mass with shadow and highlight
    final massRect = Rect.fromCenter(center: Offset(massX + 28, centerY), width: 56, height: 56);

    // Shadow
    canvas.drawRect(
      massRect.translate(4, 4),
      Paint()..color = Colors.black.withOpacity(0.3),
    );

    // Main mass
    final gradient = RadialGradient(
      center: Alignment.topLeft,
      colors: [
        Colors.orangeAccent,
        Colors.orange[800]!,
      ],
    );
    canvas.drawRect(
      massRect,
      Paint()..shader = gradient.createShader(massRect),
    );

    // Highlight
    canvas.drawRect(
      Rect.fromLTWH(massRect.left + 8, massRect.top + 8, 20, 20),
      Paint()..color = Colors.white.withOpacity(0.3),
    );

    // Mass label with pulsing effect
    final tp = TextPainter(
      text: TextSpan(
        text: 'm',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              blurRadius: animationValue * 8,
              color: Colors.orange.withOpacity(0.5),
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(massRect.center.dx - tp.width / 2, massRect.center.dy - tp.height / 2));

    // Draw equilibrium line
    final eqPaint = Paint()
      ..color = Colors.green.withOpacity(0.5)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(leftX + 16, centerY),
      Offset(size.width, centerY),
      eqPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _MassSpringPainter old) =>
      old.displacement != displacement ||
          old.springCompression != springCompression ||
          old.animationValue != animationValue;
}

/* ------------------------- Inclined Plane Simulator ---------------------- */

class InclinedPlaneSimulator extends StatefulWidget {
  const InclinedPlaneSimulator({super.key});

  @override
  State<InclinedPlaneSimulator> createState() => _InclinedPlaneSimulatorState();
}

class _InclinedPlaneSimulatorState extends State<InclinedPlaneSimulator> with SingleTickerProviderStateMixin {
  double angle = 15;
  double friction = 0.1;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Simulation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, __) {
                  final t = (_controller.value * 4.0);
                  final x = (t % 1.0);
                  final bounce = sin(t * 2 * pi) * 0.1;
                  return CustomPaint(
                    painter: _InclinedPlanePainter(
                      angle: angle,
                      progress: x,
                      bounce: bounce,
                      animationValue: _controller.value,
                    ),
                    child: Container(),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            _ControlSection(
              title: 'Angle',
              value: angle,
              unit: '°',
              min: 0,
              max: 45,
              onChanged: (v) => setState(() => angle = v),
            ),
            const SizedBox(height: 16),
            _ControlSection(
              title: 'Friction',
              value: friction,
              unit: 'μ',
              min: 0,
              max: 0.5,
              onChanged: (v) => setState(() => friction = v),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Physics Concept',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Acceleration: a = g(sinθ - μcosθ) = ${(9.8 * (sin(angle * pi/180) - friction * cos(angle * pi/180))).toStringAsFixed(2)} m/s²'),
                  const Text('Distance: s = ½at² (from rest)'),
                  const SizedBox(height: 8),
                  const Text('Change the angle and friction to see how they affect motion down the plane.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InclinedPlanePainter extends CustomPainter {
  final double angle;
  final double progress;
  final double bounce;
  final double animationValue;

  _InclinedPlanePainter({
    required this.angle,
    required this.progress,
    required this.bounce,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.brown[700]!..strokeWidth = 4;
    final fillPaint = Paint()..style = PaintingStyle.fill;

    final padding = 24.0;
    final start = Offset(padding, size.height - padding);
    final radians = angle * pi / 180;
    final length = max(100.0, size.width - padding * 2);
    final end = Offset(start.dx + cos(radians) * length, start.dy - sin(radians) * length);

    // Draw inclined plane with texture
    final planePath = Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(end.dx, end.dy)
      ..lineTo(end.dx, size.height)
      ..lineTo(start.dx, size.height)
      ..close();

    final planeGradient = LinearGradient(
      colors: [Colors.brown[600]!, Colors.brown[800]!],
    ).createShader(Rect.fromPoints(start, end));

    canvas.drawPath(planePath, fillPaint..shader = planeGradient);

    // Draw texture lines
    final texturePaint = Paint()
      ..color = Colors.brown[900]!
      ..strokeWidth = 1;
    for (int i = 0; i < 8; i++) {
      final t = i / 7;
      final point = Offset(
        start.dx + t * (end.dx - start.dx),
        start.dy + t * (end.dy - start.dy),
      );
      canvas.drawLine(
        point,
        Offset(point.dx, size.height),
        texturePaint,
      );
    }

    final t = progress.clamp(0.0, 1.0);
    final blockPos = Offset(
      _lerpDouble(start.dx, end.dx, t),
      _lerpDouble(start.dy, end.dy, t) + bounce * 10,
    );

    // Draw block with 3D effect
    final blockRect = Rect.fromCenter(center: blockPos.translate(0, -12), width: 40, height: 24);

    // Shadow
    canvas.drawRect(
      blockRect.translate(4, 4),
      fillPaint..color = Colors.black.withOpacity(0.3),
    );

    // Main block
    final blockGradient = LinearGradient(
      colors: [Colors.blueAccent, Colors.blue[800]!],
    ).createShader(blockRect);
    canvas.drawRect(blockRect, fillPaint..shader = blockGradient);

    // Highlight
    canvas.drawRect(
      Rect.fromLTWH(blockRect.left + 4, blockRect.top + 4, 12, 8),
      fillPaint..color = Colors.white.withOpacity(0.3),
    );

    // Draw angle measurement with animation
    final anglePaint = Paint()
      ..color = Colors.blue[800]!
      ..strokeWidth = 2;
    canvas.drawArc(
      Rect.fromCircle(center: start, radius: 40),
      -pi / 2,
      -radians,
      false,
      anglePaint,
    );

    // Animated angle text
    final tp = TextPainter(
      text: TextSpan(
        text: '${angle.toStringAsFixed(0)}°',
        style: TextStyle(
          fontSize: 14,
          color: Colors.blue[800],
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              blurRadius: animationValue * 4,
              color: Colors.blue.withOpacity(0.5),
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(start.dx + 20, start.dy - 40));
  }

  @override
  bool shouldRepaint(covariant _InclinedPlanePainter old) =>
      old.angle != angle ||
          old.progress != progress ||
          old.bounce != bounce ||
          old.animationValue != animationValue;
}

/* --------------------------- Hooke's Law -------------------------------- */

class HookeLawSimulator extends StatefulWidget {
  const HookeLawSimulator({super.key});

  @override
  State<HookeLawSimulator> createState() => _HookeLawSimulatorState();
}

class _HookeLawSimulatorState extends State<HookeLawSimulator> with SingleTickerProviderStateMixin {
  double force = 5.0;
  double k = 10.0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final safeK = max(1e-6, k);
    final extension = force / safeK;
    final potential = 0.5 * safeK * extension * extension;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Simulation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final pulse = 0.5 + 0.5 * sin(_animationController.value * 2 * pi);
                  return CustomPaint(
                    painter: _SpringPainter(
                      extension: extension,
                      pulseValue: pulse,
                    ),
                    child: Container(),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            _ControlSection(
              title: 'Applied Force',
              value: force,
              unit: 'N',
              min: 0,
              max: 50,
              onChanged: (v) => setState(() => force = v),
            ),
            const SizedBox(height: 16),
            _ControlSection(
              title: 'Spring Constant (k)',
              value: k,
              unit: 'N/m',
              min: 1,
              max: 200,
              onChanged: (v) => setState(() => k = v),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Results',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Extension: ${extension.toStringAsFixed(3)} m',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Potential Energy: ${potential.toStringAsFixed(3)} J',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  const Text('Formula: F = kx (Hooke\'s Law)'),
                  const Text('Energy: U = ½kx²'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpringPainter extends CustomPainter {
  final double extension;
  final double pulseValue;

  _SpringPainter({required this.extension, required this.pulseValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.green[700]!..strokeWidth = 3;
    final highlightPaint = Paint()..color = Colors.white..strokeWidth = 1;

    final start = Offset(40, size.height / 2 - 60);
    final baseLength = 120.0;
    final extPixels = (extension * 100) * 0.8;
    final end = Offset(start.dx + baseLength + extPixels, start.dy);

    // Draw spring with realistic coils
    final path = Path();
    path.moveTo(start.dx, start.dy);
    final coils = 14;
    final totalLength = end.dx - start.dx;
    for (int i = 0; i <= coils; i++) {
      final t = i / coils;
      final x = start.dx + t * totalLength;
      final amplitude = 18.0 * (1.0 - t * 0.3); // Decreasing amplitude
      final y = start.dy + sin(t * pi * coils) * amplitude;
      path.lineTo(x, y);
    }
    canvas.drawPath(path, paint);

    // Spring highlight
    canvas.drawPath(path, highlightPaint);

    // Draw mass with energy glow
    final massRect = Rect.fromCenter(center: end.translate(18, 0), width: 56, height: 56);

    // Energy glow effect
    final energyGlow = Paint()
      ..color = Colors.yellow.withOpacity(pulseValue * 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(massRect.center, 35, energyGlow);

    // Mass shadow
    canvas.drawRect(
      massRect.translate(4, 4),
      Paint()..color = Colors.black.withOpacity(0.3),
    );

    // Main mass
    final massGradient = RadialGradient(
      center: Alignment.center,
      colors: [
        Colors.redAccent,
        Colors.red[800]!,
      ],
    );
    canvas.drawRect(massRect, Paint()..shader = massGradient.createShader(massRect));

    // Force arrow
    final arrowPaint = Paint()
      ..color = Colors.blue[800]!
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final arrowStart = Offset(massRect.right + 10, massRect.center.dy);
    final arrowEnd = Offset(massRect.right + 50, massRect.center.dy);
    canvas.drawLine(arrowStart, arrowEnd, arrowPaint);

    // Arrow head
    final arrowPath = Path();
    arrowPath.moveTo(arrowEnd.dx, arrowEnd.dy);
    arrowPath.lineTo(arrowEnd.dx - 10, arrowEnd.dy - 5);
    arrowPath.lineTo(arrowEnd.dx - 10, arrowEnd.dy + 5);
    arrowPath.close();
    canvas.drawPath(arrowPath, Paint()..color = Colors.blue[800]!);

    // Force label
    final forceText = TextPainter(
      text: TextSpan(
        text: 'F',
        style: TextStyle(
          fontSize: 16,
          color: Colors.blue[800],
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    forceText.layout();
    forceText.paint(canvas, Offset(arrowEnd.dx + 5, arrowEnd.dy - 10));
  }

  @override
  bool shouldRepaint(covariant _SpringPainter old) =>
      old.extension != extension || old.pulseValue != pulseValue;
}

/* ---------------------------- Ohm's Law --------------------------------- */

class OhmsLawSimulator extends StatefulWidget {
  const OhmsLawSimulator({super.key});

  @override
  State<OhmsLawSimulator> createState() => _OhmsLawSimulatorState();
}

class _OhmsLawSimulatorState extends State<OhmsLawSimulator> with SingleTickerProviderStateMixin {
  double voltage = 5.0;
  double resistance = 10.0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double get current => voltage / max(0.001, resistance);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Simulation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final electronFlow = _animationController.value;
                  return CustomPaint(
                    painter: _CircuitPainter(
                      voltage: voltage,
                      resistance: resistance,
                      electronFlow: electronFlow,
                    ),
                    child: Container(),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            _ControlSection(
              title: 'Voltage',
              value: voltage,
              unit: 'V',
              min: 0,
              max: 24,
              onChanged: (v) => setState(() => voltage = v),
            ),
            const SizedBox(height: 16),
            _ControlSection(
              title: 'Resistance',
              value: resistance,
              unit: 'Ω',
              min: 0.5,
              max: 50,
              onChanged: (v) => setState(() => resistance = v),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Results',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Current: ${current.toStringAsFixed(3)} A',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Power: ${(voltage * current).toStringAsFixed(2)} W',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  const Text('Formula: I = V/R (Ohm\'s Law)'),
                  const Text('Watch the bulb brightness change!'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircuitPainter extends CustomPainter {
  final double voltage;
  final double resistance;
  final double electronFlow;

  _CircuitPainter({
    required this.voltage,
    required this.resistance,
    required this.electronFlow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final wirePaint = Paint()..color = Colors.grey[700]!..strokeWidth = 3;
    final center = Offset(size.width / 2, size.height / 2);

    final left = Offset(40, center.dy);
    final right = Offset(size.width - 40, center.dy);

    // Draw main circuit wires
    canvas.drawLine(left, right, wirePaint);

    // Draw battery with animation
    final batRect = Rect.fromCenter(center: Offset(80, center.dy), width: 24, height: 48);
    final batGradient = LinearGradient(
      colors: [Colors.red, Colors.orange],
    ).createShader(batRect);
    canvas.drawRect(batRect, Paint()..shader = batGradient);

    // Battery terminals
    canvas.drawRect(
      Rect.fromCenter(center: Offset(80, center.dy - 30), width: 8, height: 4),
      Paint()..color = Colors.grey[800]!,
    );
    canvas.drawRect(
      Rect.fromCenter(center: Offset(80, center.dy + 30), width: 8, height: 4),
      Paint()..color = Colors.grey[800]!,
    );

    // Draw bulb with dynamic brightness
    final bulbCenter = Offset(size.width - 100, center.dy);
    final brightness = (voltage / max(1.0, resistance)).clamp(0.0, 2.0) / 2.0;

    // Bulb glow effect
    final glowPaint = Paint()
      ..color = Colors.yellow.withOpacity(brightness * 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
    canvas.drawCircle(bulbCenter, 40, glowPaint);

    // Bulb filament
    final filamentPaint = Paint()
      ..color = Colors.orange.withOpacity(0.8 + brightness * 0.2)
      ..strokeWidth = 3;
    canvas.drawLine(
      Offset(bulbCenter.dx - 15, bulbCenter.dy),
      Offset(bulbCenter.dx + 15, bulbCenter.dy),
      filamentPaint,
    );

    // Bulb glass
    final bulbPaint = Paint()
      ..color = Colors.grey[300]!.withOpacity(0.7)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(bulbCenter, 28, bulbPaint);
    canvas.drawCircle(bulbCenter, 28, Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 2);

    // Draw resistor with zigzag pattern
    final path = Path();
    final startX = 120.0;
    final endX = size.width - 140;
    path.moveTo(startX, center.dy - 40);
    final zigzags = 6;
    for (int i = 0; i <= zigzags; i++) {
      final t = i / zigzags;
      final x = _lerpDouble(startX, endX, t);
      final y = center.dy - 40 + (i.isOdd ? 16 : -16);
      path.lineTo(x, y);
    }
    canvas.drawPath(path, wirePaint..strokeWidth = 2);

    // Draw moving electrons
    final electronPaint = Paint()..color = Colors.blue;
    final totalLength = size.width - 80;
    for (int i = 0; i < 5; i++) {
      final electronPos = (electronFlow + i * 0.2) % 1.0;
      final x = 40 + electronPos * totalLength;
      canvas.drawCircle(Offset(x, center.dy), 4, electronPaint);
    }

    // Draw current direction arrows
    final arrowPaint = Paint()
      ..color = Colors.blue[800]!
      ..strokeWidth = 2;
    for (int i = 0; i < 3; i++) {
      final t = 0.2 + i * 0.3;
      final x = 40 + t * totalLength;
      canvas.drawLine(
        Offset(x, center.dy - 10),
        Offset(x + 8, center.dy - 10),
        arrowPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CircuitPainter old) =>
      old.voltage != voltage || old.resistance != resistance || old.electronFlow != electronFlow;
}

/* --------------------------- Diffraction -------------------------------- */

class DiffractionSimulator extends StatefulWidget {
  const DiffractionSimulator({super.key});

  @override
  State<DiffractionSimulator> createState() => _DiffractionSimulatorState();
}

class _DiffractionSimulatorState extends State<DiffractionSimulator> with SingleTickerProviderStateMixin {
  double slitWidth = 0.1;
  double wavelength = 0.65;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Simulation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final wavePhase = _animationController.value * 2 * pi;
                  return CustomPaint(
                    painter: _DiffractionPainter(
                      slitWidth: slitWidth,
                      wavelength: wavelength,
                      wavePhase: wavePhase,
                    ),
                    child: Container(),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            _ControlSection(
              title: 'Slit Width',
              value: slitWidth,
              unit: 'mm',
              min: 0.02,
              max: 1.0,
              onChanged: (v) => setState(() => slitWidth = v),
            ),
            const SizedBox(height: 16),
            _ControlSection(
              title: 'Wavelength',
              value: wavelength,
              unit: 'μm',
              min: 0.3,
              max: 1.0,
              onChanged: (v) => setState(() => wavelength = v),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Physics Concept',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Angular width: θ ≈ λ/a = ${(wavelength / slitWidth).toStringAsFixed(2)} rad'),
                  const Text('Single Slit Diffraction Pattern'),
                  const SizedBox(height: 8),
                  const Text('Observe how changing the slit width and wavelength affects the fringe pattern.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiffractionPainter extends CustomPainter {
  final double slitWidth;
  final double wavelength;
  final double wavePhase;

  _DiffractionPainter({
    required this.slitWidth,
    required this.wavelength,
    required this.wavePhase,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 2;
    final centerY = size.height / 2;

    // Draw incident waves
    final wavePaint = Paint()
      ..color = Colors.blue.withOpacity(0.6)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (int y = 0; y < 5; y++) {
      final path = Path();
      final baseY = centerY - 40 + y * 20;
      for (double x = 20; x < 80; x += 2) {
        final wave = sin((x / 10) + wavePhase) * 8;
        if (x == 20) {
          path.moveTo(x, baseY + wave);
        } else {
          path.lineTo(x, baseY + wave);
        }
      }
      canvas.drawPath(path, wavePaint);
    }

    // Draw slit
    final slitHeight = slitWidth * 100;
    final slitRect = Rect.fromCenter(
      center: Offset(100, centerY),
      width: 4,
      height: slitHeight,
    );
    canvas.drawRect(slitRect, Paint()..color = Colors.black);

    // Draw diffraction pattern
    final samples = size.width.toInt().clamp(100, 2000);
    final patternStartX = 120.0;

    final lambdaMm = max(1e-6, wavelength) * 0.001;
    final k = 2 * pi / max(1e-6, lambdaMm);

    for (int x = (patternStartX * samples / size.width).toInt(); x < samples; x++) {
      final screenX = x.toDouble() * (size.width / samples);
      final u = (screenX - patternStartX - (size.width - patternStartX) / 2) / (size.width - patternStartX) * 2;

      final arg = k * slitWidth * u * 0.5;
      double amp;
      if (arg.abs() < 1e-6) {
        amp = 1.0;
      } else {
        amp = (sin(arg) / arg).abs();
      }
      final intensity = (amp * amp).clamp(0.0, 1.0);

      // Add wave effect to the pattern
      final waveEffect = sin(screenX / 20 + wavePhase) * 5 * intensity;
      final patternY = centerY - intensity * (centerY - 40) + waveEffect;

      final pointPaint = Paint()
        ..color = Color.lerp(Colors.black, Colors.purple, intensity)!
        ..strokeWidth = 2;

      canvas.drawCircle(Offset(screenX, patternY), 1 + intensity * 3, pointPaint);
    }

    // Draw screen
    final screenPaint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(patternStartX, 20),
      Offset(patternStartX, size.height - 20),
      screenPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _DiffractionPainter old) =>
      old.slitWidth != slitWidth ||
          old.wavelength != wavelength ||
          old.wavePhase != wavePhase;
}

/* ------------------------- Young's Modulus Simulator -------------------- */

class YoungsModulusSimulator extends StatefulWidget {
  const YoungsModulusSimulator({super.key});

  @override
  State<YoungsModulusSimulator> createState() => _YoungsModulusSimulatorState();
}

class _YoungsModulusSimulatorState extends State<YoungsModulusSimulator> with SingleTickerProviderStateMixin {
  double load = 5.0;
  double length = 2.0;
  double diameter = 0.01;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double get extension {
    final area = pi * pow(diameter / 2, 2);
    final stress = load / area;
    final strain = stress / 2e11; // Approximate Young's modulus for steel
    return strain * length;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Simulation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final stressEffect = _animationController.value * 0.2;
                  return CustomPaint(
                    painter: _YoungsModulusPainter(
                      load: load,
                      length: length,
                      diameter: diameter,
                      extension: extension,
                      stressEffect: stressEffect,
                    ),
                    child: Container(),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            _ControlSection(
              title: 'Load',
              value: load,
              unit: 'N',
              min: 1,
              max: 20,
              onChanged: (v) => setState(() => load = v),
            ),
            const SizedBox(height: 16),
            _ControlSection(
              title: 'Length',
              value: length,
              unit: 'm',
              min: 1,
              max: 5,
              onChanged: (v) => setState(() => length = v),
            ),
            const SizedBox(height: 16),
            _ControlSection(
              title: 'Diameter',
              value: diameter,
              unit: 'm',
              min: 0.005,
              max: 0.02,
              onChanged: (v) => setState(() => diameter = v),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Results',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Extension: ${(extension * 1000).toStringAsFixed(3)} mm',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Stress: ${(load / (pi * pow(diameter/2, 2))).toStringAsFixed(0)} Pa',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  const Text('Formula: Y = Stress / Strain'),
                  const Text('Stress = F/A, Strain = ΔL/L'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _YoungsModulusPainter extends CustomPainter {
  final double load;
  final double length;
  final double diameter;
  final double extension;
  final double stressEffect;

  _YoungsModulusPainter({
    required this.load,
    required this.length,
    required this.diameter,
    required this.extension,
    required this.stressEffect,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 2;
    final centerX = size.width / 2;

    // Draw support
    final supportPaint = Paint()..color = Colors.grey[800]!;
    canvas.drawRect(Rect.fromLTWH(centerX - 40, 20, 80, 10), supportPaint);

    // Draw wire with extension effect
    final wireLength = length * 40;
    final wireExtension = extension * 1000;
    final totalLength = wireLength + wireExtension;

    final wirePaint = Paint()
      ..color = Colors.blue[800]!
      ..strokeWidth = diameter * 500;

    canvas.drawLine(
      Offset(centerX, 30),
      Offset(centerX, 30 + totalLength),
      wirePaint,
    );

    // Draw stress effect (color change under load)
    final stressColor = Color.lerp(
      Colors.blue[800]!,
      Colors.red,
      stressEffect,
    )!;

    final stressedPaint = Paint()
      ..color = stressColor
      ..strokeWidth = diameter * 500;

    // Highlight stressed portion
    canvas.drawLine(
      Offset(centerX, 30 + wireLength * 0.7),
      Offset(centerX, 30 + totalLength),
      stressedPaint,
    );

    // Draw load
    final loadMass = Rect.fromCenter(
      center: Offset(centerX, 30 + totalLength + 25),
      width: 60,
      height: 40,
    );

    final loadGradient = RadialGradient(
      center: Alignment.center,
      colors: [Colors.orangeAccent, Colors.orange[800]!],
    );
    canvas.drawRect(loadMass, Paint()..shader = loadGradient.createShader(loadMass));

    // Load label
    final loadText = TextPainter(
      text: TextSpan(
        text: '${load.toStringAsFixed(1)}N',
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    loadText.layout();
    loadText.paint(canvas, Offset(centerX - loadText.width / 2, 30 + totalLength + 25 - loadText.height / 2));

    // Draw extension measurement
    final measurePaint = Paint()
      ..color = Colors.green[800]!
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(centerX + 40, 30 + wireLength),
      Offset(centerX + 40, 30 + totalLength),
      measurePaint,
    );

    // Extension arrows
    canvas.drawLine(
      Offset(centerX + 35, 30 + wireLength),
      Offset(centerX + 45, 30 + wireLength),
      measurePaint,
    );
    canvas.drawLine(
      Offset(centerX + 35, 30 + totalLength),
      Offset(centerX + 45, 30 + totalLength),
      measurePaint,
    );

    // Extension label
    final extensionText = TextPainter(
      text: TextSpan(
        text: 'ΔL = ${(extension * 1000).toStringAsFixed(2)}mm',
        style: TextStyle(
          fontSize: 12,
          color: Colors.green[800],
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    extensionText.layout();
    extensionText.paint(canvas, Offset(centerX + 50, 30 + wireLength + wireExtension / 2 - extensionText.height / 2));
  }

  @override
  bool shouldRepaint(covariant _YoungsModulusPainter old) =>
      old.load != load || old.length != length || old.diameter != diameter ||
          old.extension != extension || old.stressEffect != stressEffect;
}

/* ----------------------- Wheatstone Bridge Simulator -------------------- */

class WheatstoneBridgeSimulator extends StatefulWidget {
  const WheatstoneBridgeSimulator({super.key});

  @override
  State<WheatstoneBridgeSimulator> createState() => _WheatstoneBridgeSimulatorState();
}

class _WheatstoneBridgeSimulatorState extends State<WheatstoneBridgeSimulator> with SingleTickerProviderStateMixin {
  double r1 = 100;
  double r2 = 100;
  double r3 = 100;
  double r4 = 100;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool get isBalanced => (r1 * r4 - r2 * r3).abs() < 0.1;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Simulation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final currentFlow = _animationController.value;
                  return CustomPaint(
                    painter: _WheatstoneBridgePainter(
                      r1: r1,
                      r2: r2,
                      r3: r3,
                      r4: r4,
                      isBalanced: isBalanced,
                      currentFlow: currentFlow,
                    ),
                    child: Container(),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _ControlSection(
                    title: 'R1',
                    value: r1,
                    unit: 'Ω',
                    min: 10,
                    max: 1000,
                    onChanged: (v) => setState(() => r1 = v),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ControlSection(
                    title: 'R2',
                    value: r2,
                    unit: 'Ω',
                    min: 10,
                    max: 1000,
                    onChanged: (v) => setState(() => r2 = v),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _ControlSection(
                    title: 'R3',
                    value: r3,
                    unit: 'Ω',
                    min: 10,
                    max: 1000,
                    onChanged: (v) => setState(() => r3 = v),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ControlSection(
                    title: 'R4',
                    value: r4,
                    unit: 'Ω',
                    min: 10,
                    max: 1000,
                    onChanged: (v) => setState(() => r4 = v),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isBalanced ? Colors.green[50] : Colors.orange[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isBalanced ? 'Bridge Balanced! ✓' : 'Bridge Unbalanced',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isBalanced ? Colors.green[800] : Colors.orange[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Condition: R1/R2 = R3/R4',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Current: ${(r1 * r4 - r2 * r3).toStringAsFixed(1)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WheatstoneBridgePainter extends CustomPainter {
  final double r1;
  final double r2;
  final double r3;
  final double r4;
  final bool isBalanced;
  final double currentFlow;

  _WheatstoneBridgePainter({
    required this.r1,
    required this.r2,
    required this.r3,
    required this.r4,
    required this.isBalanced,
    required this.currentFlow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final wirePaint = Paint()
      ..color = Colors.grey[700]!
      ..strokeWidth = 3;

    final center = Offset(size.width / 2, size.height / 2);

    // Draw bridge circuit
    final points = [
      Offset(center.dx - 80, center.dy - 60), // Top left
      Offset(center.dx + 80, center.dy - 60), // Top right
      Offset(center.dx - 80, center.dy + 60), // Bottom left
      Offset(center.dx + 80, center.dy + 60), // Bottom right
    ];

    // Draw resistors
    _drawResistor(canvas, points[0], points[1], r1, 'R1');
    _drawResistor(canvas, points[2], points[3], r2, 'R2');
    _drawResistor(canvas, points[0], points[2], r3, 'R3');
    _drawResistor(canvas, points[1], points[3], r4, 'R4');

    // Draw galvanometer
    final galvStart = Offset(center.dx - 40, center.dy - 10);
    final galvEnd = Offset(center.dx + 40, center.dy + 10);

    // Galvanometer body
    canvas.drawCircle(center, 20, Paint()..color = Colors.blue[100]!);
    canvas.drawCircle(center, 20, Paint()..color = Colors.blue[800]!..style = PaintingStyle.stroke..strokeWidth = 2);

    // Galvanometer needle
    final needleAngle = (r1 * r4 - r2 * r3) / 10000 * pi / 4;
    final needlePaint = Paint()
      ..color = isBalanced ? Colors.green : Colors.red
      ..strokeWidth = 3;

    canvas.drawLine(
      center,
      Offset(
        center.dx + cos(needleAngle) * 15,
        center.dy + sin(needleAngle) * 15,
      ),
      needlePaint,
    );

    // Draw current flow animation
    if (!isBalanced) {
      final electronPaint = Paint()..color = Colors.blue;
      final flowPath = Path()
        ..moveTo(points[0].dx, points[0].dy)
        ..lineTo(center.dx, center.dy)
        ..lineTo(points[3].dx, points[3].dy);

      final pathMetrics = flowPath.computeMetrics();
      for (final pathMetric in pathMetrics) {
        final totalLength = pathMetric.length;
        final electronPos = (currentFlow * totalLength) % totalLength;
        final tangent = pathMetric.getTangentForOffset(electronPos);
        if (tangent != null) {
          canvas.drawCircle(tangent.position, 4, electronPaint);
        }
      }
    }

    // Draw battery
    final batRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy - 80),
      width: 20,
      height: 40,
    );
    canvas.drawRect(batRect, Paint()..color = Colors.red);
    canvas.drawRect(
      Rect.fromCenter(center: Offset(center.dx, center.dy - 95), width: 8, height: 10),
      Paint()..color = Colors.grey[800]!,
    );
  }

  void _drawResistor(Canvas canvas, Offset start, Offset end, double resistance, String label) {
    final basePaint = Paint()
      ..color = Colors.brown[700]!
      ..strokeWidth = 4;

    final path = Path();
    path.moveTo(start.dx, start.dy);

    final length = (end - start).distance;
    final direction = (end - start) / length;
    final normal = Offset(-direction.dy, direction.dx);

    final segments = 6;
    for (int i = 0; i <= segments; i++) {
      final t = i / segments;
      final point = start + direction * t * length;
      final offset = normal * (i.isOdd ? 8 : -8) * (resistance / 500).clamp(0.5, 2.0);
      path.lineTo(point.dx + offset.dx, point.dy + offset.dy);
    }

    canvas.drawPath(path, basePaint);

    // Resistance label
    final text = TextPainter(
      text: TextSpan(
        text: '$label\n${resistance.toStringAsFixed(0)}Ω',
        style: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    text.layout();
    final labelPos = start + (end - start) * 0.5 + normal * 15;
    text.paint(canvas, Offset(labelPos.dx - text.width / 2, labelPos.dy - text.height / 2));
  }

  @override
  bool shouldRepaint(covariant _WheatstoneBridgePainter old) =>
      old.r1 != r1 || old.r2 != r2 || old.r3 != r3 || old.r4 != r4 ||
          old.isBalanced != isBalanced || old.currentFlow != currentFlow;
}

/* --------------------- Photoelectric Effect Simulator ------------------- */

class PhotoelectricSimulator extends StatefulWidget {
  const PhotoelectricSimulator({super.key});

  @override
  State<PhotoelectricSimulator> createState() => _PhotoelectricSimulatorState();
}

class _PhotoelectricSimulatorState extends State<PhotoelectricSimulator> with SingleTickerProviderStateMixin {
  double wavelength = 400;
  double intensity = 50;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double get photonEnergy => 1240 / wavelength; // in eV
  bool get canEmitElectron => photonEnergy > 2.1; // Work function approximation

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Simulation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final photonPhase = _animationController.value;
                  return CustomPaint(
                    painter: _PhotoelectricPainter(
                      wavelength: wavelength,
                      intensity: intensity,
                      canEmitElectron: canEmitElectron,
                      photonPhase: photonPhase,
                    ),
                    child: Container(),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            _ControlSection(
              title: 'Wavelength',
              value: wavelength,
              unit: 'nm',
              min: 200,
              max: 700,
              onChanged: (v) => setState(() => wavelength = v),
            ),
            const SizedBox(height: 16),
            _ControlSection(
              title: 'Intensity',
              value: intensity,
              unit: '%',
              min: 10,
              max: 100,
              onChanged: (v) => setState(() => intensity = v),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: canEmitElectron ? Colors.amber[50] : Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    canEmitElectron ? 'Electrons Emitted! ✓' : 'No Electron Emission',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: canEmitElectron ? Colors.amber[800] : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Photon Energy: ${photonEnergy.toStringAsFixed(2)} eV',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Work Function: 2.10 eV',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text('Photoelectric Effect: E = hc/λ'),
                  const Text('Electrons emitted only if E > work function'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotoelectricPainter extends CustomPainter {
  final double wavelength;
  final double intensity;
  final bool canEmitElectron;
  final double photonPhase;

  _PhotoelectricPainter({
    required this.wavelength,
    required this.intensity,
    required this.canEmitElectron,
    required this.photonPhase,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;

    // Draw metal surface
    final metalPaint = Paint()
      ..color = Colors.grey[700]!
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(50, size.height / 2, size.width - 100, 20), metalPaint);

    // Draw incident photons
    final photonColor = Color.lerp(
      Colors.red,
      Colors.purple,
      (wavelength - 200) / 500,
    )!;

    final photonPaint = Paint()
      ..color = photonColor.withOpacity(intensity / 100)
      ..strokeWidth = 2;

    final photonCount = (intensity / 20).round();
    for (int i = 0; i < photonCount; i++) {
      final x = 60 + i * 30;
      final waveOffset = sin(photonPhase * 2 * pi + i * 0.5) * 10;
      final photonPath = Path();
      photonPath.moveTo(x.toDouble(), 50 + waveOffset); // Added .toDouble()
      photonPath.lineTo(x.toDouble(), size.height / 2); // Added .toDouble()

      // Draw wave-like photon
      for (double y = 50 + waveOffset; y < size.height / 2; y += 5) {
        final wave = sin((y - 50) / 10 + photonPhase * 2 * pi) * 3;
        if (y == 50 + waveOffset) {
          photonPath.moveTo(x + wave, y);
        } else {
          photonPath.lineTo(x + wave, y);
        }
      }

      canvas.drawPath(photonPath, photonPaint);
    }

    // Draw emitted electrons
    if (canEmitElectron) {
      final electronPaint = Paint()..color = Colors.yellow;
      final electronCount = (intensity / 25).round();

      for (int i = 0; i < electronCount; i++) {
        final startX = 80 + i * 40;
        final electronY = size.height / 2 - 20 - photonPhase * 50;
        final electronX = startX + sin(photonPhase * 2 * pi + i) * 15;

        canvas.drawCircle(Offset(electronX, electronY), 4, electronPaint);

        // Electron trail
        final trailPaint = Paint()
          ..color = Colors.yellow.withOpacity(0.3)
          ..strokeWidth = 2;

        canvas.drawLine(
          Offset(electronX, size.height / 2),
          Offset(electronX, electronY),
          trailPaint,
        );
      }
    }

    // Draw energy labels
    final energyText = TextPainter(
      text: TextSpan(
        text: '${(1240 / wavelength).toStringAsFixed(2)} eV',
        style: TextStyle(
          fontSize: 12,
          color: photonColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    energyText.layout();
    energyText.paint(canvas, Offset(centerX - energyText.width / 2, 30));

    // Draw work function barrier
    final barrierPaint = Paint()
      ..color = Colors.grey[800]!
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(50, size.height / 2),
      Offset(size.width - 50, size.height / 2),
      barrierPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _PhotoelectricPainter old) =>
      old.wavelength != wavelength || old.intensity != intensity ||
          old.canEmitElectron != canEmitElectron || old.photonPhase != photonPhase;
}

/* ------------------------- Capacitor Simulator -------------------------- */

class CapacitorSimulator extends StatefulWidget {
  const CapacitorSimulator({super.key});

  @override
  State<CapacitorSimulator> createState() => _CapacitorSimulatorState();
}

class _CapacitorSimulatorState extends State<CapacitorSimulator> with SingleTickerProviderStateMixin {
  double capacitance = 10;
  double voltage = 5;
  bool isCharging = true;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double get charge => capacitance * voltage / 1000; // in mC
  double get energy => 0.5 * capacitance * voltage * voltage / 1000; // in mJ

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Simulation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final chargeLevel = isCharging ? _animationController.value : 1 - _animationController.value;
                  return CustomPaint(
                    painter: _CapacitorPainter(
                      capacitance: capacitance,
                      voltage: voltage,
                      chargeLevel: chargeLevel,
                      isCharging: isCharging,
                      animationValue: _animationController.value,
                    ),
                    child: Container(),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            _ControlSection(
              title: 'Capacitance',
              value: capacitance,
              unit: 'μF',
              min: 1,
              max: 100,
              onChanged: (v) => setState(() => capacitance = v),
            ),
            const SizedBox(height: 16),
            _ControlSection(
              title: 'Voltage',
              value: voltage,
              unit: 'V',
              min: 1,
              max: 12,
              onChanged: (v) => setState(() => voltage = v),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => isCharging = true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isCharging ? Colors.cyan[600] : Colors.grey[300],
                      foregroundColor: isCharging ? Colors.white : Colors.grey[600],
                    ),
                    child: const Text('Charge'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => isCharging = false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !isCharging ? Colors.cyan[600] : Colors.grey[300],
                      foregroundColor: !isCharging ? Colors.white : Colors.grey[600],
                    ),
                    child: const Text('Discharge'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.cyan[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Results',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Charge: ${charge.toStringAsFixed(1)} mC',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Energy: ${energy.toStringAsFixed(1)} mJ',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  const Text('Formula: Q = CV'),
                  const Text('Energy: E = ½CV²'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CapacitorPainter extends CustomPainter {
  final double capacitance;
  final double voltage;
  final double chargeLevel;
  final bool isCharging;
  final double animationValue;

  _CapacitorPainter({
    required this.capacitance,
    required this.voltage,
    required this.chargeLevel,
    required this.isCharging,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw capacitor plates
    final platePaint = Paint()..color = Colors.grey[800]!;
    final plateHeight = 80.0;
    final plateWidth = 120.0;
    final plateSpacing = 20.0;

    // Top plate
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX, centerY - plateSpacing / 2 - plateHeight / 2),
        width: plateWidth,
        height: plateHeight,
      ),
      platePaint,
    );

    // Bottom plate
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX, centerY + plateSpacing / 2 + plateHeight / 2),
        width: plateWidth,
        height: plateHeight,
      ),
      platePaint,
    );

    // Draw electric field
    final fieldStrength = chargeLevel.clamp(0.0, 1.0);
    final fieldColor = Color.lerp(
      Colors.blue.withOpacity(0.3),
      Colors.purple.withOpacity(0.8),
      fieldStrength,
    )!;

    final fieldPaint = Paint()
      ..color = fieldColor
      ..strokeWidth = 1;

    for (double x = centerX - plateWidth / 2 + 10; x < centerX + plateWidth / 2; x += 15) {
      for (double y = centerY - plateSpacing / 2 + 2; y < centerY + plateSpacing / 2; y += 8) {
        final fieldLine = Path();
        fieldLine.moveTo(x, centerY - plateSpacing / 2);
        fieldLine.lineTo(x, centerY + plateSpacing / 2);
        canvas.drawPath(fieldLine, fieldPaint);
      }
    }

    // Draw charge accumulation
    final chargePaint = Paint()
      ..color = isCharging ? Colors.red : Colors.blue;

    final chargeCount = (fieldStrength * 20).round();
    for (int i = 0; i < chargeCount; i++) {
      final angle = i * 2 * pi / chargeCount;
      final radius = plateWidth / 2 - 10;

      // Top plate charges (positive)
      final topX = centerX + cos(angle) * radius;
      final topY = centerY - plateSpacing / 2 - plateHeight / 2 + 10 + sin(animationValue * 2 * pi) * 2;
      canvas.drawCircle(Offset(topX, topY), 3, chargePaint..color = Colors.red);

      // Bottom plate charges (negative)
      final bottomX = centerX + cos(angle + pi) * radius;
      final bottomY = centerY + plateSpacing / 2 + plateHeight / 2 - 10 - sin(animationValue * 2 * pi) * 2;
      canvas.drawCircle(Offset(bottomX, bottomY), 3, chargePaint..color = Colors.blue);
    }

    // Draw current flow
    if (isCharging) {
      final currentPaint = Paint()
        ..color = Colors.orange
        ..strokeWidth = 2;

      final wireStart = Offset(centerX - plateWidth / 2 - 30, centerY);
      final wireEnd = Offset(centerX - plateWidth / 2 - 5, centerY);

      canvas.drawLine(wireStart, wireEnd, currentPaint);

      // Animated electrons
      final electronPaint = Paint()..color = Colors.yellow;
      for (int i = 0; i < 3; i++) {
        final electronPos = (animationValue + i * 0.3) % 1.0;
        final electronX = wireStart.dx + electronPos * (wireEnd.dx - wireStart.dx);
        canvas.drawCircle(Offset(electronX, centerY), 3, electronPaint);
      }
    }

    // Draw voltage source
    final sourceRect = Rect.fromCenter(
      center: Offset(centerX - plateWidth / 2 - 60, centerY),
      width: 30,
      height: 50,
    );
    canvas.drawRect(sourceRect, Paint()..color = Colors.green);

    // Voltage label
    final voltageText = TextPainter(
      text: TextSpan(
        text: '${voltage.toStringAsFixed(1)}V',
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    voltageText.layout();
    voltageText.paint(canvas, Offset(centerX - plateWidth / 2 - 75, centerY - 40));

    // Charge level indicator
    final indicatorPaint = Paint()
      ..color = Colors.cyan[800]!
      ..strokeWidth = 2;

    final indicatorY = centerY + plateHeight + 20;
    canvas.drawLine(
      Offset(centerX - 50, indicatorY),
      Offset(centerX + 50, indicatorY),
      indicatorPaint,
    );

    final levelWidth = fieldStrength * 100;
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX - 50 + levelWidth / 2, indicatorY),
        width: levelWidth,
        height: 6,
      ),
      Paint()..color = Colors.cyan,
    );
  }

  @override
  bool shouldRepaint(covariant _CapacitorPainter old) =>
      old.capacitance != capacitance || old.voltage != voltage ||
          old.chargeLevel != chargeLevel || old.isCharging != isCharging ||
          old.animationValue != animationValue;
}

/* --------------------------- Utilities ---------------------------------- */

double _lerpDouble(num a, num b, double t) {
  return a + (b - a) * t;
}