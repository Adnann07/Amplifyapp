// class910_physics.dart (enhanced with visuals, animations, and interactive elements)
// Enhancements: Added CustomPainters for visual representations, AnimationControllers for lively animations, buttons to start simulations where appropriate, more detailed drawings instead of simple text/icons, particle effects for charges, melting/boiling animations, ray propagation animations, etc.
// Further improvements: Added educational elements like formulas display, step-by-step instructions, interactive measurements, labels on diagrams, theory sections, and more interactions for learning.
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;

class PhysicsExperimentsPage extends StatelessWidget {
  const PhysicsExperimentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Physics Experiments'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Measuring power by running up stairs'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PowerStairsSimulation()),
              );
            },
          ),
          ListTile(
            title: const Text('Producing charge by friction or induction'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChargeSimulation()),
              );
            },
          ),
          ListTile(
            title: const Text('Measuring length, width, and height using slide calipers (e.g., for a matchbox)'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalipersSimulation()),
              );
            },
          ),
          ListTile(
            title: const Text('Determining the cross-sectional area of a wire using a screw gauge'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScrewGaugeSimulation()),
              );
            },
          ),
          ListTile(
            title: const Text('Finding the melting point of ice'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MeltingPointIceSimulation()),
              );
            },
          ),
          ListTile(
            title: const Text('Determining the boiling point of water'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BoilingPointWaterSimulation()),
              );
            },
          ),
          ListTile(
            title: const Text('Creating and demonstrating image formation using convex lenses'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConvexLensSimulation()),
              );
            },
          ),
          ListTile(
            title: const Text('Demonstrating image formation using concave mirrors'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConcaveMirrorSimulation()),
              );
            },
          ),
          ListTile(
            title: const Text('Measuring density of solid objects'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DensitySimulation()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PowerStairsSimulation extends StatefulWidget {
  const PowerStairsSimulation({super.key});

  @override
  State<PowerStairsSimulation> createState() => _PowerStairsSimulationState();
}

class _PowerStairsSimulationState extends State<PowerStairsSimulation> with TickerProviderStateMixin {
  double mass = 60.0; // kg
  double height = 5.0; // m
  double time = 10.0; // s
  double g = 9.8; // m/s²
  late AnimationController _controller;
  bool showTheory = false;

  double getPower() {
    return (mass * g * height) / time;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: (time * 1000).toInt()))
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateDuration() {
    _controller.duration = Duration(milliseconds: (time * 1000).toInt());
  }

  @override
  Widget build(BuildContext context) {
    _updateDuration();
    return Scaffold(
      appBar: AppBar(title: const Text('Power by Running Up Stairs')),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CustomPaint(
                  painter: StairsPainter(_controller.value, height),
                  child: Center(
                    child: Text('Power: ${getPower().toStringAsFixed(2)} W\nFormula: P = (m * g * h) / t'),
                  ),
                ),
                if (showTheory)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      color: Colors.white.withOpacity(0.8),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Theory: Power is work done per unit time. Work = mgh. Measure time to climb stairs.\nSteps: 1. Measure mass, height. 2. Time the run. 3. Calculate power.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _controller.reset();
              _controller.forward();
            },
            child: const Text('Start Simulation'),
          ),
          ElevatedButton(
            onPressed: () => setState(() => showTheory = !showTheory),
            child: const Text('Toggle Theory'),
          ),
          Slider(
            value: mass,
            min: 40.0,
            max: 100.0,
            label: 'Mass: $mass kg',
            onChanged: (value) => setState(() => mass = value),
          ),
          Slider(
            value: height,
            min: 1.0,
            max: 10.0,
            label: 'Height: $height m',
            onChanged: (value) => setState(() => height = value),
          ),
          Slider(
            value: time,
            min: 5.0,
            max: 20.0,
            label: 'Time: $time s',
            onChanged: (value) => setState(() => time = value),
          ),
        ],
      ),
    );
  }
}

class StairsPainter extends CustomPainter {
  final double progress;
  final double height;

  StairsPainter(this.progress, this.height);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black..strokeWidth = 2.0;
    final numSteps = (height * 2).toInt(); // Approximate steps based on height
    final stepWidth = size.width / numSteps;
    final stepHeight = size.height / numSteps;
    // Draw stairs
    for (int i = 0; i < numSteps; i++) {
      canvas.drawLine(Offset(i * stepWidth, size.height - i * stepHeight), Offset((i + 1) * stepWidth, size.height - i * stepHeight), paint);
      canvas.drawLine(Offset(i * stepWidth, size.height - i * stepHeight), Offset(i * stepWidth, size.height - (i + 1) * stepHeight), paint);
    }
    // Draw animated person (simple stick figure moving up)
    double posX = progress * size.width;
    double posY = size.height - progress * size.height;
    // Head
    canvas.drawCircle(Offset(posX, posY - 20), 10, paint);
    // Body
    canvas.drawLine(Offset(posX, posY - 10), Offset(posX, posY + 20), paint);
    // Arms
    canvas.drawLine(Offset(posX - 10, posY), Offset(posX + 10, posY), paint);
    // Legs (alternating for running effect)
    double legAngle = (progress * 10 % 2 > 1) ? 10 : -10;
    canvas.drawLine(Offset(posX, posY + 20), Offset(posX - legAngle, posY + 40), paint);
    canvas.drawLine(Offset(posX, posY + 20), Offset(posX + legAngle, posY + 40), paint);
    // Add labels
    final textPainter = TextPainter(text: const TextSpan(text: 'Height (h)'), textDirection: ui.TextDirection.ltr);
    textPainter.layout();
    textPainter.paint(canvas, Offset(10, size.height / 2));
  }

  @override
  bool shouldRepaint(covariant StairsPainter oldDelegate) => oldDelegate.progress != progress || oldDelegate.height != height;
}

