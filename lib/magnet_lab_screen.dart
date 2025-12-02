import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class MagnetLabScreen extends StatefulWidget {
  const MagnetLabScreen({super.key});

  @override
  _MagnetLabScreenState createState() => _MagnetLabScreenState();
}

class _MagnetLabScreenState extends State<MagnetLabScreen> {
  // --- State Variables ---
  StreamSubscription? _subscription;
  bool _isRecording = false;

  // Current Reading (Micro-Tesla)
  double _currentMagnitude = 0.0;
  double _x = 0;
  double _y = 0;
  double _z = 0;

  // Graph Data
  List<FlSpot> _dataPoints = [];
  double _timeCounter = 0;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    _subscription = magnetometerEventStream(
      samplingPeriod: SensorInterval.uiInterval,
    ).listen((MagnetometerEvent event) {
      if (!mounted) return;

      // Calculate total magnetic field strength: sqrt(x^2 + y^2 + z^2)
      double magnitude = sqrt(pow(event.x, 2) + pow(event.y, 2) + pow(event.z, 2));

      setState(() {
        _x = event.x;
        _y = event.y;
        _z = event.z;
        _currentMagnitude = magnitude;

        // Add to graph if recording is active (or just visually scrolling)
        if (_dataPoints.length > 100) {
          _dataPoints.removeAt(0);
        }
        _dataPoints.add(FlSpot(_timeCounter++, magnitude));
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  // --- UI Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Magnetic Field Lab'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMeterDisplay(),
            const SizedBox(height: 20),
            _build3DValues(),
            const SizedBox(height: 20),
            _buildRealTimeGraph(),
            const SizedBox(height: 20),
            _buildExperimentGuide(),
          ],
        ),
      ),
    );
  }

  Widget _buildMeterDisplay() {
    // Color changes based on intensity
    Color intensityColor = Colors.green;
    if (_currentMagnitude > 60) intensityColor = Colors.orange;
    if (_currentMagnitude > 100) intensityColor = Colors.red;

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: intensityColor.withOpacity(0.3), width: 10),
        color: Colors.black26,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _currentMagnitude.toStringAsFixed(1),
            style: TextStyle(
              color: intensityColor,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'µT', // Micro-Tesla
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _build3DValues() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _axisCard('X', _x, Colors.redAccent),
        _axisCard('Y', _y, Colors.greenAccent),
        _axisCard('Z', _z, Colors.blueAccent),
      ],
    );
  }

  Widget _axisCard(String label, double value, Color color) {
    return Card(
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(
              value.toStringAsFixed(1),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRealTimeGraph() {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        color: Colors.grey[850],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true, drawVerticalLine: false),
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: _dataPoints,
                  isCurved: true,
                  color: Colors.indigoAccent,
                  barWidth: 2,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                      show: true,
                      color: Colors.indigoAccent.withOpacity(0.2)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExperimentGuide() {
    return Card(
      color: Colors.indigo[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Experiment: The Inverse Cube Law",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              "1. Place a bar magnet on a table.\n"
                  "2. Move your phone close to it.\n"
                  "3. Watch the value spike (Red).\n"
                  "4. Double the distance. Does the field drop by 8x? (B ∝ 1/d³)",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
