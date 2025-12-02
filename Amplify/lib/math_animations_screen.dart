
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

class MathAnimationsScreen extends StatefulWidget {
  const MathAnimationsScreen({super.key});

  @override
  State<MathAnimationsScreen> createState() => _MathAnimationsScreenState();
}

class _MathAnimationsScreenState extends State<MathAnimationsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pendulumController;
  late final AnimationController _fourierController;
  late final AnimationController _unitCircleController;
  late final AnimationController _trigController;

  @override
  void initState() {
    super.initState();

    _pendulumController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _fourierController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _unitCircleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _trigController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _pendulumController.dispose();
    _fourierController.dispose();
    _unitCircleController.dispose();
    _trigController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Math Animations'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade900.withOpacity(0.9),
                Colors.deepPurple.shade700.withOpacity(0.9),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, Colors.blueGrey.shade900],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 100, 16, 24),
          children: [
            _sectionTitle('Dual Pendulums'),
            _glassCard(
              height: 260,
              child: AnimatedBuilder(
                animation: _pendulumController,
                builder: (context, _) {
                  return CustomPaint(
                    painter: _DualPendulumPainter(_pendulumController.value),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            _sectionTitle('Fourier Series Epicycles'),
            _glassCard(
              height: 260,
              child: AnimatedBuilder(
                animation: _fourierController,
                builder: (context, _) {
                  return CustomPaint(
                    painter: _FourierSeriesPainter(_fourierController.value),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            _sectionTitle('Unit Circle & Sine'),
            _glassCard(
              height: 260,
              child: AnimatedBuilder(
                animation: _unitCircleController,
                builder: (context, _) {
                  return CustomPaint(
                    painter: _UnitCirclePainter(_unitCircleController.value),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            _sectionTitle('Trigonometric Functions'),
            _glassCard(
              height: 260,
              child: AnimatedBuilder(
                animation: _trigController,
                builder: (context, _) {
                  return CustomPaint(
                    painter: _TrigFunctionsPainter(_trigController.value),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  Widget _glassCard({required double height, required Widget child}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white24, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

/// ----------------- Dual pendulum + displacement -----------------

class _DualPendulumPainter extends CustomPainter {
  final double t; // 0..1

  _DualPendulumPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint axisPaint = Paint()
      ..color = Colors.lightBlueAccent
      ..strokeWidth = 2;

    final Paint pendulumPaint1 = Paint()
      ..color = Colors.cyanAccent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final Paint pendulumPaint2 = Paint()
      ..color = Colors.amberAccent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final Paint bobPaint1 = Paint()..color = Colors.cyanAccent;
    final Paint bobPaint2 = Paint()..color = Colors.amberAccent;

    final double top = size.height * 0.08;
    final double centerX = size.width * 0.5;
    final double length = size.height * 0.18;

    final double angle1 = 0.65 * math.sin(2 * math.pi * t);
    final double angle2 = 0.65 * math.sin(2 * math.pi * t * 1.2);

    canvas.drawLine(
      Offset(size.width * 0.15, top),
      Offset(size.width * 0.85, top),
      axisPaint,
    );

    final Offset origin = Offset(centerX, top);
    final Offset bob1 =
        origin + Offset(length * math.sin(angle1), length * math.cos(angle1));
    canvas.drawLine(origin, bob1, pendulumPaint1);
    canvas.drawCircle(bob1, 5, bobPaint1);

    final Offset bob2 =
        origin + Offset(length * math.sin(angle2), length * math.cos(angle2));
    canvas.drawLine(origin, bob2, pendulumPaint2);
    canvas.drawCircle(bob2, 5, bobPaint2);

    final double graphTop = size.height * 0.45;
    final double graphHeight = size.height * 0.45;
    final double graphLeft = size.width * 0.08;
    final double graphRight = size.width * 0.92;

    final Paint axisGraphPaint = Paint()
      ..color = Colors.white60
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(graphLeft, graphTop + graphHeight / 2),
      Offset(graphRight, graphTop + graphHeight / 2),
      axisGraphPaint,
    );
    canvas.drawLine(
      Offset(graphLeft, graphTop),
      Offset(graphLeft, graphTop + graphHeight),
      axisGraphPaint,
    );

    Path wave1 = Path();
    Path wave2 = Path();
    const int steps = 200;
    for (int i = 0; i <= steps; i++) {
      double u = i / steps;
      double phase = t * 2 * math.pi;
      double x = lerpDouble(graphLeft, graphRight, u)!;
      double y1 = graphTop +
          graphHeight / 2 -
          (graphHeight * 0.4) * math.sin(2 * math.pi * u + phase);
      double y2 = graphTop +
          graphHeight / 2 -
          (graphHeight * 0.4) * math.sin(2 * math.pi * 1.2 * u + phase);

      if (i == 0) {
        wave1.moveTo(x, y1);
        wave2.moveTo(x, y2);
      } else {
        wave1.lineTo(x, y1);
        wave2.lineTo(x, y2);
      }
    }

    final Paint wavePaint1 = Paint()
      ..color = Colors.cyanAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Paint wavePaint2 = Paint()
      ..color = Colors.amberAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawPath(wave1, wavePaint1);
    canvas.drawPath(wave2, wavePaint2);
  }

  @override
  bool shouldRepaint(covariant _DualPendulumPainter oldDelegate) =>
      oldDelegate.t != t;
}

/// ----------------- Fourier series epicycles -----------------

class _FourierSeriesPainter extends CustomPainter {
  final double t; // 0..1

  _FourierSeriesPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final double baseRadius = size.height * 0.18;
    final Offset center = Offset(size.width * 0.18, size.height * 0.5);

    final Paint bigCirclePaint = Paint()
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, baseRadius, bigCirclePaint);

    final List<int> ks = [1, 3, 5, 7, 9];
    Offset current = center;
    double angle = 2 * math.pi * t;

    final Paint smallCirclePaint = Paint()
      ..color = Colors.pinkAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final Paint radiusPaint = Paint()
      ..color = Colors.white70
      ..strokeWidth = 1;

    for (int k in ks) {
      double r = baseRadius * (4 / (math.pi * k));
      double localAngle = k * angle;

      canvas.drawCircle(current, r, smallCirclePaint);

      Offset next =
          current + Offset(r * math.cos(localAngle), -r * math.sin(localAngle));
      canvas.drawLine(current, next, radiusPaint);
      current = next;
    }

    final double graphLeft = size.width * 0.40;
    final double graphRight = size.width * 0.95;
    final double midY = size.height * 0.5;
    final double amp = baseRadius * 0.8;

    final Paint graphAxis = Paint()
      ..color = Colors.white54
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(graphLeft, midY),
      Offset(graphRight, midY),
      graphAxis,
    );

    Path wave = Path();
    const int steps = 200;
    for (int i = 0; i <= steps; i++) {
      double u = i / steps;
      double theta = 2 * math.pi * (u + t);
      double y = 0;
      for (int k in ks) {
        y += (1 / k) * math.sin(k * theta);
      }
      y = (4 / math.pi) * y;
      double xPos = lerpDouble(graphLeft, graphRight, u)!;
      double yPos = midY - amp * y.clamp(-1.2, 1.2);
      if (i == 0) {
        wave.moveTo(xPos, yPos);
      } else {
        wave.lineTo(xPos, yPos);
      }
    }

    final Paint wavePaint = Paint()
      ..color = Colors.pinkAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawPath(wave, wavePaint);
  }

  @override
  bool shouldRepaint(covariant _FourierSeriesPainter oldDelegate) =>
      oldDelegate.t != t;
}

/// ----------------- Unit circle & sine graph -----------------

class _UnitCirclePainter extends CustomPainter {
  final double t;

  _UnitCirclePainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.height * 0.35;
    final Offset center = Offset(size.width * 0.33, size.height * 0.5);

    final Paint circlePaint = Paint()
      ..color = Colors.lightBlueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Paint axisPaint = Paint()
      ..color = Colors.white54
      ..strokeWidth = 1;

    final Paint anglePaint = Paint()
      ..color = Colors.amberAccent
      ..strokeWidth = 2;

    final Paint pointPaint = Paint()..color = Colors.redAccent;

    canvas.drawLine(
      Offset(center.dx - radius - 10, center.dy),
      Offset(center.dx + radius + 10, center.dy),
      axisPaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - radius - 10),
      Offset(center.dx, center.dy + radius + 10),
      axisPaint,
    );

    canvas.drawCircle(center, radius, circlePaint);

    double theta = 2 * math.pi * t * 0.85 + 0.1;
    Offset point =
        center + Offset(radius * math.cos(theta), -radius * math.sin(theta));

    canvas.drawLine(center, point, anglePaint);

    final Paint dashPaint = Paint()
      ..color = Colors.yellowAccent
      ..strokeWidth = 1;

    const double dashLength = 5;
    const double dashSpace = 4;
    double y1 = point.dy;
    double y2 = center.dy + radius + 10;
    for (double y = y1; y < y2; y += dashLength + dashSpace) {
      canvas.drawLine(
        Offset(point.dx, y),
        Offset(point.dx, math.min(y + dashLength, y2)),
        dashPaint,
      );
    }

    canvas.drawCircle(point, 5, pointPaint);

    final double graphLeft = size.width * 0.65;
    final double graphRight = size.width * 0.95;
    final double graphTop = size.height * 0.15;
    final double graphBottom = size.height * 0.85;
    final double midY = (graphTop + graphBottom) / 2;
    final double amp = (graphBottom - graphTop) / 2.2;

    canvas.drawLine(
      Offset(graphLeft, midY),
      Offset(graphRight, midY),
      axisPaint,
    );
    canvas.drawLine(
      Offset(graphLeft, graphTop),
      Offset(graphLeft, graphBottom),
      axisPaint,
    );

    Path graph = Path();
    const int steps = 200;
    for (int i = 0; i <= steps; i++) {
      double u = i / steps;
      double th = 2 * math.pi * u;
      double y = math.sin(th);
      double x = lerpDouble(graphLeft, graphRight, u)!;
      double yPos = midY - amp * y;
      if (i == 0) {
        graph.moveTo(x, yPos);
      } else {
        graph.lineTo(x, yPos);
      }
    }

    final Paint graphPaint = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawPath(graph, graphPaint);

    double uTheta = (theta % (2 * math.pi)) / (2 * math.pi);
    double xOnGraph = lerpDouble(graphLeft, graphRight, uTheta)!;
    double yOnGraph = midY - amp * math.sin(theta);
    canvas.drawCircle(Offset(xOnGraph, yOnGraph), 4, pointPaint);

    canvas.drawLine(
      point,
      Offset(xOnGraph, yOnGraph),
      Paint()
        ..color = Colors.white24
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(covariant _UnitCirclePainter oldDelegate) =>
      oldDelegate.t != t;
}

/// ----------------- Trigonometric functions -----------------

class _TrigFunctionsPainter extends CustomPainter {
  final double t;

  _TrigFunctionsPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint axisPaint = Paint()
      ..color = Colors.white30
      ..strokeWidth = 1;

    final List<_TrigConfig> configs = [
      _TrigConfig(
        color: Colors.cyanAccent,
        label: 'y = cos(x)',
        frequency: 1,
        phase: 0,
      ),
      _TrigConfig(
        color: Colors.limeAccent,
        label: 'y = sin(x)',
        frequency: 1,
        phase: 0,
      ),
      _TrigConfig(
        color: Colors.orangeAccent,
        label: 'y = sin(2x)',
        frequency: 2,
        phase: 0,
      ),
      _TrigConfig(
        color: Colors.purpleAccent,
        label: 'y = cos(2x)',
        frequency: 2,
        phase: 0,
      ),
    ];

    final double padding = 8;
    final double rowHeight = (size.height - padding * 2) / configs.length;
    final double graphLeft = size.width * 0.05;
    final double graphRight = size.width * 0.78;

    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < configs.length; i++) {
      final cfg = configs[i];
      double top = padding + i * rowHeight;
      double bottom = top + rowHeight;
      double midY = (top + bottom) / 2;
      double amp = rowHeight * 0.35;

      canvas.drawLine(
        Offset(graphLeft, midY),
        Offset(graphRight, midY),
        axisPaint,
      );
      canvas.drawLine(
        Offset((graphLeft + graphRight) / 2, top + 4),
        Offset((graphLeft + graphRight) / 2, bottom - 4),
        axisPaint,
      );

      Path path = Path();
      const int steps = 200;
      for (int j = 0; j <= steps; j++) {
        double u = j / steps;
        double x = lerpDouble(graphLeft, graphRight, u)!;

        double xAngle = lerpDouble(-math.pi, math.pi, u)!;
        double yVal;
        if (cfg.label.contains('cos')) {
          yVal = math.cos(cfg.frequency * xAngle + 2 * math.pi * t * 0.1);
        } else {
          yVal = math.sin(cfg.frequency * xAngle + 2 * math.pi * t * 0.1);
        }

        double y = midY - amp * yVal;
        if (j == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      final Paint curvePaint = Paint()
        ..color = cfg.color
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

      canvas.drawPath(path, curvePaint);

      textPainter.text = TextSpan(
        text: cfg.label,
        style: TextStyle(
          color: cfg.color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(graphRight + 6, midY - textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TrigFunctionsPainter oldDelegate) =>
      oldDelegate.t != t;
}

class _TrigConfig {
  final Color color;
  final String label;
  final double frequency;
  final double phase;

  _TrigConfig({
    required this.color,
    required this.label,
    required this.frequency,
    required this.phase,
  });
}