class ChargeSimulation extends StatefulWidget {
  const ChargeSimulation({super.key});

  @override
  State<ChargeSimulation> createState() => _ChargeSimulationState();
}

class _ChargeSimulationState extends State<ChargeSimulation> with TickerProviderStateMixin {
  bool friction = false;
  bool induction = false;
  late AnimationController _controller;
  bool showTheory = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 5))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String status = friction ? 'Friction: Charges separated' : induction ? 'Induction: Charges induced' : 'No action';
    return Scaffold(
      appBar: AppBar(title: const Text('Charge by Friction or Induction')),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: ChargePainter(friction, induction, _controller.value),
                      child: Center(child: Text('$status\nFormula: Charge transfer via contact or proximity')),
                    );
                  },
                ),
                if (showTheory)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      color: Colors.white.withOpacity(0.8),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Theory: Friction transfers electrons. Induction rearranges charges without transfer.\nSteps: 1. Select mode. 2. Observe animation. 3. Note charge separation.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SwitchListTile(
            title: const Text('Friction'),
            value: friction,
            onChanged: (value) => setState(() {
              friction = value;
              if (value) induction = false;
            }),
          ),
          SwitchListTile(
            title: const Text('Induction'),
            value: induction,
            onChanged: (value) => setState(() {
              induction = value;
              if (value) friction = false;
            }),
          ),
          ElevatedButton(
            onPressed: () => setState(() => showTheory = !showTheory),
            child: const Text('Toggle Theory'),
          ),
        ],
      ),
    );
  }
}

class ChargePainter extends CustomPainter {
  final bool friction;
  final bool induction;
  final double progress;

  ChargePainter(this.friction, this.induction, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 2.0;
    if (friction) {
      // Draw two rods rubbing
      paint.color = Colors.blue;
      canvas.drawRect(Rect.fromLTWH(size.width / 4 - 50, size.height / 2 - 10, 100, 20), paint);
      paint.color = Colors.red;
      double rubOffset = sin(progress * 20) * 10; // Moving back and forth
      canvas.drawRect(Rect.fromLTWH(size.width * 3 / 4 - 50 + rubOffset, size.height / 2 - 10, 100, 20), paint);
      // Animate particles (electrons) transferring
      paint.color = Colors.yellow;
      for (int i = 0; i < 5; i++) {
        double particleProgress = (progress + i * 0.2) % 1.0;
        double particleX = size.width / 4 + particleProgress * (size.width / 2);
        double particleY = size.height / 2 + sin(particleProgress * 20) * 10;
        canvas.drawCircle(Offset(particleX, particleY), 3, paint);
      }
      // Labels
      final textPainter = TextPainter(text: const TextSpan(text: '+ Charge'), textDirection: ui.TextDirection.ltr);
      textPainter.layout();
      textPainter.paint(canvas, Offset(size.width / 4 - 40, size.height / 2 - 30));
    } else if (induction) {
      // Draw charged rod and neutral object
      paint.color = Colors.red;
      canvas.drawRect(Rect.fromLTWH(size.width / 4 - 50, size.height / 2 - 10, 100, 20), paint); // Charged
      paint.color = Colors.grey;
      double approachOffset = progress * (size.width / 4); // Approaching
      canvas.drawRect(Rect.fromLTWH(size.width * 3 / 4 - 50 - approachOffset, size.height / 2 - 10, 100, 20), paint); // Neutral
      // Animate charges separating
      paint.color = Colors.blue;
      for (int i = 0; i < 5; i++) {
        double posX = size.width * 3 / 4 - 50 - approachOffset + i * 20;
        double posY = size.height / 2 + (progress > 0.5 ? 10 : -10);
        canvas.drawCircle(Offset(posX, posY), 3, paint);
      }
      paint.color = Colors.yellow;
      for (int i = 0; i < 5; i++) {
        double posX = size.width * 3 / 4 - 50 - approachOffset + i * 20;
        double posY = size.height / 2 + (progress > 0.5 ? -10 : 10);
        canvas.drawCircle(Offset(posX, posY), 3, paint);
      }
      // Labels
      final textPainter = TextPainter(text: const TextSpan(text: 'Induced -'), textDirection: ui.TextDirection.ltr);
      textPainter.layout();
      textPainter.paint(canvas, Offset(size.width * 3 / 4 - 60 - approachOffset, size.height / 2 - 30));
    }
  }

  @override
  bool shouldRepaint(covariant ChargePainter oldDelegate) =>
      oldDelegate.friction != friction || oldDelegate.induction != induction || oldDelegate.progress != progress;
}

class CalipersSimulation extends StatefulWidget {
  const CalipersSimulation({super.key});

  @override
  State<CalipersSimulation> createState() => _CalipersSimulationState();
}

class _CalipersSimulationState extends State<CalipersSimulation> {
  double length = 5.0; // cm
  double width = 3.0; // cm
  double height = 2.0; // cm
  bool showTheory = false;
  bool measuringLength = true;
  bool measuringWidth = false;
  bool measuringHeight = false;

