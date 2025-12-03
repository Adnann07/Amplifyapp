import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui'; // For ImageFilter.blur

class WaveInterferenceLabScreen extends StatefulWidget {
  const WaveInterferenceLabScreen({super.key});

  @override
  State<WaveInterferenceLabScreen> createState() => _WaveInterferenceLabScreenState();
}

class _WaveInterferenceLabScreenState extends State<WaveInterferenceLabScreen> {
  double frequency = 5.0; // Hz
  double amplitude = 30.0; // Pixels
  double slitWidth = 600.0; // nm
  double slitSeparation = 2200.0; // nm
  bool showIntensityGraph = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Wave Interference Lab'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.cyan.shade900.withOpacity(0.5)),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.cyan.shade50, Colors.blue.shade50],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: showIntensityGraph ? 3 : 4,
                child: CustomPaint(
                  painter: WaveInterferencePainter(
                    frequency: frequency,
                    amplitude: amplitude,
                    slitWidth: slitWidth,
                    slitSeparation: slitSeparation,
                  ),
                  size: Size.infinite,
                ),
              ),
              if (showIntensityGraph)
                Expanded(
                  flex: 1,
                  child: Center(
                    child: CustomPaint(
                      painter: IntensityGraphPainter(
                        frequency: frequency,
                        amplitude: amplitude,
                        slitSeparation: slitSeparation,
                      ),
                      size: Size(MediaQuery.of(context).size.width * 0.7, 60),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    _buildSlider('Frequency', frequency, 1, 10, 'Hz',
                            (value) => setState(() => frequency = value)),
                    _buildSlider('Amplitude', amplitude, 10, 60, '',
                            (value) => setState(() => amplitude = value)),
                    _buildSlider('Slit Width', slitWidth, 200, 1600, 'nm',
                            (value) => setState(() => slitWidth = value)),
                    _buildSlider('Slit Separation', slitSeparation, 1600, 3200, 'nm',
                            (value) => setState(() => slitSeparation = value)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: showIntensityGraph,
                          onChanged: (checked) =>
                              setState(() => showIntensityGraph = checked!),
                        ),
                        const Text('Show Intensity Graph')
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max, String unit, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          Text('${value.round()} $unit', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ]),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: 100,
          onChanged: onChanged,
          activeColor: Colors.cyan,
        ),
      ],
    );
  }
}

class WaveInterferencePainter extends CustomPainter {
  final double frequency;
  final double amplitude;
  final double slitWidth;
  final double slitSeparation;

  WaveInterferencePainter({
    required this.frequency,
    required this.amplitude,
    required this.slitWidth,
    required this.slitSeparation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double generatorX = 60;
    final double slitStartX = generatorX + 50;
    final double screenX = size.width - 60;
    final double centerY = size.height / 2;

    // Draw light generator
    canvas.drawRect(
      Rect.fromLTWH(10, centerY - 70, 30, 140),
      Paint()..color = Colors.grey.shade500,
    );

    // Draw slits
    final slit1Y = centerY - slitSeparation / 4 / 10;
    final slit2Y = centerY + slitSeparation / 4 / 10;
    final slitW = slitWidth / 400;
    canvas.drawRect(Rect.fromLTWH(slitStartX, slit1Y - slitW / 2, 6, slitW), Paint()..color = Colors.yellow.shade700);
    canvas.drawRect(Rect.fromLTWH(slitStartX, slit2Y - slitW / 2, 6, slitW), Paint()..color = Colors.yellow.shade700);

    // Draw incoming plane waves (left)
    final wavePaint = Paint()
      ..color = Colors.cyanAccent.withOpacity(0.7)
      ..strokeWidth = 3;
    for (double x = 0; x < slitStartX - 10; x += 18) {
      double ySin = amplitude * math.sin(x / 40 * frequency);
      canvas.drawLine(Offset(x + 10, centerY - 55 + ySin), Offset(x + 10, centerY + 55 + ySin), wavePaint);
    }

    // Draw interference pattern after slits
    final interferencePaint = Paint()
      ..color = Colors.cyan.shade700.withOpacity(0.3)
      ..strokeWidth = 2;
    for (double y = centerY - 70; y <= centerY + 70; y += 2) {
      for (double x = slitStartX + 10; x <= screenX; x += 7) {
        // Compute two-slit interference: fringes
        double r1 = math.sqrt(math.pow(x - slitStartX, 2) + math.pow(y - slit1Y, 2));
        double r2 = math.sqrt(math.pow(x - slitStartX, 2) + math.pow(y - slit2Y, 2));
        double phase = frequency * (r1 - r2) / 50;
        double intensity = 1 + math.cos(phase);
        int alpha = (120 + 80 * intensity).clamp(0, 255).toInt();
        canvas.drawCircle(Offset(x, y), 1.3, interferencePaint..color = Color.fromARGB(alpha, 51, 224, 255));

      }
    }

    // Draw final screen
    canvas.drawRect(
      Rect.fromLTWH(screenX, centerY - 70, 7, 140),
      Paint()..color = Colors.grey.shade700,
    );
  }

  @override
  bool shouldRepaint(covariant WaveInterferencePainter oldDelegate) => true;
}

class IntensityGraphPainter extends CustomPainter {
  final double frequency;
  final double amplitude;
  final double slitSeparation;

  IntensityGraphPainter({
    required this.frequency,
    required this.amplitude,
    required this.slitSeparation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final axisPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;
    final linePaint = Paint()
      ..color = Colors.cyan.shade600
      ..strokeWidth = 2;

    // Draw axis
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), axisPaint);

    // Draw intensity graph
    final points = <Offset>[];
    for (int i = 0; i < size.width.toInt(); i++) {
      double theta = (i - size.width / 2) / (size.width / 2) * math.pi;
      double intensity = amplitude * math.pow(math.cos(frequency * slitSeparation / 1600 * theta / 2), 2);
      points.add(Offset(i.toDouble(), size.height / 2 - intensity));
    }
    for (int i = 1; i < points.length; i++) {
      canvas.drawLine(points[i - 1], points[i], linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant IntensityGraphPainter oldDelegate) => true;
}
