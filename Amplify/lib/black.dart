import 'package:flutter/material.dart';
import 'dart:math' as math;

// Physical constant for Planck's law
const h = 6.626e-34; // Planck constant (J s)
const c = 3.00e8;    // Speed of light (m/s)
const k = 1.381e-23; // Boltzmann constant (J/K)

// Converts micrometers (um) to meters (m)
double umToM(double um) => um * 1.0e-6;

// Planck's Law: Spectral radiance (W/m^2/um)
double planck(double wavelengthUm, double temperature) {
  final wavelengthM = umToM(wavelengthUm);
  final factor = (2 * h * math.pow(c, 2)) / math.pow(wavelengthM, 5);
  final expo = h * c / (wavelengthM * k * temperature);
  return factor / (math.exp(expo) - 1) / 1e6; // Scale for easier plotting
}

class BlackbodySpectrumLabScreen extends StatefulWidget {
  const BlackbodySpectrumLabScreen({super.key});

  @override
  State<BlackbodySpectrumLabScreen> createState() => _BlackbodySpectrumLabScreenState();
}

class _BlackbodySpectrumLabScreenState extends State<BlackbodySpectrumLabScreen> {
  double temperature = 7250.0; // Kelvin
  double compareTemperature = 7850.0; // Kelvin
  bool showComparison = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blackbody Spectrum'),
        backgroundColor: Colors.indigo.shade800,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.indigo.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 18),
              Text('Blackbody Temperature', style: TextStyle(color: Colors.yellow.shade300, fontSize: 19)),
              Slider(
                value: temperature,
                min: 250.0,
                max: 12000.0,
                divisions: 500,
                label: '${temperature.toStringAsFixed(0)} K',
                onChanged: (v) => setState(() => temperature = v),
                activeColor: Colors.orange,
              ),
              // Common values for reference
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTempLabel("Earth", 300),
                  _buildTempLabel("Light Bulb", 2700),
                  _buildTempLabel("Sun", 5778),
                  _buildTempLabel("Sirius A", 9940),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 3,
                child: Stack(children: [
                  Center(
                    child: CustomPaint(
                      painter: BlackbodyPainter(
                        temperature: temperature,
                        compareTemperature: showComparison ? compareTemperature : null,
                      ),
                      size: Size(390, 260),
                    ),
                  ),
                  Positioned(
                    left: 45,
                    top: 18,
                    child: Container(
                      width: 45,
                      height: 205,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF1B4FFF), // blue
                            Color(0xFF5FFF21), // green
                            Color(0xFFFFFF00), // yellow
                            Color(0xFFFFA600), // orange
                            Color(0xFFFF0000), // red
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 0.35, 0.48, 0.65, 1.0],
                        ),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ]),
              ),
              Card(
                color: Colors.indigo.shade50.withOpacity(0.8),
                margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        'Current Temperature: ${temperature.toStringAsFixed(0)} K',
                        style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        'Peak Wavelength: ${_peakWavelength(temperature).toStringAsFixed(3)} μm',
                        style: TextStyle(color: Colors.orange.shade800, fontSize: 14),
                      ),
                      if (showComparison)
                        Text(
                          'Comparison: ${compareTemperature.toStringAsFixed(0)} K',
                          style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
                        ),
                      Row(
                        children: [
                          Checkbox(
                            value: showComparison,
                            onChanged: (checked) => setState(() => showComparison = checked!),
                          ),
                          const Text('Show comparison curve', style: TextStyle(fontSize: 13))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade700),
                    onPressed: () => setState(() => temperature = 5778), // Sun
                    icon: const Icon(Icons.wb_sunny),
                    label: const Text('Sun'),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo.shade700),
                    onPressed: () => setState(() => temperature = 300), // Earth
                    icon: const Icon(Icons.public),
                    label: const Text('Earth'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTempLabel(String name, double temp) {
    return Column(
      children: [
        Text(name, style: TextStyle(color: Colors.white70, fontSize: 11)),
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity((temperature - temp).abs() < 80 ? 0.85 : 0.12),
            border: Border.all(color: Colors.yellow.shade300, width: 1.5),
          ),
        ),
        Text('${temp.round()} K', style: TextStyle(color: Colors.white38, fontSize: 10)),
      ],
    );
  }

  // Wien's Law for peak wavelength (μm)
  double _peakWavelength(double tempK) {
    return 2900 / tempK;
  }
}