  @override
  Widget build(BuildContext context) {
    String formula = 'Measurement = Main Scale + (Vernier Scale * Least Count)\nLeast Count = 0.01 cm typically';
    return Scaffold(
      appBar: AppBar(title: const Text('Slide Calipers Measurement')),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    // Cycle through measurements
                    setState(() {
                      if (measuringLength) {
                        measuringLength = false;
                        measuringWidth = true;
                      } else if (measuringWidth) {
                        measuringWidth = false;
                        measuringHeight = true;
                      } else {
                        measuringHeight = false;
                        measuringLength = true;
                      }
                    });
                  },
                  child: CustomPaint(
                    painter: CalipersPainter(length, width, height, measuringLength, measuringWidth, measuringHeight),
                    child: Center(child: Text('Tap to switch dimension\n$formula')),
                  ),
                ),
                if (showTheory)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      color: Colors.white.withOpacity(0.8),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Theory: Vernier calipers for precise linear measurements.\nSteps: 1. Place object. 2. Read main and vernier scales. 3. Calculate.\nObservations: Accurate to 0.01 cm.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => setState(() => showTheory = !showTheory),
            child: const Text('Toggle Theory'),
          ),
          Slider(
            value: length,
            min: 1.0,
            max: 10.0,
            label: 'Length: $length cm',
            onChanged: (value) => setState(() => length = value),
          ),
          Slider(
            value: width,
            min: 1.0,
            max: 10.0,
            label: 'Width: $width cm',
            onChanged: (value) => setState(() => width = value),
          ),
          Slider(
            value: height,
            min: 1.0,
            max: 10.0,
            label: 'Height: $height cm',
            onChanged: (value) => setState(() => height = value),
          ),
        ],
      ),
    );
  }
}

class CalipersPainter extends CustomPainter {
  final double length;
  final double width;
  final double height;
  final bool measuringLength;
  final bool measuringWidth;
  final bool measuringHeight;

  CalipersPainter(this.length, this.width, this.height, this.measuringLength, this.measuringWidth, this.measuringHeight);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black..strokeWidth = 2.0;
    final scale = 20.0;
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    // Draw matchbox (simple 3D representation)
    paint.color = Colors.brown;
    canvas.drawRect(Rect.fromLTWH(centerX - length * scale / 2, centerY - width * scale / 2, length * scale, width * scale), paint);
    // Slanted lines for height
    paint.style = ui.PaintingStyle.stroke;
    canvas.drawLine(Offset(centerX - length * scale / 2, centerY - width * scale / 2), Offset(centerX - length * scale / 2 - height * scale / 2, centerY - width * scale / 2 - height * scale / 2), paint);
    canvas.drawLine(Offset(centerX + length * scale / 2, centerY - width * scale / 2), Offset(centerX + length * scale / 2 - height * scale / 2, centerY - width * scale / 2 - height * scale / 2), paint);
    canvas.drawRect(Rect.fromLTWH(centerX - length * scale / 2 - height * scale / 2, centerY - width * scale / 2 - height * scale / 2, length * scale, width * scale), paint);
    // Draw calipers based on mode
    paint.color = Colors.grey;
    if (measuringLength) {
      // Calipers for length (horizontal)
      canvas.drawLine(Offset(centerX - length * scale / 2 - 10, centerY), Offset(centerX - length * scale / 2, centerY), paint);
      canvas.drawLine(Offset(centerX + length * scale / 2, centerY), Offset(centerX + length * scale / 2 + 10, centerY), paint);
      canvas.drawLine(Offset(centerX - length * scale / 2 - 10, centerY - 20), Offset(centerX - length * scale / 2 - 10, centerY + 20), paint);
      canvas.drawLine(Offset(centerX + length * scale / 2 + 10, centerY - 20), Offset(centerX + length * scale / 2 + 10, centerY + 20), paint);
      // Vernier scale simulation (simple lines)
      for (int i = 0; i < 10; i++) {
        canvas.drawLine(Offset(centerX - length * scale / 2 - 10 + i * 2, centerY + 25), Offset(centerX - length * scale / 2 - 10 + i * 2, centerY + 35), paint);
      }
      // Label
      final textPainter = TextPainter(text: const TextSpan(text: 'Measuring Length'), textDirection: ui.TextDirection.ltr);
      textPainter.layout();
      textPainter.paint(canvas, Offset(centerX - 50, centerY - 50));
    } else if (measuringWidth) {
      // Calipers for width (vertical)
      canvas.drawLine(Offset(centerX, centerY - width * scale / 2 - 10), Offset(centerX, centerY - width * scale / 2), paint);
      canvas.drawLine(Offset(centerX, centerY + width * scale / 2), Offset(centerX, centerY + width * scale / 2 + 10), paint);
      canvas.drawLine(Offset(centerX - 20, centerY - width * scale / 2 - 10), Offset(centerX + 20, centerY - width * scale / 2 - 10), paint);
      canvas.drawLine(Offset(centerX - 20, centerY + width * scale / 2 + 10), Offset(centerX + 20, centerY + width * scale / 2 + 10), paint);
      // Vernier
      for (int i = 0; i < 10; i++) {
        canvas.drawLine(Offset(centerX + 25, centerY - width * scale / 2 - 10 + i * 2), Offset(centerX + 35, centerY - width * scale / 2 - 10 + i * 2), paint);
      }
      // Label
      final textPainter = TextPainter(text: const TextSpan(text: 'Measuring Width'), textDirection: ui.TextDirection.ltr);
      textPainter.layout();
      textPainter.paint(canvas, Offset(centerX - 50, centerY - 50));
    } else if (measuringHeight) {
      // Calipers for height (diagonal for 3D)
      canvas.drawLine(Offset(centerX - height * scale / 2, centerY - height * scale / 2 - 10), Offset(centerX - height * scale / 2, centerY - height * scale / 2), paint);
      canvas.drawLine(Offset(centerX + height * scale / 2, centerY + height * scale / 2), Offset(centerX + height * scale / 2, centerY + height * scale / 2 + 10), paint);
      // Simplified jaws
      canvas.drawLine(Offset(centerX - height * scale / 2 - 20, centerY - height * scale / 2 - 10), Offset(centerX - height * scale / 2 + 20, centerY - height * scale / 2 - 10), paint);
      canvas.drawLine(Offset(centerX + height * scale / 2 - 20, centerY + height * scale / 2 + 10), Offset(centerX + height * scale / 2 + 20, centerY + height * scale / 2 + 10), paint);
      // Label
      final textPainter = TextPainter(text: const TextSpan(text: 'Measuring Height'), textDirection: ui.TextDirection.ltr);
      textPainter.layout();
      textPainter.paint(canvas, Offset(centerX - 50, centerY - 50));
    }
  }

  @override
  bool shouldRepaint(covariant CalipersPainter oldDelegate) => true;
}

