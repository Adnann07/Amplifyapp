import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'dart:ui' as ui; // Required for PathMetrics

class ProjectileLabScreen extends StatefulWidget {
  const ProjectileLabScreen({super.key});

  @override
  _ProjectileLabScreenState createState() => _ProjectileLabScreenState();
}

class _ProjectileLabScreenState extends State<ProjectileLabScreen> with TickerProviderStateMixin {
  // Physics Constants
  final double g = 9.8;
  final double scale = 4.0; // Scale meters to pixels

  // State Variables
  double velocity = 50.0; // Initial velocity (v)
  double angle = 45.0;    // Angle in degrees

  // Target (Enemy) State
  double targetX = 200; // Meters
  double targetY = 0;   // Meters (Ground level)
  final double targetSize = 15; // Meters

  // Animation State
  AnimationController? _controller;
  bool isFiring = false;
  double time = 0;
  bool hitTarget = false;
  String statusMessage = "Ready to Fire!";
  Color statusColor = Colors.blue;

  // Calculated Values
  double get maxRange => (pow(velocity, 2) * sin(2 * angle * pi / 180)) / g;
  double get maxHeight => (pow(velocity * sin(angle * pi / 180), 2)) / (2 * g);
  double get flightTime => (2 * velocity * sin(angle * pi / 180)) / g;

  @override
  void initState() {
    super.initState();
    _respawnTarget();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(_updateProjectile);
  }

  void _respawnTarget() {
    setState(() {
      // Randomize target position (between 50m and 350m range)
      targetX = 50 + Random().nextDouble() * 300;
      targetY = 0;
      hitTarget = false;
      statusMessage = "Target at ${targetX.toStringAsFixed(1)}m (Scroll Right!)";
      statusColor = Colors.blue;
    });
  }

  void _updateProjectile() {
    if (!isFiring) return;

    setState(() {
      time = _controller!.value * 10;

      // Current Ball Position
      double currentX = _calculateX(time);
      double currentY = _calculateY(time);

      // Check Collision with Target
      if (!hitTarget &&
          currentX >= targetX - 5 && currentX <= targetX + targetSize + 5 &&
          currentY >= targetY && currentY <= targetY + targetSize + 5) {

        hitTarget = true;
        isFiring = false;
        _controller!.stop();
        statusMessage = "DIRECT HIT! 🎉";
        statusColor = Colors.green;

        // Respawn after a short delay
        Future.delayed(const Duration(seconds: 2), _respawnTarget);
      }

      // Check Ground Hit (Miss)
      if (currentY < 0) {
        isFiring = false;
        _controller!.stop();
        time = flightTime; // Snap to end
        if (!hitTarget) {
          statusMessage = "MISS! Check range & try again.";
          statusColor = Colors.red;
        }
      }
    });
  }

