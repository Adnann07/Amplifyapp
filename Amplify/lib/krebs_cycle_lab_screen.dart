import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';

class KrebsCycleLabScreen extends StatefulWidget {
  const KrebsCycleLabScreen({super.key});

  @override
  State<KrebsCycleLabScreen> createState() => _KrebsCycleLabScreenState();
}

class _KrebsCycleLabScreenState extends State<KrebsCycleLabScreen>
    with TickerProviderStateMixin {
  late AnimationController _cycleController;

  double _currentStep = 0;
  double _animationSpeed = 1.0;
  bool _showMolecules = true;
  bool _showEnergy = true;

  final int _baseDurationMs = 20000;

  final List<KrebsStep> _steps = [
    KrebsStep(
      name: '1. Citrate Formation',
      substrate: 'Acetyl-CoA + OAA',
      product: 'Citrate (6C)',
      enzyme: 'Citrate Synthase',
      energy: '',
      color: Colors.orange,
    ),
    KrebsStep(
      name: '2. Isomerization',
      substrate: 'Citrate',
      product: 'Isocitrate',
      enzyme: 'Aconitase',
      energy: '',
      color: Colors.purple,
    ),
    KrebsStep(
      name: '3. Oxidative Decarb.',
      substrate: 'Isocitrate',
      product: 'α-Ketoglutarate (5C) + CO₂',
      enzyme: 'Isocitrate DH',
      energy: 'NADH',
      color: Colors.red,
    ),
    KrebsStep(
      name: '4. Oxidative Decarb.',
      substrate: 'α-KG',
      product: 'Succinyl-CoA + CO₂',
      enzyme: 'α-KG DH',
      energy: 'NADH',
      color: Colors.pink,
    ),
    KrebsStep(
      name: '5. Substrate Phosph.',
      substrate: 'Succinyl-CoA',
      product: 'Succinate',
      enzyme: 'Succinyl-CoA Synthetase',
      energy: 'GTP',
      color: Colors.green,
    ),
    KrebsStep(
      name: '6. Oxidation',
      substrate: 'Succinate',
      product: 'Fumarate',
      enzyme: 'Succinate DH',
      energy: 'FADH₂',
      color: Colors.teal,
    ),
    KrebsStep(
      name: '7. Hydration',
      substrate: 'Fumarate',
      product: 'Malate',
      enzyme: 'Fumarase',
      energy: '',
      color: Colors.blue,
    ),
    KrebsStep(
      name: '8. Oxidation',
      substrate: 'Malate',
      product: 'Oxaloacetate (4C)',
      enzyme: 'Malate DH',
      energy: 'NADH',
      color: Colors.indigo,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _cycleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _baseDurationMs),
    )..repeat();
  }

  @override
  void dispose() {
    _cycleController.dispose();
    super.dispose();
  }

  void _updateAnimationSpeed(double speed) {
    setState(() {
      _animationSpeed = speed;
      final newDuration =
      Duration(milliseconds: (_baseDurationMs / _animationSpeed).round());
      _cycleController.duration = newDuration;
      _cycleController.reset();
      _cycleController.repeat();
    });
  }

  void _play() {
    _cycleController.repeat();
  }

  void _pause() {
    _cycleController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Krebs Cycle Lab'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.green.shade900.withOpacity(0.5)),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green.shade50, Colors.blue.shade50],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: AnimatedBuilder(
                  animation: _cycleController,
                  builder: (context, child) {
                    _currentStep = (_cycleController.value * 8) % 8;
                    return Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CustomPaint(
                          painter: KrebsCyclePainter(
                            steps: _steps,
                            currentStep: _currentStep,
                            showMolecules: _showMolecules,
                            showEnergy: _showEnergy,
                            animationValue: _cycleController.value,
                          ),
                          size: Size.infinite,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: _buildControlPanel(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlPanel() {
    final step = _steps[_currentStep.floor()];
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cycle Controls',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
            Slider(
              value: _animationSpeed,
              min: 0.1,
              max: 3.0,
              divisions: 29,
              label: '${_animationSpeed.toStringAsFixed(1)}x',
              onChanged: (value) => _updateAnimationSpeed(value),
              activeColor: Colors.green,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _play,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Play'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                ElevatedButton.icon(
                  onPressed: _pause,
                  icon: const Icon(Icons.pause),
                  label: const Text('Pause'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Display Options',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Molecules', style: TextStyle(fontSize: 12)),
                    value: _showMolecules,
                    onChanged: (value) => setState(() => _showMolecules = value!),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Energy', style: TextStyle(fontSize: 12)),
                    value: _showEnergy,
                    onChanged: (value) => setState(() => _showEnergy = value!),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
            Card(
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: step.color,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: Text(step.substrate, style: const TextStyle(fontWeight: FontWeight.w500))),
                        const Icon(Icons.arrow_forward, color: Colors.green),
                        Expanded(child: Text(step.product, style: const TextStyle(fontWeight: FontWeight.w500))),
                      ],
                    ),
                    if (step.energy.isNotEmpty) ...[
                      const Divider(),
                      Text('Produces: ${step.energy}',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green.shade700)),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const Text('Total per Acetyl-CoA:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('3 NADH + 1 FADH₂ + 1 GTP',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800)),
                    const Text('→ ~10 ATP via ETC',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KrebsStep {
  final String name, substrate, product, enzyme, energy;
  final Color color;
  KrebsStep({
    required this.name,
    required this.substrate,
    required this.product,
    required this.enzyme,
    required this.energy,
    required this.color,
  });
}

class KrebsCyclePainter extends CustomPainter {
  final List<KrebsStep> steps;
  final double currentStep;
  final bool showMolecules;
  final bool showEnergy;
  final double animationValue;

  KrebsCyclePainter({
    required this.steps,
    required this.currentStep,
    required this.showMolecules,
    required this.showEnergy,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2.8;

    // Draw mitochondrion background
    _drawMitochondrion(canvas, size);

    // Draw cycle circle
    _drawCycleCircle(canvas, center, radius);

    // Draw step nodes and animations
    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi / 4) + (animationValue * math.pi * 2);
      final stepRadius = radius * (i == currentStep.floor() ? 1.1 : 1.0);
      final pos = Offset(
        center.dx + stepRadius * math.cos(angle),
        center.dy + stepRadius * math.sin(angle),
      );
      _drawStepNode(canvas, steps[i], pos, i == currentStep.floor());
      if (showMolecules) _drawMoleculeLabel(canvas, steps[i], pos);
    }

    // Draw energy carriers flowing out
    if (showEnergy) _drawEnergyFlow(canvas, center, radius);

    // Draw current step highlight arc
    _drawCurrentStepHighlight(canvas, center, radius);
  }

  void _drawMitochondrion(Canvas canvas, Size size) {
    final path = Path();
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(50, 50, size.width - 100, size.height - 100),
      const Radius.circular(30),
    ));
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.purple.shade100, Colors.blue.shade100],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);

    // Inner membrane
    final membranePaint = Paint()
      ..color = Colors.purple.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(70, 70, size.width - 140, size.height - 140),
        const Radius.circular(25),
      ),
      membranePaint,
    );
  }

  void _drawCycleCircle(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = Colors.green.shade300
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, paint);

    // Arrow indicators
    for (int i = 0; i < 8; i++) {
      final angle = i * math.pi / 4;
      final start = Offset(
        center.dx + (radius - 20) * math.cos(angle),
        center.dy + (radius - 20) * math.sin(angle),
      );
      final end = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      final arrowPaint = Paint()
        ..color = Colors.green.shade600
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(start, end, arrowPaint);
    }
  }

  void _drawStepNode(Canvas canvas, KrebsStep step, Offset pos, bool isActive) {
    final double pulseRadius =
    isActive ? 28 + math.sin(animationValue * math.pi * 4) * 4 : 25;

    // Glow effect for active step
    if (isActive) {
      final glowPaint = Paint()
        ..shader = RadialGradient(
          colors: [step.color.withOpacity(0.4), Colors.transparent],
        ).createShader(Rect.fromCircle(center: pos, radius: 35));
      canvas.drawCircle(pos, 35.0, glowPaint);
    }

    // Main node
    final nodePaint = Paint()
      ..color = step.color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(pos, pulseRadius, nodePaint);

    // Ring border
    final borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(pos, pulseRadius, borderPaint);
  }

  void _drawMoleculeLabel(Canvas canvas, KrebsStep step, Offset pos) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    textPainter.text = TextSpan(
      text: step.product.split('(')[0],
      style: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );
    textPainter.layout();

    final labelPos = Offset(
      pos.dx - textPainter.width / 2,
      pos.dy + 32,
    );
    textPainter.paint(canvas, labelPos);
  }

  void _drawEnergyFlow(Canvas canvas, Offset center, double radius) {
    final energyCarriers = ['NADH', 'FADH₂', 'GTP', 'CO₂'];
    final colors = [Colors.blue, Colors.orange, Colors.purple, Colors.grey];

    for (int i = 0; i < energyCarriers.length; i++) {
      final angle = (animationValue * 0.5 + i * 0.3) * math.pi * 2;
      final dist =
          radius + 40 + math.sin(animationValue * math.pi * 2 + i) * 10;
      final pos = Offset(
        center.dx + dist * math.cos(angle),
        center.dy + dist * math.sin(angle),
      );

      final energyPaint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;
      canvas.drawCircle(pos, 8.0, energyPaint);

      final textPainter = TextPainter(textDirection: TextDirection.ltr);
      textPainter.text = TextSpan(
        text: energyCarriers[i],
        style: const TextStyle(
            color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold),
      );
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(pos.dx - textPainter.width / 2, pos.dy + 12));
    }
  }

  void _drawCurrentStepHighlight(
      Canvas canvas, Offset center, double radius) {
    final stepAngle = currentStep * math.pi / 4;
    final highlightPaint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.yellow.withOpacity(0.3), Colors.transparent],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      stepAngle - math.pi / 8,
      math.pi / 4,
      false,
      highlightPaint,
    );
  }

  @override
  bool shouldRepaint(covariant KrebsCyclePainter oldDelegate) {
    return oldDelegate.currentStep != currentStep ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.showMolecules != showMolecules ||
        oldDelegate.showEnergy != showEnergy;
  }
}