class ScrewGaugeSimulation extends StatefulWidget {
  const ScrewGaugeSimulation({super.key});

  @override
  State<ScrewGaugeSimulation> createState() => _ScrewGaugeSimulationState();
}

class _ScrewGaugeSimulationState extends State<ScrewGaugeSimulation> {
  double diameter = 0.1; // mm
  bool showTheory = false;

  double getArea() {
    return pi * pow(diameter / 2, 2);
  }

  @override
  Widget build(BuildContext context) {
    String formula = 'Area = π (d/2)²\nLeast Count = Pitch / Divisions (e.g., 0.01 mm)';
    return Scaffold(
      appBar: AppBar(title: const Text('Screw Gauge for Wire Area')),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CustomPaint(
                  painter: ScrewGaugePainter(diameter),
                  child: Center(
                    child: Text('Area: ${getArea().toStringAsFixed(4)} mm²\n$formula'),
                  ),
                ),
                if (showTheory)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      color: Colors.white.withOpacity(0.8),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Theory: Micrometer for small diameters.\nSteps: 1. Place wire. 2. Rotate thimble. 3. Read sleeve and thimble. 4. Calculate area.\nObservations: Precise to 0.01 mm.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => setState(() => showTheory = !showTheory),
            child: const Text('Toggle Theory'),
          ),
          Slider(
            value: diameter,
            min: 0.05,
            max: 0.5,
            label: 'Diameter: $diameter mm',
            onChanged: (value) => setState(() => diameter = value),
          ),
        ],
      ),
    );
  }
}

class ScrewGaugePainter extends CustomPainter {
  final double diameter;

  ScrewGaugePainter(this.diameter);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black..strokeWidth = 2.0;
    final scale = 200.0;
    // Draw screw gauge body (sleeve)
    paint.color = Colors.grey.shade300;
    canvas.drawRect(Rect.fromLTWH(size.width / 2 - 100, size.height / 2 - 20, 200, 40), paint);
    // Draw scale lines on sleeve
    paint.color = Colors.black;
    for (int i = 0; i < 11; i++) {
      canvas.drawLine(Offset(size.width / 2 - 100 + i * 20, size.height / 2 - 20), Offset(size.width / 2 - 100 + i * 20, size.height / 2 - 30), paint);
    }
    // Draw thimble
    paint.color = Colors.grey;
    double thimblePos = diameter * scale / 2; // Simulate rotation
    canvas.drawRect(Rect.fromLTWH(size.width / 2 + 100 - thimblePos, size.height / 2 - 30, 50, 60), paint);
    // Draw circular scale on thimble
    for (int i = 0; i < 50; i += 5) {
      double angle = i / 50 * 2 * pi;
      double x1 = size.width / 2 + 100 - thimblePos + 25 + 20 * cos(angle);
      double y1 = size.height / 2 + 20 * sin(angle);
      double x2 = x1 + 5 * cos(angle);
      double y2 = y1 + 5 * sin(angle);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
    // Draw anvil and spindle
    paint.color = Colors.black;
    canvas.drawCircle(Offset(size.width / 2 - 100, size.height / 2), 10, paint); // Anvil
    canvas.drawLine(Offset(size.width / 2 - 90, size.height / 2), Offset(size.width / 2 + 100 - thimblePos, size.height / 2), paint); // Spindle
    // Draw wire (circle cross-section)
    paint.color = Colors.red;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), diameter * scale / 2, paint);
    // Labels
    final textPainter = TextPainter(text: const TextSpan(text: 'Sleeve Scale'), textDirection: ui.TextDirection.ltr);
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width / 2 - 100, size.height / 2 - 50));
    final thimbleLabel = TextPainter(text: const TextSpan(text: 'Thimble Scale'), textDirection: ui.TextDirection.ltr);
    thimbleLabel.layout();
    thimbleLabel.paint(canvas, Offset(size.width / 2 + 80 - thimblePos, size.height / 2 - 50));
  }

  @override
  bool shouldRepaint(covariant ScrewGaugePainter oldDelegate) => oldDelegate.diameter != diameter;
}

class MeltingPointIceSimulation extends StatefulWidget {
  const MeltingPointIceSimulation({super.key});

  @override
  State<MeltingPointIceSimulation> createState() => _MeltingPointIceSimulationState();
}

class _MeltingPointIceSimulationState extends State<MeltingPointIceSimulation> with TickerProviderStateMixin {
  double temperature = -5.0;
  late AnimationController _controller;
  bool showTheory = false;

  String getState() {
    return temperature >= 0 ? 'Melting at 0°C' : 'Still solid';
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Melting Point of Ice')),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: IceMeltingPainter(temperature, _controller.value),
                      child: Center(
                        child: Text('State: ${getState()}\nMelting Point: 0°C at 1 atm'),
                      ),
                    );
                  },
                ),
                if (showTheory)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      color: Colors.white.withOpacity(0.8),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Theory: Temperature where solid turns liquid.\nSteps: 1. Heat ice. 2. Monitor temperature. 3. Note constant temp during melting.\nObservations: Latent heat absorbed.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => setState(() => showTheory = !showTheory),
            child: const Text('Toggle Theory'),
          ),
          Slider(
            value: temperature,
            min: -10.0,
            max: 10.0,
            label: 'Temperature: $temperature °C',
            onChanged: (value) => setState(() => temperature = value),
          ),
        ],
      ),
    );
  }
}