  void _fireCannon() {
    if (isFiring) return;
    setState(() {
      isFiring = true;
      time = 0;
      hitTarget = false;
      statusMessage = "Firing...";
      statusColor = Colors.orange;
    });
    _controller!.reset();
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text("Projectile Game Lab"),
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _respawnTarget,
            tooltip: "New Target",
          )
        ],
      ),
      body: Column(
        children: [
          // 1. The Sky (Simulation Area) - SCROLLABLE
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Allows scrolling to see far targets
              child: SizedBox(
                width: 2000, // Wide world to fit targets up to ~450m
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    // Ground (Full width)
                    Positioned(bottom: 0, left: 0, right: 0, height: 20, child: Container(color: Colors.green[800])),

                    // Trajectory Path (Dotted Line)
                    CustomPaint(
                      size: Size.infinite,
                      painter: TrajectoryPainter(
                        velocity: velocity,
                        angle: angle,
                        gravity: g,
                        scale: scale,
                      ),
                    ),

                    // The Target Box (Enemy)
                    Positioned(
                      left: 20 + targetX * scale,
                      bottom: 20 + targetY * scale,
                      child: hitTarget
                          ? const Icon(Icons.local_fire_department, size: 40, color: Colors.orange) // Explosion
                          : Container(
                        width: targetSize * scale,
                        height: targetSize * scale,
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Center(child: Icon(Icons.smart_toy, color: Colors.white, size: 20)),
                      ),
                    ),

                    // The Projectile Ball (Animated)
                    if (isFiring)
                      Positioned(
                        left: 20 + _calculateX(time) * scale,
                        bottom: 20 + _calculateY(time) * scale,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        ),
                      ),

                    // The Cannon (Fixed at start)
                    Positioned(
                      left: 0,
                      bottom: 20,
                      child: Transform.rotate(
                        angle: -angle * pi / 180,
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: 60,
                          height: 10,
                          color: Colors.black,
                          child: const Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.circle, size: 12, color: Colors.grey)
                          ),
                        ),
                      ),
                    ),

                    // Stats Overlay (Now moves with scroll so you can always see it near start)
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [const BoxShadow(blurRadius: 5, color: Colors.black26)],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Target Distance: ${targetX.toStringAsFixed(1)} m", style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            Text("Max Height (H): ${maxHeight.toStringAsFixed(1)} m"),
                            Text("Range (R): ${maxRange.toStringAsFixed(1)} m"),
                            const Text("--> Scroll Right to find Target! -->", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 2. Controls Area (Fixed at bottom)
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  // Game Status Bar
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      border: Border.all(color: statusColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      statusMessage,
                      style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Angle Slider
                  Row(
                    children: [
                      const Icon(Icons.rotate_right, color: Colors.blue),
                      const SizedBox(width: 10),
                      Text("Angle: ${angle.toStringAsFixed(0)}°", style: const TextStyle(fontSize: 16)),
                      Expanded(
                        child: Slider(
                          value: angle,
                          min: 0,
                          max: 90,
                          divisions: 90,
                          activeColor: Colors.blue,
                          label: "${angle.round()}°",
                          onChanged: (val) => setState(() => angle = val),
                        ),
                      ),
                    ],
                  ),

                  // Velocity Slider
                  Row(
                    children: [
                      const Icon(Icons.speed, color: Colors.red),
                      const SizedBox(width: 10),
                      Text("Velocity: ${velocity.toStringAsFixed(0)} m/s", style: const TextStyle(fontSize: 16)),
                      Expanded(
                        child: Slider(
                          value: velocity,
                          min: 10,
                          max: 100,
                          activeColor: Colors.red,
                          label: "${velocity.round()} m/s",
                          onChanged: (val) => setState(() => velocity = val),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Fire Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: isFiring ? null : _fireCannon,
                      icon: const Icon(Icons.rocket_launch),
                      label: const Text("FIRE CANNON", style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Physics Formula Helpers
  double _calculateX(double t) {
    return velocity * cos(angle * pi / 180) * t;
  }

  double _calculateY(double t) {
    return (velocity * sin(angle * pi / 180) * t) - (0.5 * g * pow(t, 2));
  }
}

// Custom Painter to draw the dotted trajectory line
class TrajectoryPainter extends CustomPainter {
  final double velocity;
  final double angle;
  final double gravity;
  final double scale;

  TrajectoryPainter({required this.velocity, required this.angle, required this.gravity, required this.scale});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(20, size.height - 20);

    double totalTime = (2 * velocity * sin(angle * pi / 180)) / gravity;

    for (double t = 0; t <= totalTime; t += 0.1) {
      double x = velocity * cos(angle * pi / 180) * t;
      double y = (velocity * sin(angle * pi / 180) * t) - (0.5 * gravity * pow(t, 2));

      // Convert physics coordinates (meters) to screen coordinates (pixels)
      // Canvas Y is 0 at top, so we subtract from height
      path.lineTo(20 + x * scale, (size.height - 20) - (y * scale));
    }

    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    // Use ui.PathMetrics to avoid type errors
    ui.PathMetrics pathMetrics = path.computeMetrics();

    for (ui.PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        canvas.drawPath(
          pathMetric.extractPath(distance, distance + 5.0),
          paint,
        );
        distance += 10.0; // 5px dash, 5px gap
      }
    }
  }

  @override
  bool shouldRepaint(covariant TrajectoryPainter oldDelegate) {
    return oldDelegate.angle != angle || oldDelegate.velocity != velocity || oldDelegate.scale != scale;
  }
}
