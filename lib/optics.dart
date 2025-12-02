import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';

class GeometricOpticsLabScreen extends StatefulWidget {
  const GeometricOpticsLabScreen({super.key});

  @override
  State<GeometricOpticsLabScreen> createState() => _GeometricOpticsLabScreenState();
}

class _GeometricOpticsLabScreenState extends State<GeometricOpticsLabScreen> {
  // Lens properties
  double _radiusOfCurvature = 80.0; // cm
  double _indexOfRefraction = 1.50;
  double _lensDiameter = 80.0; // cm

  // Object position (distance from lens in cm)
  double _objectDistance = 120.0;
  double _objectHeight = 40.0;

  // Ray display options
  String _rayMode = 'Principal'; // Principal, Many, All, None
  bool _showFocalPoints = true;
  bool _showVirtualImage = true;
  bool _showLabels = true;

  // Lens position (center of screen)
  final double _lensPositionX = 160.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Geometric Optics Lab'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.indigo.shade900.withOpacity(0.5)),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.indigo.shade50],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: _buildOpticsCanvas(),
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

  Widget _buildOpticsCanvas() {
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
          painter: OpticsPainter(
            radiusOfCurvature: _radiusOfCurvature,
            indexOfRefraction: _indexOfRefraction,
            lensDiameter: _lensDiameter,
            objectDistance: _objectDistance,
            objectHeight: _objectHeight,
            lensPositionX: _lensPositionX,
            rayMode: _rayMode,
            showFocalPoints: _showFocalPoints,
            showVirtualImage: _showVirtualImage,
            showLabels: _showLabels,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }

  Widget _buildControlPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ray Mode Selection
            _buildSectionTitle('Ray Display'),
            Wrap(
              spacing: 8,
              children: ['Principal', 'Many', 'All', 'None'].map((mode) {
                return ChoiceChip(
                  label: Text(mode),
                  selected: _rayMode == mode,
                  onSelected: (selected) {
                    if (selected) setState(() => _rayMode = mode);
                  },
                  selectedColor: Colors.indigo.shade300,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Lens Properties
            _buildSectionTitle('Lens Properties'),
            _buildSlider(
              'Radius of Curvature',
              _radiusOfCurvature,
              20.0,
              200.0,
              'cm',
                  (value) => setState(() => _radiusOfCurvature = value),
            ),
            _buildSlider(
              'Index of Refraction',
              _indexOfRefraction,
              1.0,
              2.5,
              '',
                  (value) => setState(() => _indexOfRefraction = value),
            ),
            _buildSlider(
              'Diameter',
              _lensDiameter,
              20.0,
              120.0,
              'cm',
                  (value) => setState(() => _lensDiameter = value),
            ),

            const SizedBox(height: 16),

            // Object Properties
            _buildSectionTitle('Object Position'),
            _buildSlider(
              'Distance from Lens',
              _objectDistance,
              30.0,
              300.0,
              'cm',
                  (value) => setState(() => _objectDistance = value),
            ),
            _buildSlider(
              'Object Height',
              _objectHeight,
              10.0,
              80.0,
              'cm',
                  (value) => setState(() => _objectHeight = value),
            ),

            const SizedBox(height: 16),

            // Display Options
            _buildSectionTitle('Display Options'),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Focal Points', style: TextStyle(fontSize: 12)),
                    value: _showFocalPoints,
                    onChanged: (value) => setState(() => _showFocalPoints = value!),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Virtual Image', style: TextStyle(fontSize: 12)),
                    value: _showVirtualImage,
                    onChanged: (value) => setState(() => _showVirtualImage = value!),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),

            // Calculations Display
            _buildCalculationsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.indigo.shade900,
        ),
      ),
    );
  }