class IceMeltingPainter extends CustomPainter {
  final double temperature;
  final double progress;

  IceMeltingPainter(this.temperature, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blueAccent;
    if (temperature < 0) {
      // Solid ice cube
      canvas.drawRect(Rect.fromLTWH(size.width / 2 - 50, size.height / 2 - 50, 100, 100), paint);
    } else {
      // Melting: shrink ice, add water puddle
      double meltFactor = progress * (temperature / 10.0).clamp(0, 1);
      canvas.drawRect(Rect.fromLTWH(size.width / 2 - 50 + 25 * meltFactor, size.height / 2 - 50 + 25 * meltFactor, 100 - 50 * meltFactor, 100 - 50 * meltFactor), paint);
      // Water puddle animating
      paint.color = Colors.blue.withOpacity(0.5);
      double puddleSize = 100 * meltFactor;
      canvas.drawOval(Rect.fromLTWH(size.width / 2 - puddleSize / 2, size.height / 2 + 50 - 25 * meltFactor, puddleSize, 20), paint);
    }
    // Add thermometer
    paint.color = Colors.red;
    double thermHeight = (temperature + 10) / 20 * 100;
    canvas.drawRect(Rect.fromLTWH(size.width - 30, size.height / 2 + 50 - thermHeight, 20, thermHeight), paint);
    paint..color = Colors.black..style = ui.PaintingStyle.stroke;
    canvas.drawRect(Rect.fromLTWH(size.width - 30, size.height / 2 - 50, 20, 200), paint);
  }

  @override
  bool shouldRepaint(covariant IceMeltingPainter oldDelegate) => oldDelegate.temperature != temperature || oldDelegate.progress != progress;
}

class BoilingPointWaterSimulation extends StatefulWidget {
  const BoilingPointWaterSimulation({super.key});

  @override
  State<BoilingPointWaterSimulation> createState() => _BoilingPointWaterSimulationState();
}

class _BoilingPointWaterSimulationState extends State<BoilingPointWaterSimulation> with TickerProviderStateMixin {
  double temperature = 90.0;
  late AnimationController _controller;
  bool showTheory = false;

  String getState() {
    return temperature >= 100 ? 'Boiling at 100°C' : 'Still liquid';
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Boiling Point of Water')),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: BoilingWaterPainter(temperature, _controller.value),
                      child: Center(
                        child: Text('State: ${getState()}\nBoiling Point: 100°C at 1 atm'),
                      ),
                    );
                  },
                ),
                if (showTheory)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      color: Colors.white.withOpacity(0.8),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Theory: Temperature where liquid turns gas.\nSteps: 1. Heat water. 2. Monitor temperature. 3. Note bubbles and constant temp.\nObservations: Latent heat of vaporization.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => setState(() => showTheory = !showTheory),
            child: const Text('Toggle Theory'),
          ),
          Slider(
            value: temperature,
            min: 80.0,
            max: 110.0,
            label: 'Temperature: $temperature °C',
            onChanged: (value) => setState(() => temperature = value),
          ),
        ],
      ),
    );
  }
}

class BoilingWaterPainter extends CustomPainter {
  final double temperature;
  final double progress;

  BoilingWaterPainter(this.temperature, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue;
    // Draw beaker with water
    canvas.drawRect(Rect.fromLTWH(size.width / 2 - 50, size.height / 2, 100, 100), paint); // Water level
    // Draw beaker outline
    paint.style = ui.PaintingStyle.stroke;
    paint.color = Colors.black;
    canvas.drawRect(Rect.fromLTWH(size.width / 2 - 50, size.height / 2 - 50, 100, 200), paint);
    if (temperature >= 100) {
      // Animate bubbles rising
      paint.color = Colors.white.withOpacity(0.8);
      for (int i = 0; i < 5; i++) {
        double bubbleY = size.height / 2 + 100 - (progress + i * 0.2) % 1.0 * 100;
        double bubbleX = size.width / 2 - 40 + i * 20;
        double bubbleSize = 5.0 + sin(progress * 5).abs();
        canvas.drawCircle(Offset(bubbleX, bubbleY), bubbleSize, paint);
      }
    }
    // Add flame below
    paint.color = Colors.orange;
    canvas.drawPath(
      Path()..moveTo(size.width / 2 - 20, size.height / 2 + 150)..quadraticBezierTo(size.width / 2, size.height / 2 + 130, size.width / 2 + 20, size.height / 2 + 150)..close(),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant BoilingWaterPainter oldDelegate) => oldDelegate.temperature != temperature || oldDelegate.progress != progress;
}

class ConvexLensSimulation extends StatefulWidget {
  const ConvexLensSimulation({super.key});

  @override
  State<ConvexLensSimulation> createState() => _ConvexLensSimulationState();
}

class _ConvexLensSimulationState extends State<ConvexLensSimulation> with TickerProviderStateMixin {
  double objectDistance = 20.0; // u in cm
  double focalLength = 10.0; // f in cm
  double objectHeight = 5.0; // cm
  bool showTheory = false;
  bool showLabels = true;
  late AnimationController _controller;

  double getImageDistance() {
    try {
      return 1 / (1 / focalLength - 1 / -objectDistance); // Lens formula: 1/v - 1/u = 1/f, u negative
    } catch (e) {
      return double.infinity;
    }
  }

