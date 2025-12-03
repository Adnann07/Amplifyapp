import 'package:flutter/material.dart';
import 'dart:math';

class HscMathPage extends StatefulWidget {
  const HscMathPage({super.key});

  @override
  State<HscMathPage> createState() => _HscMathPageState();
}

class _HscMathPageState extends State<HscMathPage> {
  double a = 1;
  double b = 1;
  double c = 0;
  double h = 0; // For translations / conics
  double k = 0;

  String selectedType = "Quadratic";

  // For optional second function intersection
  String selectedType2 = "Linear";
  double a2 = 1;
  double b2 = 0;
  double c2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Advanced Math Visualizations"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // ▼ Dropdown for first function
            Padding(
              padding: const EdgeInsets.all(12),
              child: DropdownButton<String>(
                value: selectedType,
                items: const [
                  DropdownMenuItem(value: "Linear", child: Text("Linear (ax + b)")),
                  DropdownMenuItem(value: "Quadratic", child: Text("Quadratic (ax² + bx + c)")),
                  DropdownMenuItem(value: "Cubic", child: Text("Cubic (x³)")),
                  DropdownMenuItem(value: "Sine", child: Text("Sine (a·sin(bx + c))")),
                  DropdownMenuItem(value: "Cosine", child: Text("Cosine (a·cos(bx + c))")),
                  DropdownMenuItem(value: "Tangent", child: Text("Tangent (a·tan(bx + c))")),
                  DropdownMenuItem(value: "Exponential", child: Text("Exponential (a·e^(bx))")),
                  DropdownMenuItem(value: "Logarithmic", child: Text("Logarithmic (log_b(a·x))")),
                  DropdownMenuItem(value: "Absolute", child: Text("Absolute Value |ax+b|")),
                  DropdownMenuItem(value: "GreatestInteger", child: Text("Greatest Integer [ax+b]")),
                  DropdownMenuItem(value: "Circle", child: Text("Circle (x-h)²+(y-k)²=r²")),
                  DropdownMenuItem(value: "Ellipse", child: Text("Ellipse ((x-h)²/a²+(y-k)²/b²=1)")),
                  DropdownMenuItem(value: "Parabola", child: Text("Parabola y=ax²+bx+c")),
                  DropdownMenuItem(value: "Hyperbola", child: Text("Hyperbola x²/a²-y²/b²=1")),
                ],
                onChanged: (value) {
                  setState(() => selectedType = value!);
                },
              ),
            ),

            // ▼ Graph Canvas
            Container(
              margin: const EdgeInsets.all(12),
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black26)],
              ),
              child: CustomPaint(
                painter: MathPainter(
                  a, b, c, h, k, selectedType,
                  a2: a2, b2: b2, c2: c2, type2: selectedType2,
                ),
                child: Container(),
              ),
            ),

            // ▼ Sliders for parameters
            slider("A", a, (v) => setState(() => a = v)),
            slider("B", b, (v) => setState(() => b = v)),
            slider("C", c, (v) => setState(() => c = v)),
            slider("H", h, (v) => setState(() => h = v)),
            slider("K", k, (v) => setState(() => k = v)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget slider(String label, double value, Function(double) onChanged) {
    return Column(
      children: [
        Text("$label = ${value.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18)),
        Slider(
          min: -10,
          max: 10,
          divisions: 200,
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class MathPainter extends CustomPainter {
  final double a, b, c, h, k;
  final String type;

  final double? a2, b2, c2;
  final String? type2;

  MathPainter(this.a, this.b, this.c, this.h, this.k, this.type,
      {this.a2, this.b2, this.c2, this.type2});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint axisPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;

    final Paint curvePaint = Paint()
      ..color = Colors.deepPurple
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Paint curvePaint2 = Paint()
      ..color = Colors.orange
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Paint pointPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 6
      ..style = PaintingStyle.fill;

    // Draw axes
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), axisPaint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), axisPaint);

    double scale = 20; // Zoom factor

    Path path = Path();
    Path path2 = Path();

    // First function
    bool firstPoint = true;
    for (double xPixel = 0; xPixel < size.width; xPixel++) {
      double x = (xPixel - size.width / 2) / scale;
      double y = computeY(x - h, type) + k;

      if (!y.isFinite) continue;

      double yPixel = size.height / 2 - y * scale;

      if (firstPoint) {
        path.moveTo(xPixel, yPixel);
        firstPoint = false;
      } else {
        path.lineTo(xPixel, yPixel);
      }

      // Second function intersection
      if (a2 != null && type2 != null) {
        double y2 = computeY(x - h, type2!) + k;
        if ((y - y2).abs() < 0.1) {
          canvas.drawCircle(Offset(xPixel, yPixel), 4, pointPaint);
        }
      }
    }

    canvas.drawPath(path, curvePaint);
  }

  double computeY(double x, String type) {
    switch (type) {
      case "Linear":
        return a * x + b;
      case "Quadratic":
        return a * x * x + b * x + c;
      case "Cubic":
        return x * x * x;
      case "Sine":
        return a * sin(b * x + c);
      case "Cosine":
        return a * cos(b * x + c);
      case "Tangent":
        double val = a * tan(b * x + c);
        if (val.abs() > 1000) return double.nan;
        return val;
      case "Exponential":
        return a * exp(b * x);
      case "Logarithmic":
        if (x <= 0) return double.nan;
        return log(a * x) / log(b);
      case "Absolute":
        return (a * x + b).abs();
      case "GreatestInteger":
        return (a * x + b).floorToDouble();
      case "Circle":
        double r = a;
        double y = sqrt(r * r - x * x);
        return y.isNaN ? 0 : y;
      case "Ellipse":
        double rX = a, rY = b;
        double y = rY * sqrt(1 - (x * x) / (rX * rX));
        return y.isNaN ? 0 : y;
      case "Parabola":
        return a * x * x + b * x + c;
      case "Hyperbola":
        double rX = a, rY = b;
        double y = rY * sqrt((x * x) / (rX * rX) - 1);
        return y.isNaN ? 0 : y;
      default:
        return 0;
    }
  }

  @override
  bool shouldRepaint(covariant MathPainter oldDelegate) {
    return oldDelegate.a != a ||
        oldDelegate.b != b ||
        oldDelegate.c != c ||
        oldDelegate.h != h ||
        oldDelegate.k != k ||
        oldDelegate.type != type;
  }
}
