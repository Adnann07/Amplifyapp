import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class PendulumLabScreen extends StatefulWidget {
  @override
  _PendulumLabScreenState createState() => _PendulumLabScreenState();
}

class _PendulumLabScreenState extends State<PendulumLabScreen> {
  // --- State Variables ---
  StreamSubscription? _subscription;
  bool _isMeasuring = false;
  List<FlSpot> _dataPoints = [];
  double _period = 0.0;
  double _gravity = 0.0;
  double _stringLength = 0.5; // Default length in meters
  final TextEditingController _lengthController = TextEditingController();

  // Variables for period detection
  double _lastPeakTime = 0;
  List<double> _periods = [];
  bool _wasGoingPositive = true;

  @override
  void initState() {
    super.initState();
    _lengthController.text = _stringLength.toString();
  }

  // --- Core Logic ---
  void _startMeasurement() {
    _dataPoints = [];
    _periods = [];
    _lastPeakTime = 0;
    setState(() => _isMeasuring = true);

    _subscription = accelerometerEventStream(
      samplingPeriod: SensorInterval.gameInterval, // ~50 samples/sec
    ).listen((AccelerometerEvent event) {
      if (!mounted) return;

      double time = DateTime.now().millisecondsSinceEpoch / 1000.0;
      // Using x-axis for oscillation along the phone's width
      double accelerationX = event.x;

      setState(() {
        _dataPoints.add(FlSpot(time, accelerationX));
        // Keep only the last 10 seconds of data for display
        _dataPoints.removeWhere((spot) => time - spot.x > 10);
      });

      _detectPeriod(time, accelerationX);
    });
  }

  void _stopMeasurement() {
    _subscription?.cancel();
    setState(() => _isMeasuring = false);
    _calculateAveragePeriod();
    _calculateGravity();
  }

  void _detectPeriod(double currentTime, double currentAccel) {
    // Simple peak detection logic
    bool isGoingPositive = currentAccel > 0;

    // Detect a "zero crossing" from negative to positive
    if (isGoingPositive && !_wasGoingPositive) {
      if (_lastPeakTime != 0) {
        double detectedPeriod = currentTime - _lastPeakTime;
        // Filter out noise: assume period is between 0.5s and 5s
        if (detectedPeriod > 0.5 && detectedPeriod < 5.0) {
          _periods.add(detectedPeriod);
        }
      }
      _lastPeakTime = currentTime;
    }
    _wasGoingPositive = isGoingPositive;
  }

  void _calculateAveragePeriod() {
    if (_periods.isEmpty) {
      setState(() => _period = 0.0);
      return;
    }
    double sum = _periods.reduce((a, b) => a + b);
    setState(() => _period = sum / _periods.length);
  }

  void _calculateGravity() {
    if (_period > 0 && _stringLength > 0) {
      // Formula: T = 2 * pi * sqrt(L / g) => g = 4 * pi^2 * L / T^2
      double g = (4 * pow(pi, 2) * _stringLength) / pow(_period, 2);
      setState(() => _gravity = g);
    } else {
      setState(() => _gravity = 0.0);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _lengthController.dispose();
    super.dispose();
  }

  // --- UI Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pendulum Lab'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInstructionsCard(),
            SizedBox(height: 20),
            _buildControlPanel(),
            SizedBox(height: 20),
            _buildResultsDisplay(),
            SizedBox(height: 20),
            _buildRealTimeChart(),
          ],
        ),
      ),
    );
  }

  // --- UI Helper Widgets ---
  Widget _buildInstructionsCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Instructions:', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8),
            Text('1. Securely tie your phone to a string.'),
            Text('2. Enter the string length below (in meters).'),
            Text('3. Press START and swing the phone gently.'),
            Text('4. Press STOP after 5-10 swings.'),
          ],
        ),
      ),
    );
  }

  Widget _buildControlPanel() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _lengthController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'String Length (meters)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() => _stringLength = double.tryParse(value) ?? 0.5);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isMeasuring ? Colors.red : Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: _isMeasuring ? _stopMeasurement : _startMeasurement,
              child: Text(_isMeasuring ? 'STOP' : 'START', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsDisplay() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text('Avg. Period (T)', style: Theme.of(context).textTheme.titleMedium),
                Text('${_period.toStringAsFixed(3)} s', style: Theme.of(context).textTheme.headlineMedium),
              ],
            ),
            Column(
              children: [
                Text('Gravity (g)', style: Theme.of(context).textTheme.titleMedium),
                Text('${_gravity.toStringAsFixed(2)} m/s²', style: Theme.of(context).textTheme.headlineMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRealTimeChart() {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _dataPoints.isEmpty
              ? Center(child: Text('Press START to see the graph'))
              : LineChart(
            LineChartData(
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  spots: _dataPoints,
                  isCurved: true,
                  color: Colors.cyan,
                  barWidth: 2,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