  double getMagnification() {
    double v = getImageDistance();
    return v / -objectDistance; // m = v/u
  }

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
    double imageDistance = getImageDistance();
    double magnification = getMagnification();
    double imageHeight = objectHeight * magnification.abs();
    String nature = imageDistance > 0 ? 'Real, Inverted' : 'Virtual, Erect';
    String formula = 'Lens Formula: 1/v - 1/u = 1/f\nMagnification m = v/u';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convex Lens Simulation'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      objectDistance += details.delta.dx / 10; // Drag to change object distance
                      objectDistance = objectDistance.clamp(10.0, 50.0);
                    });
                  },
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: LensPainter(objectDistance, focalLength, imageDistance, _controller.value, objectHeight, imageHeight, showLabels),
                      );
                    },
                  ),
                ),
                if (showTheory)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      color: Colors.white.withOpacity(0.8),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Theory: Convex lens converges light.\nSteps: 1. Place object. 2. Trace rays. 3. Find image.\nObservations: $nature, m = ${magnification.toStringAsFixed(2)}\n$formula',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => setState(() => showTheory = !showTheory),
            child: const Text('Toggle Theory'),
          ),
          ElevatedButton(
            onPressed: () => setState(() => showLabels = !showLabels),
            child: const Text('Toggle Labels'),
          ),
          Slider(
            value: objectDistance,
            min: 10.0,
            max: 50.0,
            label: 'Object Distance (u): -$objectDistance cm',
            onChanged: (value) => setState(() => objectDistance = value),
          ),
          Slider(
            value: focalLength,
            min: 5.0,
            max: 20.0,
            label: 'Focal Length (f): $focalLength cm',
            onChanged: (value) => setState(() => focalLength = value),
          ),
          Slider(
            value: objectHeight,
            min: 1.0,
            max: 10.0,
            label: 'Object Height: $objectHeight cm',
            onChanged: (value) => setState(() => objectHeight = value),
          ),
          Text('Image Distance (v): ${imageDistance.isInfinite ? 'Infinity' : imageDistance.toStringAsFixed(2)} cm\nImage Height: $imageHeight cm'),
        ],
      ),
    );
  }
}

class LensPainter extends CustomPainter {
  final double u;
  final double f;
  final double v;
  final double progress;
  final double objectHeight;
  final double imageHeight;
  final bool showLabels;

  LensPainter(this.u, this.f, this.v, this.progress, this.objectHeight, this.imageHeight, this.showLabels);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black..strokeWidth = 2.0;
    final center = Offset(size.width / 2, size.height / 2);
    // Draw optical axis
    canvas.drawLine(Offset(0, center.dy), Offset(size.width, center.dy), paint);
    // Draw lens (convex shape)
    paint.style = ui.PaintingStyle.stroke;
    canvas.drawArc(Rect.fromCenter(center: center, width: 20, height: 100), pi / 2, pi, false, paint);
    canvas.drawArc(Rect.fromCenter(center: center, width: 20, height: 100), pi / 2 + pi, pi, false, paint);
    // Draw object (arrow)
    double scale = size.width / 200; // Adjusted for better fit
    double objX = center.dx - u * scale;
    canvas.drawLine(Offset(objX, center.dy), Offset(objX, center.dy - objectHeight * scale), paint);
    // Draw image (arrow)
    if (v.isFinite) {
      double imgX = center.dx + v * scale;
      double imgDir = v > 0 ? 1 : -1; // Inverted if real
      canvas.drawLine(Offset(imgX, center.dy), Offset(imgX, center.dy + objectHeight * scale * imgDir), paint);
    }
    // Draw focal points
    canvas.drawCircle(Offset(center.dx + f * scale, center.dy), 3, paint);
    canvas.drawCircle(Offset(center.dx - f * scale, center.dy), 3, paint);
    // Animate rays
    double rayProgress = progress * (v.isInfinite ? 1 : 2);
    paint.color = Colors.red; // Ray color
    // Ray 1: Parallel to axis, through focal after lens
    double parStartY = center.dy - objectHeight * scale;
    canvas.drawLine(Offset(objX, parStartY), Offset(center.dx, parStartY), paint);
    if (rayProgress > 1 && v.isFinite) {
      double focusAngle = atan(objectHeight * scale / v / scale);
      double focusEndX = center.dx + (v * scale) * (rayProgress - 1).clamp(0, 1);
      double focusEndY = parStartY + (center.dy - parStartY + imageHeight * scale * (focusEndX - center.dx) / v / scale) * (rayProgress - 1).clamp(0, 1);
      canvas.drawLine(Offset(center.dx, parStartY), Offset(focusEndX, focusEndY), paint);
    } else if (v.isInfinite) {
      canvas.drawLine(Offset(center.dx, parStartY), Offset(center.dx + f * scale, center.dy), paint);
    }
    // Ray 2: Through center, undeviated
    double cenEndX = objX + (center.dx + v * scale - objX) * rayProgress.clamp(0, 1);
    double cenEndY = parStartY + (center.dy + imageHeight * scale - parStartY) * rayProgress.clamp(0, 1);
    canvas.drawLine(Offset(objX, parStartY), Offset(cenEndX, cenEndY), paint);
    // Ray 3: Through focal, parallel after lens
    paint.color = Colors.green;
    double focStart = (center.dy - parStartY) / u * f + parStartY;
    canvas.drawLine(Offset(objX, parStartY), Offset(center.dx, focStart), paint);
    if (rayProgress > 1 && v.isFinite) {
      double parEndX = center.dx + (v * scale) * (rayProgress - 1).clamp(0, 1);
      canvas.drawLine(Offset(center.dx, focStart), Offset(parEndX, focStart), paint);
    }
    // Labels if enabled
    if (showLabels) {
      final textPainter = TextPainter(text: const TextSpan(text: 'O'), textDirection: ui.TextDirection.ltr)..layout()..paint(canvas, Offset(objX - 10, center.dy + 5));
      final fLabel = TextPainter(text: const TextSpan(text: 'F'), textDirection: ui.TextDirection.ltr)..layout()..paint(canvas, Offset(center.dx + f * scale - 5, center.dy + 5));
      if (v.isFinite) {
        final iLabel = TextPainter(text: const TextSpan(text: 'I'), textDirection: ui.TextDirection.ltr)..layout()..paint(canvas, Offset(center.dx + v * scale - 10, center.dy + 5));
      }
      final lensLabel = TextPainter(text: const TextSpan(text: 'Convex Lens'), textDirection: ui.TextDirection.ltr)..layout()..paint(canvas, Offset(center.dx - 30, center.dy - 30));
    }
  }

  @override
  bool shouldRepaint(covariant LensPainter oldDelegate) => true;
}