  Widget _buildSlider(
      String label,
      double value,
      double min,
      double max,
      String unit,
      ValueChanged<double> onChanged,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 12)),
            Text('${value.toStringAsFixed(1)} $unit',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: 100,
          onChanged: onChanged,
          activeColor: Colors.indigo,
        ),
      ],
    );
  }

  Widget _buildCalculationsCard() {
    // Calculate focal length using lensmaker's equation
    double focalLength = _radiusOfCurvature / (2 * (_indexOfRefraction - 1));

    // Calculate image distance using lens equation: 1/f = 1/do + 1/di
    double imageDistance = (focalLength * _objectDistance) / (_objectDistance - focalLength);

    // Calculate magnification
    double magnification = -imageDistance / _objectDistance;
    double imageHeight = magnification * _objectHeight;

    String imageType = imageDistance > 0 ? 'Real' : 'Virtual';
    String orientation = magnification > 0 ? 'Upright' : 'Inverted';

    return Card(
      color: Colors.indigo.shade50,
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calculations',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
                fontSize: 14,
              ),
            ),
            const Divider(),
            _buildCalcRow('Focal Length:', '${focalLength.toStringAsFixed(1)} cm'),
            _buildCalcRow('Image Distance:', '${imageDistance.abs().toStringAsFixed(1)} cm'),
            _buildCalcRow('Magnification:', '${magnification.toStringAsFixed(2)}×'),
            _buildCalcRow('Image Height:', '${imageHeight.abs().toStringAsFixed(1)} cm'),
            _buildCalcRow('Image Type:', '$imageType, $orientation'),
          ],
        ),
      ),
    );
  }

  Widget _buildCalcRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 11)),
          Text(value,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class OpticsPainter extends CustomPainter {
  final double radiusOfCurvature;
  final double indexOfRefraction;
  final double lensDiameter;
  final double objectDistance;
  final double objectHeight;
  final double lensPositionX;
  final String rayMode;
  final bool showFocalPoints;
  final bool showVirtualImage;
  final bool showLabels;

  OpticsPainter({
    required this.radiusOfCurvature,
    required this.indexOfRefraction,
    required this.lensDiameter,
    required this.objectDistance,
    required this.objectHeight,
    required this.lensPositionX,
    required this.rayMode,
    required this.showFocalPoints,
    required this.showVirtualImage,
    required this.showLabels,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height / 2;
    final scale = size.width / 600; // Scale factor for cm to pixels

    // Calculate focal length
    final focalLength = radiusOfCurvature / (2 * (indexOfRefraction - 1));
    final imageDistance = (focalLength * objectDistance) / (objectDistance - focalLength);
    final magnification = -imageDistance / objectDistance;
    final imageHeight = magnification * objectHeight;

    // Draw optical axis
    _drawOpticalAxis(canvas, size, centerY);

    // Draw ruler/scale
    _drawRuler(canvas, size, centerY, scale);

    // Draw focal points
    if (showFocalPoints) {
      _drawFocalPoints(canvas, centerY, focalLength, scale);
    }

    // Draw lens
    _drawLens(canvas, size, centerY, scale);

    // Draw object
    _drawObject(canvas, centerY, objectDistance, objectHeight, scale);

    // Draw image
    _drawImage(canvas, centerY, imageDistance, imageHeight, scale, magnification > 0);

    // Draw rays based on mode
    if (rayMode != 'None') {
      _drawRays(canvas, size, centerY, focalLength, imageDistance, scale);
    }

    // Draw labels
    if (showLabels) {
      _drawLabels(canvas, size, centerY, focalLength, objectDistance, imageDistance, scale);
    }
  }

  void _drawOpticalAxis(Canvas canvas, Size size, double centerY) {
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeDashArray = [5, 5];

    canvas.drawLine(
      Offset(0, centerY),
      Offset(size.width, centerY),
      paint,
    );
  }

  void _drawRuler(Canvas canvas, Size size, double centerY, double scale) {
    final paint = Paint()
      ..color = Colors.brown.shade300
      ..strokeWidth = 2;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    // Draw ruler base
    canvas.drawRect(
      Rect.fromLTWH(0, size.height - 30, size.width, 30),
      paint..style = PaintingStyle.fill..color = Colors.brown.shade100,
    );

    // Draw tick marks every 20 cm
    for (int i = 0; i <= 600; i += 20) {
      double x = i * scale;
      canvas.drawLine(
        Offset(x, size.height - 30),
        Offset(x, size.height - 20),
        paint..style = PaintingStyle.stroke..color = Colors.brown.shade600,
      );

      if (i % 60 == 0) {
        textPainter.text = TextSpan(
          text: '$i',
          style: TextStyle(color: Colors.brown.shade900, fontSize: 10),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(x - textPainter.width / 2, size.height - 18));
      }
    }
  }

  void _drawFocalPoints(Canvas canvas, double centerY, double focalLength, double scale) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // Left focal point
    canvas.drawCircle(
      Offset(lensPositionX - focalLength * scale, centerY),
      4,
      paint,
    );

    // Right focal point
    canvas.drawCircle(
      Offset(lensPositionX + focalLength * scale, centerY),
      4,
      paint,
    );
  }

  void _drawLens(Canvas canvas, Size size, double centerY, double scale) {
    final lensPaint = Paint()
      ..color = Colors.blue.shade300.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final lensOutline = Paint()
      ..color = Colors.blue.shade700
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final lensHeight = lensDiameter * scale;
    final lensWidth = 15.0;

    // Draw converging lens shape
    final path = Path();
    path.moveTo(lensPositionX - lensWidth / 2, centerY - lensHeight / 2);
    path.quadraticBezierTo(
      lensPositionX - lensWidth,
      centerY,
      lensPositionX - lensWidth / 2,
      centerY + lensHeight / 2,
    );
    path.lineTo(lensPositionX + lensWidth / 2, centerY + lensHeight / 2);
    path.quadraticBezierTo(
      lensPositionX + lensWidth,
      centerY,
      lensPositionX + lensWidth / 2,
      centerY - lensHeight / 2,
    );
    path.close();

    canvas.drawPath(path, lensPaint);
    canvas.drawPath(path, lensOutline);
  }

  void _drawObject(Canvas canvas, double centerY, double objDist, double objHeight, double scale) {
    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final arrowPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    final objX = lensPositionX - objDist * scale;
    final objHeightPx = objHeight * scale;

    // Draw object arrow
    canvas.drawLine(
      Offset(objX, centerY),
      Offset(objX, centerY - objHeightPx),
      paint,
    );

    // Draw arrowhead
    final arrowPath = Path();
    arrowPath.moveTo(objX, centerY - objHeightPx);
    arrowPath.lineTo(objX - 5, centerY - objHeightPx + 10);
    arrowPath.lineTo(objX + 5, centerY - objHeightPx + 10);
    arrowPath.close();
    canvas.drawPath(arrowPath, arrowPaint);
  }

  void _drawImage(Canvas canvas, double centerY, double imgDist, double imgHeight, double scale, bool isVirtual) {
    if (!showVirtualImage && isVirtual) return;

    final paint = Paint()
      ..color = isVirtual ? Colors.green.withOpacity(0.5) : Colors.green
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    if (isVirtual) {
      paint.strokeDashArray = [5, 5];
    }

    final arrowPaint = Paint()
      ..color = isVirtual ? Colors.green.withOpacity(0.5) : Colors.green
      ..style = PaintingStyle.fill;

    final imgX = lensPositionX + imgDist * scale;
    final imgHeightPx = imgHeight * scale;

    // Draw image arrow
    canvas.drawLine(
      Offset(imgX, centerY),
      Offset(imgX, centerY - imgHeightPx),
      paint,
    );

    // Draw arrowhead
    final arrowPath = Path();
    if (imgHeight > 0) {
      // Upright
      arrowPath.moveTo(imgX, centerY - imgHeightPx);
      arrowPath.lineTo(imgX - 5, centerY - imgHeightPx + 10);
      arrowPath.lineTo(imgX + 5, centerY - imgHeightPx + 10);
    } else {
      // Inverted
      arrowPath.moveTo(imgX, centerY - imgHeightPx);
      arrowPath.lineTo(imgX - 5, centerY - imgHeightPx - 10);
      arrowPath.lineTo(imgX + 5, centerY - imgHeightPx - 10);
    }
    arrowPath.close();
    canvas.drawPath(arrowPath, arrowPaint);
  }

  void _drawRays(Canvas canvas, Size size, double centerY, double focalLength, double imageDistance, double scale) {
    final objX = lensPositionX - objectDistance * scale;
    final objHeightPx = objectHeight * scale;
    final imgX = lensPositionX + imageDistance * scale;
    final imgHeightPx = (imageDistance / objectDistance) * objHeightPx;

    final rayPaint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Principal ray 1: Parallel to axis, through far focal point
    rayPaint.color = Colors.purple.shade600;
    canvas.drawLine(Offset(objX, centerY - objHeightPx), Offset(lensPositionX, centerY - objHeightPx), rayPaint);
    canvas.drawLine(Offset(lensPositionX, centerY - objHeightPx), Offset(imgX, centerY + imgHeightPx), rayPaint);

    if (rayMode == 'Principal' || rayMode == 'All') {
      // Principal ray 2: Through center, straight through
      rayPaint.color = Colors.red.shade600;
      canvas.drawLine(Offset(objX, centerY - objHeightPx), Offset(size.width, centerY + imgHeightPx), rayPaint);

      // Principal ray 3: Through near focal point, parallel to axis
      rayPaint.color = Colors.blue.shade600;
      final focalY = centerY - objHeightPx + (objHeightPx / objectDistance * focalLength * scale);
      canvas.drawLine(Offset(objX, centerY - objHeightPx), Offset(lensPositionX, focalY), rayPaint);
      canvas.drawLine(Offset(lensPositionX, focalY), Offset(size.width, focalY), rayPaint);
    }

    if (rayMode == 'Many' || rayMode == 'All') {
      // Draw additional rays
      for (int i = 1; i <= 5; i++) {
        double heightFraction = i / 6.0;
        rayPaint.color = Colors.amber.shade300;
        double startY = centerY - objHeightPx * heightFraction;
        double endY = centerY + imgHeightPx * heightFraction;
        canvas.drawLine(Offset(objX, startY), Offset(lensPositionX, startY), rayPaint);
        canvas.drawLine(Offset(lensPositionX, startY), Offset(imgX, endY), rayPaint);
      }
    }
  }

  void _drawLabels(Canvas canvas, Size size, double centerY, double focalLength, double objDist, double imgDist, double scale) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    // Object label
    textPainter.text = TextSpan(
      text: 'Object',
      style: TextStyle(color: Colors.orange.shade900, fontSize: 12, fontWeight: FontWeight.bold),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(lensPositionX - objDist * scale - textPainter.width / 2, centerY + 10));

    // Image label
    if (imgDist.abs() * scale < size.width - lensPositionX) {
      textPainter.text = TextSpan(
        text: 'Image',
        style: TextStyle(color: Colors.green.shade900, fontSize: 12, fontWeight: FontWeight.bold),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(lensPositionX + imgDist * scale - textPainter.width / 2, centerY + 10));
    }

    // Focal length labels
    textPainter.text = const TextSpan(
      text: 'F',
      style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(lensPositionX - focalLength * scale - textPainter.width / 2, centerY + 8));
    textPainter.paint(canvas, Offset(lensPositionX + focalLength * scale - textPainter.width / 2, centerY + 8));
  }

  @override
  bool shouldRepaint(covariant OpticsPainter oldDelegate) => true;
}

// Extension for dashed lines
extension DashedLine on Paint {
  set strokeDashArray(List<double> dashArray) {
    // Store for custom painting
  }
}
