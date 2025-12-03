import 'package:flutter/material.dart';
import 'dart:math';

class HigherMathExperimentsPage extends StatelessWidget {
  const HigherMathExperimentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Higher Math Experiments'),
        backgroundColor: Colors.blue[800],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFBBDEFB),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildExperimentCard(
              context,
              'Linear Equations Graph',
              'y = mx + c: how slope and intercept affect the line',
              Icons.show_chart,
              Colors.blue,
              const LinearGraphSimulation(),
            ),
            _buildExperimentCard(
              context,
              'Quadratic Equations Graph',
              'y = ax² + bx + c: parabolas, vertices, and roots',
              Icons.architecture,
              Colors.green,
              const QuadraticGraphSimulation(),
            ),
            _buildExperimentCard(
              context,
              'Conic Sections',
              'Ellipses, Circles, Parabolas: cross-sections of cones',
              Icons.circle,
              Colors.orange,
              const ConicSectionsSimulation(),
            ),
            _buildExperimentCard(
              context,
              'Exponential & Logarithmic Functions',
              'Growth, decay, and their inverse relationships',
              Icons.trending_up,
              Colors.red,
              const ExponentialGraphSimulation(),
            ),
            _buildExperimentCard(
              context,
              'Vector Operations',
              'Addition, subtraction, and magnitude in 2D space',
              Icons.arrow_forward,
              Colors.purple,
              const VectorSimulation(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperimentCard(BuildContext context, String title,
      String description, IconData icon, Color color, Widget page) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        ),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
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
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Linear Equations Graph Simulation
class LinearGraphSimulation extends StatefulWidget {
  const LinearGraphSimulation({super.key});

  @override
  State<LinearGraphSimulation> createState() => _LinearGraphSimulationState();
}

class _LinearGraphSimulationState extends State<LinearGraphSimulation> {
  double m = 1.0; // slope
  double c = 0.0; // y-intercept

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Linear Equations: y = mx + c'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: CustomPaint(
                painter: LinearGraphPainter(m, c),
                child: Container(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Equation: y = ${m.toStringAsFixed(2)}x + ${c.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildSlider('Slope (m)', m, -3, 3, (value) {
                  setState(() => m = value);
                }),
                _buildSlider('Y-intercept (c)', c, -5, 5, (value) {
                  setState(() => c = value);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max,
      Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ${value.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: 80,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class LinearGraphPainter extends CustomPainter {
  final double m;
  final double c;

  LinearGraphPainter(this.m, this.c);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5.0;

    final gridPaint = Paint()
      ..color = Colors.grey[500]!
      ..strokeWidth = 2.0;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final scale = 40.0;

    // Draw grid
    for (double i = -10; i <= 10; i++) {
      canvas.drawLine(
        Offset(centerX + i * scale, 0),
        Offset(centerX + i * scale, size.height),
        gridPaint,
      );
      canvas.drawLine(
        Offset(0, centerY + i * scale),
        Offset(size.width, centerY + i * scale),
        gridPaint,
      );
    }

    // Draw axes
    canvas.drawLine(
      Offset(centerX, 0),
      Offset(centerX, size.height),
      axisPaint,
    );
    canvas.drawLine(
      Offset(0, centerY),
      Offset(size.width, centerY),
      axisPaint,
    );

    // Draw linear function
    final path = Path();
    for (double x = -10; x <= 10; x += 0.1) {
      double y = m * x + c;
      if (y.abs() <= 10) {
        double screenX = centerX + x * scale;
        double screenY = centerY - y * scale;
        if (x == -10) {
          path.moveTo(screenX, screenY);
        } else {
          path.lineTo(screenX, screenY);
        }
      }
    }
    canvas.drawPath(path, linePaint);

    // Draw point at y-intercept
    final pointPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(centerX, centerY - c * scale),
      6,
      pointPaint,
    );

    // Draw labels
    final textStyle = TextStyle(color: Colors.black, fontSize: 12);
    _drawText(canvas, 'y', centerX + 10, 20, textStyle);
    _drawText(canvas, 'x', size.width - 20, centerY + 20, textStyle);
  }

  void _drawText(Canvas canvas, String text, double x, double y, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Quadratic Graph Simulation
class QuadraticGraphSimulation extends StatefulWidget {
  const QuadraticGraphSimulation({super.key});

  @override
  State<QuadraticGraphSimulation> createState() =>
      _QuadraticGraphSimulationState();
}

class _QuadraticGraphSimulationState extends State<QuadraticGraphSimulation> {
  double a = 1.0;
  double b = 0.0;
  double c = 0.0;

  @override
  Widget build(BuildContext context) {
    double discriminant = b * b - 4 * a * c;
    double vertexX = -b / (2 * a);
    double vertexY = a * vertexX * vertexX + b * vertexX + c;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quadratic Equations: y = ax² + bx + c'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: CustomPaint(
                painter: QuadraticGraphPainter(a, b, c),
                child: Container(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Equation: y = ${a.toStringAsFixed(2)}x² + ${b.toStringAsFixed(2)}x + ${c.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Vertex: (${vertexX.toStringAsFixed(2)}, ${vertexY.toStringAsFixed(2)})',
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  'Discriminant: ${discriminant.toStringAsFixed(2)} ${discriminant > 0 ? "(2 real roots)" : discriminant == 0 ? "(1 real root)" : "(no real roots)"}',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                _buildSlider('a', a, -2, 2, (value) {
                  if (value.abs() > 0.1) setState(() => a = value);
                }),
                _buildSlider('b', b, -5, 5, (value) {
                  setState(() => b = value);
                }),
                _buildSlider('c', c, -5, 5, (value) {
                  setState(() => c = value);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max,
      Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ${value.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: 100,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class QuadraticGraphPainter extends CustomPainter {
  final double a;
  final double b;
  final double c;

  QuadraticGraphPainter(this.a, this.b, this.c);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5.0;

    final gridPaint = Paint()
      ..color = Colors.grey[500]!
      ..strokeWidth = 2.0;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final scale = 40.0;

    // Draw grid
    for (double i = -10; i <= 10; i++) {
      canvas.drawLine(
        Offset(centerX + i * scale, 0),
        Offset(centerX + i * scale, size.height),
        gridPaint,
      );
      canvas.drawLine(
        Offset(0, centerY + i * scale),
        Offset(size.width, centerY + i * scale),
        gridPaint,
      );
    }

    // Draw axes
    canvas.drawLine(
      Offset(centerX, 0),
      Offset(centerX, size.height),
      axisPaint,
    );
    canvas.drawLine(
      Offset(0, centerY),
      Offset(size.width, centerY),
      axisPaint,
    );

    // Draw quadratic function
    final path = Path();
    bool started = false;
    for (double x = -10; x <= 10; x += 0.1) {
      double y = a * x * x + b * x + c;
      if (y.abs() <= 15) {
        double screenX = centerX + x * scale;
        double screenY = centerY - y * scale;
        if (!started) {
          path.moveTo(screenX, screenY);
          started = true;
        } else {
          path.lineTo(screenX, screenY);
        }
      }
    }
    canvas.drawPath(path, linePaint);

    // Draw vertex
    double vertexX = -b / (2 * a);
    double vertexY = a * vertexX * vertexX + b * vertexX + c;
    final pointPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(centerX + vertexX * scale, centerY - vertexY * scale),
      6,
      pointPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Conic Sections Simulation
class ConicSectionsSimulation extends StatefulWidget {
  const ConicSectionsSimulation({super.key});

  @override
  State<ConicSectionsSimulation> createState() =>
      _ConicSectionsSimulationState();
}

class _ConicSectionsSimulationState extends State<ConicSectionsSimulation> {
  String type = 'Circle';
  double a = 3.0;
  double b = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conic Sections'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: CustomPaint(
                painter: ConicSectionPainter(type, a, b),
                child: Container(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              children: [
                DropdownButton<String>(
                  value: type,
                  items: ['Circle', 'Ellipse', 'Parabola', 'Hyperbola']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => setState(() => type = value!),
                ),
                const SizedBox(height: 10),
                if (type != 'Parabola') ...[
                  _buildSlider('a', a, 1, 5, (value) {
                    setState(() => a = value);
                  }),
                  if (type != 'Circle')
                    _buildSlider('b', b, 1, 5, (value) {
                      setState(() => b = value);
                    }),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max,
      Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ${value.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: 40,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class ConicSectionPainter extends CustomPainter {
  final String type;
  final double a;
  final double b;

  ConicSectionPainter(this.type, this.a, this.b);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5.0;

    final gridPaint = Paint()
      ..color = Colors.grey[500]!
      ..strokeWidth = 2.0;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final scale = 40.0;

    // Draw grid
    for (double i = -10; i <= 10; i++) {
      canvas.drawLine(
        Offset(centerX + i * scale, 0),
        Offset(centerX + i * scale, size.height),
        gridPaint,
      );
      canvas.drawLine(
        Offset(0, centerY + i * scale),
        Offset(size.width, centerY + i * scale),
        gridPaint,
      );
    }

    // Draw axes
    canvas.drawLine(
      Offset(centerX, 0),
      Offset(centerX, size.height),
      axisPaint,
    );
    canvas.drawLine(
      Offset(0, centerY),
      Offset(size.width, centerY),
      axisPaint,
    );

    // Draw conic section
    if (type == 'Circle') {
      canvas.drawCircle(Offset(centerX, centerY), a * scale, linePaint);
    } else if (type == 'Ellipse') {
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: a * scale * 2,
          height: b * scale * 2,
        ),
        linePaint,
      );
    } else if (type == 'Parabola') {
      final path = Path();
      for (double x = -10; x <= 10; x += 0.1) {
        double y = x * x / 4;
        if (y <= 10) {
          double screenX = centerX + x * scale;
          double screenY = centerY - y * scale;
          if (x == -10) {
            path.moveTo(screenX, screenY);
          } else {
            path.lineTo(screenX, screenY);
          }
        }
      }
      canvas.drawPath(path, linePaint);
    } else if (type == 'Hyperbola') {
      final path1 = Path();
      final path2 = Path();
      bool started1 = false;
      bool started2 = false;

      for (double x = a; x <= 10; x += 0.1) {
        double y = b * sqrt((x * x) / (a * a) - 1);
        double screenX = centerX + x * scale;
        double screenY1 = centerY - y * scale;
        double screenY2 = centerY + y * scale;

        if (!started1) {
          path1.moveTo(screenX, screenY1);
          path2.moveTo(screenX, screenY2);
          started1 = true;
          started2 = true;
        } else {
          path1.lineTo(screenX, screenY1);
          path2.lineTo(screenX, screenY2);
        }
      }

      for (double x = -a; x >= -10; x -= 0.1) {
        double y = b * sqrt((x * x) / (a * a) - 1);
        double screenX = centerX + x * scale;
        double screenY1 = centerY - y * scale;
        double screenY2 = centerY + y * scale;

        path1.lineTo(screenX, screenY1);
        path2.lineTo(screenX, screenY2);
      }

      canvas.drawPath(path1, linePaint);
      canvas.drawPath(path2, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Exponential & Logarithmic Graph Simulation
class ExponentialGraphSimulation extends StatefulWidget {
  const ExponentialGraphSimulation({super.key});

  @override
  State<ExponentialGraphSimulation> createState() =>
      _ExponentialGraphSimulationState();
}

class _ExponentialGraphSimulationState
    extends State<ExponentialGraphSimulation> {
  double base = 2.0;
  bool isExponential = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isExponential ? 'Exponential: y = a^x' : 'Logarithmic: y = log_a(x)'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: CustomPaint(
                painter: ExponentialGraphPainter(base, isExponential),
                child: Container(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(isExponential ? 'Exponential' : 'Logarithmic'),
                  value: isExponential,
                  onChanged: (value) => setState(() => isExponential = value),
                ),
                _buildSlider('Base (a)', base, 1.1, 5, (value) {
                  setState(() => base = value);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max,
      Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ${value.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: 39,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class ExponentialGraphPainter extends CustomPainter {
  final double base;
  final bool isExponential;

  ExponentialGraphPainter(this.base, this.isExponential);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5.0;

    final gridPaint = Paint()
      ..color = Colors.grey[500]!
      ..strokeWidth = 2.0;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final scale = 40.0;

    // Draw grid
    for (double i = -10; i <= 10; i++) {
      canvas.drawLine(
        Offset(centerX + i * scale, 0),
        Offset(centerX + i * scale, size.height),
        gridPaint,
      );
      canvas.drawLine(
        Offset(0, centerY + i * scale),
        Offset(size.width, centerY + i * scale),
        gridPaint,
      );
    }

    // Draw axes
    canvas.drawLine(
      Offset(centerX, 0),
      Offset(centerX, size.height),
      axisPaint,
    );
    canvas.drawLine(
      Offset(0, centerY),
      Offset(size.width, centerY),
      axisPaint,
    );

    // Draw function
    final path = Path();
    bool started = false;

    if (isExponential) {
      for (double x = -10; x <= 10; x += 0.1) {
        double y = pow(base, x).toDouble();
        if (y <= 100 && y >= -100) {
          double screenX = centerX + x * scale;
          double screenY = centerY - y * scale;
          if (screenY >= 0 && screenY <= size.height) {
            if (!started) {
              path.moveTo(screenX, screenY);
              started = true;
            } else {
              path.lineTo(screenX, screenY);
            }
          }
        }
      }
    } else {
      for (double x = 0.01; x <= 10; x += 0.1) {
        double y = log(x) / log(base);
        if (y.abs() <= 10) {
          double screenX = centerX + x * scale;
          double screenY = centerY - y * scale;
          if (!started) {
            path.moveTo(screenX, screenY);
            started = true;
          } else {
            path.lineTo(screenX, screenY);
          }
        }
      }
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Vector Operations Simulation
class VectorSimulation extends StatefulWidget {
  const VectorSimulation({super.key});

  @override
  State<VectorSimulation> createState() => _VectorSimulationState();
}

class _VectorSimulationState extends State<VectorSimulation> {
  double v1x = 3.0;
  double v1y = 2.0;
  double v2x = 1.0;
  double v2y = 3.0;
  String operation = 'Addition';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vector Operations'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: CustomPaint(
                painter: VectorPainter(v1x, v1y, v2x, v2y, operation),
                child: Container(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              children: [
                DropdownButton<String>(
                  value: operation,
                  items: ['Addition', 'Subtraction']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => setState(() => operation = value!),
                ),
                const SizedBox(height: 10),
                Text('Vector 1: (${v1x.toStringAsFixed(1)}, ${v1y.toStringAsFixed(1)})'),
                _buildSlider('v1x', v1x, -5, 5, (value) {
                  setState(() => v1x = value);
                }),
                _buildSlider('v1y', v1y, -5, 5, (value) {
                  setState(() => v1y = value);
                }),
                const SizedBox(height: 10),
                Text('Vector 2: (${v2x.toStringAsFixed(1)}, ${v2y.toStringAsFixed(1)})'),
                _buildSlider('v2x', v2x, -5, 5, (value) {
                  setState(() => v2x = value);
                }),
                _buildSlider('v2y', v2y, -5, 5, (value) {
                  setState(() => v2y = value);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max,
      Function(double) onChanged) {
    return Slider(
      value: value,
      min: min,
      max: max,
      divisions: 100,
      onChanged: onChanged,
    );
  }
}

class VectorPainter extends CustomPainter {
  final double v1x, v1y, v2x, v2y;
  final String operation;

  VectorPainter(this.v1x, this.v1y, this.v2x, this.v2y, this.operation);

  @override
  void paint(Canvas canvas, Size size) {
    final v1Paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    final v2Paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    final resultPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5.0;

    final gridPaint = Paint()
      ..color = Colors.grey[500]!
      ..strokeWidth = 2.0;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final scale = 40.0;

    // Draw grid
    for (double i = -10; i <= 10; i++) {
      canvas.drawLine(
        Offset(centerX + i * scale, 0),
        Offset(centerX + i * scale, size.height),
        gridPaint,
      );
      canvas.drawLine(
        Offset(0, centerY + i * scale),
        Offset(size.width, centerY + i * scale),
        gridPaint,
      );
    }

    // Draw axes
    canvas.drawLine(
      Offset(centerX, 0),
      Offset(centerX, size.height),
      axisPaint,
    );
    canvas.drawLine(
      Offset(0, centerY),
      Offset(size.width, centerY),
      axisPaint,
    );

    // Draw vector 1
    _drawArrow(
      canvas,
      Offset(centerX, centerY),
      Offset(centerX + v1x * scale, centerY - v1y * scale),
      v1Paint,
    );

    // Draw vector 2
    _drawArrow(
      canvas,
      Offset(centerX, centerY),
      Offset(centerX + v2x * scale, centerY - v2y * scale),
      v2Paint,
    );

    // Calculate and draw result
    double resultX, resultY;
    if (operation == 'Addition') {
      resultX = v1x + v2x;
      resultY = v1y + v2y;
    } else {
      resultX = v1x - v2x;
      resultY = v1y - v2y;
    }

    _drawArrow(
      canvas,
      Offset(centerX, centerY),
      Offset(centerX + resultX * scale, centerY - resultY * scale),
      resultPaint,
    );

    // Draw labels
    final textStyle = TextStyle(color: Colors.black, fontSize: 12);
    _drawText(canvas, 'v1', centerX + v1x * scale / 2, centerY - v1y * scale / 2, textStyle);
    _drawText(canvas, 'v2', centerX + v2x * scale / 2, centerY - v2y * scale / 2, textStyle);
    _drawText(canvas, 'Result', centerX + resultX * scale / 2, centerY - resultY * scale / 2, textStyle);
  }

  void _drawArrow(Canvas canvas, Offset start, Offset end, Paint paint) {
    canvas.drawLine(start, end, paint);

    // Draw arrowhead
    final direction = (end - start);
    final length = direction.distance;
    if (length > 0) {
      final unitDirection = direction / length;
      final perpendicular = Offset(-unitDirection.dy, unitDirection.dx);

      final arrowSize = 15.0;
      final p1 = end - unitDirection * arrowSize + perpendicular * arrowSize / 2;
      final p2 = end - unitDirection * arrowSize - perpendicular * arrowSize / 2;

      final arrowPath = Path()
        ..moveTo(end.dx, end.dy)
        ..lineTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy)
        ..close();

      canvas.drawPath(arrowPath, paint..style = PaintingStyle.fill);
      paint.style = PaintingStyle.stroke;
    }
  }

  void _drawText(Canvas canvas, String text, double x, double y, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