class ConcaveMirrorSimulation extends StatefulWidget {
  const ConcaveMirrorSimulation({super.key});

  @override
  State<ConcaveMirrorSimulation> createState() => _ConcaveMirrorSimulationState();
}

class _ConcaveMirrorSimulationState extends State<ConcaveMirrorSimulation> with TickerProviderStateMixin {
  double objectDistance = 20.0; // u in cm
  double focalLength = 10.0; // f in cm
  double objectHeight = 5.0; // cm
  bool showTheory = false;
  bool showLabels = true;
  late AnimationController _controller;

  double getImageDistance() {
    try {
      return 1 / (1 / focalLength + 1 / objectDistance); // Mirror formula: 1/v + 1/u = 1/f, u positive for object
    } catch (e) {
      return double.infinity;
    }
  }

  double getMagnification() {
    double v = getImageDistance();
    return -v / objectDistance; // m = -v/u
  }

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
    double imageDistance = getImageDistance();
    double magnification = getMagnification();
    double imageHeight = objectHeight * magnification.abs();
    String nature = imageDistance > 0 ? 'Real, Inverted' : 'Virtual, Erect';
    String formula = 'Mirror Formula: 1/v + 1/u = 1/f\nMagnification m = -v/u';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Concave Mirror Simulation'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      objectDistance -= details.delta.dx / 10; // Drag to change (note sign for mirror)
                      objectDistance = objectDistance.clamp(10.0, 50.0);
                    });
                  },
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: MirrorPainter(objectDistance, focalLength, imageDistance, _controller.value, objectHeight, imageHeight, showLabels),
                      );
                    },
                  ),
                ),
                if (showTheory)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      color: Colors.white.withOpacity(0.8),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Theory: Concave mirror converges light.\nSteps: 1. Place object. 2. Trace rays. 3. Find image.\nObservations: $nature, m = ${magnification.toStringAsFixed(2)}\n$formula',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => setState(() => showTheory = !showTheory),
            child: const Text('Toggle Theory'),
          ),
          ElevatedButton(
            onPressed: () => setState(() => showLabels = !showLabels),
            child: const Text('Toggle Labels'),
          ),
          Slider(
            value: objectDistance,
            min: 10.0,
            max: 50.0,
            label: 'Object Distance (u): $objectDistance cm',
            onChanged: (value) => setState(() => objectDistance = value),
          ),
          Slider(
            value: focalLength,
            min: 5.0,
            max: 20.0,
            label: 'Focal Length (f): -$focalLength cm',
            onChanged: (value) => setState(() => focalLength = value),
          ),
          Slider(
            value: objectHeight,
            min: 1.0,
            max: 10.0,
            label: 'Object Height: $objectHeight cm',
            onChanged: (value) => setState(() => objectHeight = value),
          ),
          Text('Image Distance (v): ${imageDistance.isInfinite ? 'Infinity' : imageDistance.toStringAsFixed(2)} cm\nImage Height: $imageHeight cm'),
        ],
      ),
    );
  }
}

class MirrorPainter extends CustomPainter {
  final double u;
  final double f;
  final double v;
  final double progress;
  final double objectHeight;
  final double imageHeight;
  final bool showLabels;