class BlackbodyPainter extends CustomPainter {
  final double temperature;
  final double? compareTemperature;

  BlackbodyPainter({required this.temperature, this.compareTemperature});

  @override
  void paint(Canvas canvas, Size size) {
    final graphLeft = 85.0;
    final graphBottom = size.height - 35;
    final graphTop = 28.0;
    final graphWidth = size.width - graphLeft - 22;
    final graphHeight = graphBottom - graphTop;

    // Axes
    final axisPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;
    canvas.drawLine(Offset(graphLeft, graphBottom), Offset(graphLeft, graphTop), axisPaint);
    canvas.drawLine(Offset(graphLeft, graphBottom), Offset(graphLeft + graphWidth, graphBottom), axisPaint);

    // X-Axis ticks and labels
    final style = const TextStyle(color: Colors.white, fontSize: 11);
    for (int i = 0; i <= 5; i++) {
      double x = graphLeft + (i * graphWidth / 5.0);
      TextPainter(
        text: TextSpan(text: (i * 0.3).toStringAsFixed(1), style: style),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )
        ..layout()
        ..paint(canvas, Offset(x - 8, graphBottom + 4));
    }

    // Y-Axis ticks and labels
    for (int i = 0; i <= 5; i++) {
      double y = graphBottom - (i * graphHeight / 5.0);
      TextPainter(
        text: TextSpan(text: '${(i * 100).toInt()}', style: style),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )
        ..layout()
        ..paint(canvas, Offset(graphLeft - 32, y - 7));
    }

    // Spectrum color bar already drawn as overlay in parent.

    // Draw blackbody curve
    _drawPlanckCurve(canvas, graphLeft, graphBottom, graphWidth, graphHeight, temperature, Colors.orange.shade400);

    // Draw comparison curve if requested
    if (compareTemperature != null) {
      _drawPlanckCurve(canvas, graphLeft, graphBottom, graphWidth, graphHeight, compareTemperature!, Colors.grey.shade400);
    }
  }

  void _drawPlanckCurve(Canvas canvas, double left, double bottom, double width, double height, double temp, Color color) {
    final curvePaint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final points = <Offset>[];
    double maxY = 0;
    for (double wavelength = 0.08; wavelength < 1.5; wavelength += 0.014) {
      double value = planck(wavelength, temp);
      if (value > maxY) maxY = value;
    }
    for (double wavelength = 0.08; wavelength < 1.5; wavelength += 0.014) {
      double value = planck(wavelength, temp);
      double x = left + ((wavelength - 0.08) / (1.5 - 0.08)) * width;
      double y = bottom - (value / (maxY + 2)) * height * 0.95;
      points.add(Offset(x, y));
    }
    for (int i = 1; i < points.length; i++) {
      canvas.drawLine(points[i - 1], points[i], curvePaint);
    }

    // Draw peak dot and highlight
    double peakWavelength = 2900 / temp;
    double peakValue = planck(peakWavelength, temp);
    double peakX = left + ((peakWavelength - 0.08) / (1.5 - 0.08)) * width;
    double peakY = bottom - (peakValue / (maxY + 2)) * height * 0.95;
    canvas.drawCircle(Offset(peakX, peakY), 4.3, Paint()..color = color);
    final textStyle = TextStyle(color: Colors.yellow.shade200, fontSize: 10, fontWeight: FontWeight.bold);
    TextPainter(
      text: TextSpan(text: '${peakWavelength.toStringAsFixed(3)} μm', style: textStyle),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    )
      ..layout()
      ..paint(canvas, Offset(peakX - 24, peakY - 24));
  }

  @override
  bool shouldRepaint(covariant BlackbodyPainter oldDelegate) => true;
}