  MirrorPainter(this.u, this.f, this.v, this.progress, this.objectHeight, this.imageHeight, this.showLabels);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black..strokeWidth = 2.0;
    final center = Offset(size.width / 2, size.height / 2);
    // Draw optical axis
    canvas.drawLine(Offset(0, center.dy), Offset(size.width, center.dy), paint);
    // Draw concave mirror (arc)
    paint.style = ui.PaintingStyle.stroke;
    final mirrorCenter = Offset(center.dx - 50, center.dy);
    canvas.drawArc(Rect.fromCenter(center: mirrorCenter, width: 200, height: 200), pi - pi / 3, 2 * pi / 3, false, paint);
    // Draw object
    double scale = size.width / 200;
    double objX = center.dx + u * scale;
    canvas.drawLine(Offset(objX, center.dy), Offset(objX, center.dy - objectHeight * scale), paint);
    // Draw image
    if (v.isFinite) {
      double imgX = center.dx + v * scale;
      double imgDir = v > 0 ? 1 : -1;
      canvas.drawLine(Offset(imgX, center.dy), Offset(imgX, center.dy + objectHeight * scale * imgDir), paint);
    }
    // Draw focal point
    canvas.drawCircle(Offset(center.dx + f * scale, center.dy), 3, paint);
    // Animate rays
    double rayProgress = progress * (v.isInfinite ? 1 : 2);
    paint.color = Colors.red;
    // Ray 1: Parallel to axis, reflects through focal
    double parStartY = center.dy - objectHeight * scale;
    canvas.drawLine(Offset(objX, parStartY), Offset(center.dx, parStartY), paint);
    if (rayProgress > 1 && v.isFinite) {
      double refEndX = center.dx + (v * scale) * (rayProgress - 1).clamp(0, 1);
      double refEndY = parStartY + (center.dy - parStartY + imageHeight * scale * (refEndX - center.dx) / v / scale) * (rayProgress - 1).clamp(0, 1);
      canvas.drawLine(Offset(center.dx, parStartY), Offset(refEndX, refEndY), paint);
    }
    // Ray 2: Through focal, reflects parallel
    paint.color = Colors.green;
    double focAngle = atan(objectHeight * scale / (u - f) / scale);
    double focEndY = parStartY + (center.dy - parStartY) * (f / u);
    canvas.drawLine(Offset(objX, parStartY), Offset(center.dx, focEndY), paint);
    if (rayProgress > 1 && v.isFinite) {
      double parEndX = center.dx + (v * scale) * (rayProgress - 1).clamp(0, 1);
      canvas.drawLine(Offset(center.dx, focEndY), Offset(parEndX, focEndY), paint);
    }
    // Labels if enabled
    if (showLabels) {
      final textPainter = TextPainter(text: const TextSpan(text: 'O'), textDirection: ui.TextDirection.ltr)..layout()..paint(canvas, Offset(objX - 10, center.dy + 5));
      final fLabel = TextPainter(text: const TextSpan(text: 'F'), textDirection: ui.TextDirection.ltr)..layout()..paint(canvas, Offset(center.dx + f * scale - 5, center.dy + 5));
      if (v.isFinite) {
        final iLabel = TextPainter(text: const TextSpan(text: 'I'), textDirection: ui.TextDirection.ltr)..layout()..paint(canvas, Offset(center.dx + v * scale - 10, center.dy + 5));
      }
      final mirrorLabel = TextPainter(text: const TextSpan(text: 'Concave Mirror'), textDirection: ui.TextDirection.ltr)..layout()..paint(canvas, Offset(center.dx - 100, center.dy - 30));
    }
  }

  @override
  bool shouldRepaint(covariant MirrorPainter oldDelegate) => true;
}

class DensitySimulation extends StatefulWidget {
  const DensitySimulation({super.key});

  @override
  State<DensitySimulation> createState() => _DensitySimulationState();
}

class _DensitySimulationState extends State<DensitySimulation> with TickerProviderStateMixin {
  double mass = 100.0; // g
  double volume = 50.0; // cm³
  late AnimationController _controller;
  bool showTheory = false;

  double getDensity() {
    return mass / volume;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formula = 'Density ρ = mass / volume';
    return Scaffold(
      appBar: AppBar(title: const Text('Measuring Density')),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: DensityPainter(mass, volume, _controller.value),
                      child: Center(
                        child: Text('Density: ${getDensity().toStringAsFixed(2)} g/cm³\n$formula'),
                      ),
                    );
                  },
                ),
                if (showTheory)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      color: Colors.white.withOpacity(0.8),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Theory: Mass per unit volume.\nSteps: 1. Measure mass with balance. 2. Measure volume by displacement. 3. Calculate ρ.\nObservations: Compare to water (1 g/cm³).',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => setState(() => showTheory = !showTheory),
            child: const Text('Toggle Theory'),
          ),
          Slider(
            value: mass,
            min: 50.0,
            max: 200.0,
            label: 'Mass: $mass g',
            onChanged: (value) => setState(() => mass = value),
          ),
          Slider(
            value: volume,
            min: 20.0,
            max: 100.0,
            label: 'Volume: $volume cm³',
            onChanged: (value) => setState(() => volume = value),
          ),
        ],
      ),
    );
  }
}

class DensityPainter extends CustomPainter {
  final double mass;
  final double volume;
  final double progress;

  DensityPainter(this.mass, this.volume, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black..strokeWidth = 2.0;
    // Draw balance scale for mass
    canvas.drawLine(Offset(size.width / 4, size.height / 4), Offset(size.width / 4, size.height / 2), paint); // Stand
    double tilt = (mass / 200) * 10 * sin(progress); // Animating tilt
    canvas.drawLine(Offset(size.width / 4 - 50, size.height / 4 + tilt), Offset(size.width / 4 + 50, size.height / 4 - tilt), paint);
    paint.color = Colors.grey;
    canvas.drawRect(Rect.fromLTWH(size.width / 4 + 30, size.height / 4 - tilt, 20, mass / 2), paint); // Weight
    // Draw displacement can for volume
    paint.color = Colors.blue;
    canvas.drawRect(Rect.fromLTWH(size.width * 3 / 4 - 50, size.height / 2, 100, 100), paint); // Water
    paint.color = Colors.brown;
    double submersion = (volume / 100) * 80 * (1 + 0.1 * sin(progress)); // Animating bob
    canvas.drawRect(Rect.fromLTWH(size.width * 3 / 4 - 20, size.height / 2 + 100 - submersion, 40, submersion), paint); // Object
    // Labels
    final massLabel = TextPainter(text: const TextSpan(text: 'Mass Balance'), textDirection: ui.TextDirection.ltr)..layout()..paint(canvas, Offset(size.width / 4 - 50, size.height / 4 - 50));
    final volLabel = TextPainter(text: const TextSpan(text: 'Volume Displacement'), textDirection: ui.TextDirection.ltr)..layout()..paint(canvas, Offset(size.width * 3 / 4 - 100, size.height / 2 - 50));
  }

  @override
  bool shouldRepaint(covariant DensityPainter oldDelegate) => true;
}