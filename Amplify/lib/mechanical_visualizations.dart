import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';

class MechanicalVisualizationsPage extends StatefulWidget {
  const MechanicalVisualizationsPage({super.key});

  @override
  State<MechanicalVisualizationsPage> createState() => _MechanicalVisualizationsPageState();
}

class _MechanicalVisualizationsPageState extends State<MechanicalVisualizationsPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _beamAnimation;
  late Animation<double> _flowAnimation;
  late AnimationController _springController;
  late Animation<double> _springAnimation;

  int selectedTab = 0;
  double beamLoad = 20.0;
  double loadPosition = 0.5; // Draggable load position
  double reynoldsNumber = 1000.0;
  double forceAngle = 90.0; // For free body diagram
  double hotFluidTemp = 90.0;
  double coldFluidTemp = 20.0;
  bool isCounterFlow = false;

  final List<Map<String, dynamic>> tabs = [
    {'title': 'Beam Analysis', 'icon': Icons.straighten},
    {'title': 'Fluid Flow', 'icon': Icons.water_drop},
    {'title': 'Free Body', 'icon': Icons.construction},
    {'title': 'Heat Exchange', 'icon': Icons.thermostat},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
    _beamAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _flowAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animationController, curve: const Interval(0.2, 0.8)));

    _springController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _springAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(CurvedAnimation(parent: _springController, curve: Curves.elasticOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _springController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Mechanical Visualizations', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.cyan.shade700,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Tab Navigation
          Container(
            height: 60,
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => setState(() => selectedTab = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: selectedTab == index ? Colors.cyan.shade600 : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.shade200,
                          blurRadius: selectedTab == index ? 12 : 4,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(tabs[index]['icon'] as IconData,
                            color: selectedTab == index ? Colors.white : Colors.cyan.shade700,
                            size: 20),
                        const SizedBox(width: 8),
                        Text(tabs[index]['title'] as String,
                            style: TextStyle(
                              color: selectedTab == index ? Colors.white : Colors.cyan.shade700,
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: IndexedStack(
              index: selectedTab,
              children: [
                _BeamAnalysisTab(
                  animation: _beamAnimation,
                  beamLoad: beamLoad,
                  loadPosition: loadPosition,
                  onLoadChanged: (val) => setState(() => beamLoad = val),
                  onPositionChanged: (pos) => setState(() => loadPosition = pos),
                ),
                _FluidFlowTab(
                  animation: _flowAnimation,
                  reynoldsNumber: reynoldsNumber,
                  onReynoldsChanged: (val) => setState(() => reynoldsNumber = val),
                ),
                _FreeBodyDiagramTab(
                  animation: _springAnimation,
                  forceAngle: forceAngle,
                  onAngleChanged: (angle) => setState(() => forceAngle = angle),
                ),
                _HeatExchangeTab(
                  hotTemp: hotFluidTemp,
                  coldTemp: coldFluidTemp,
                  isCounterFlow: isCounterFlow,
                  onHotTempChanged: (val) => setState(() => hotFluidTemp = val),
                  onColdTempChanged: (val) => setState(() => coldFluidTemp = val),
                  onFlowTypeChanged: (val) => setState(() => isCounterFlow = val),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 1. INTERACTIVE BEAM ANALYSIS TAB
class _BeamAnalysisTab extends StatelessWidget {
  final Animation<double> animation;
  final double beamLoad;
  final double loadPosition;
  final ValueChanged<double> onLoadChanged;
  final ValueChanged<double> onPositionChanged;

  const _BeamAnalysisTab({
    required this.animation,
    required this.beamLoad,
    required this.loadPosition,
    required this.onLoadChanged,
    required this.onPositionChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate reactions based on position
    final reactionA = beamLoad * (1 - loadPosition);
    final reactionB = beamLoad * loadPosition;
    final maxDeflection = (beamLoad * loadPosition * (1 - loadPosition) * 0.625).toStringAsFixed(2);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              'Interactive Beam Analysis',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.cyan)
          ),
          const SizedBox(height: 10),
          Text(
              '🎯 Drag the load to change position',
              style: TextStyle(fontSize: 14, color: Colors.cyan.shade600, fontWeight: FontWeight.w600)
          ),
          const SizedBox(height: 20),

          // Interactive Load Control
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan.shade50, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 20)],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.fitness_center, color: Colors.cyan),
                    const SizedBox(width: 10),
                    const Text('Point Load (kN)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Text('${beamLoad.toStringAsFixed(1)} kN', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyan)),
                  ],
                ),
                Slider(
                  value: beamLoad,
                  min: 10.0,
                  max: 100.0,
                  divisions: 18,
                  activeColor: Colors.cyan,
                  inactiveColor: Colors.cyan.shade100,
                  onChanged: onLoadChanged,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(Icons.linear_scale, color: Colors.orange),
                    const SizedBox(width: 10),
                    const Text('Load Position', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Text('${(loadPosition * 100).toStringAsFixed(0)}%', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange)),
                  ],
                ),
                Slider(
                  value: loadPosition,
                  min: 0.2,
                  max: 0.8,
                  activeColor: Colors.orange,
                  inactiveColor: Colors.orange.shade100,
                  onChanged: onPositionChanged,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Interactive Draggable Beam Canvas
          GestureDetector(
            onPanUpdate: (details) {
              final RenderBox box = context.findRenderObject() as RenderBox;
              final localPosition = box.globalToLocal(details.globalPosition);
              final canvasWidth = box.size.width - 100;
              final normalizedPos = ((localPosition.dx - 50) / canvasWidth).clamp(0.2, 0.8);
              onPositionChanged(normalizedPos);
            },
            child: Container(
              height: 320,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 15)],
              ),
              child: CustomPaint(
                painter: BeamPainter(
                  animation: animation,
                  load: beamLoad,
                  loadPosition: loadPosition,
                ),
                size: const Size(double.infinity, 320),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Live Results Table
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10)],
            ),
            child: Column(
              children: [
                const Row(
                  children: [
                    Icon(Icons.analytics, color: Colors.cyan),
                    SizedBox(width: 10),
                    Text('Live Reaction Forces', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Divider(height: 20),
                Row(children: [
                  const Expanded(child: Text('Reaction A ↑', style: TextStyle(fontSize: 16))),
                  Expanded(child: Text('${reactionA.toStringAsFixed(1)} kN', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue)))
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  const Expanded(child: Text('Reaction B ↑', style: TextStyle(fontSize: 16))),
                  Expanded(child: Text('${reactionB.toStringAsFixed(1)} kN', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue)))
                ]),
                const Divider(height: 20),
                Row(children: [
                  const Expanded(child: Text('Max Deflection', style: TextStyle(fontSize: 16))),
                  Expanded(child: Text('$maxDeflection mm', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red)))
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BeamPainter extends CustomPainter {
  final Animation<double> animation;
  final double load;
  final double loadPosition;

  BeamPainter({required this.animation, required this.load, required this.loadPosition}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..color = const Color(0xFF303F9F);

    final deflectionPaint = Paint()
      ..color = Colors.cyan.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final totalLength = size.width - 100;
    final supportHeight = size.height * 0.6;

    // Animated deflection based on load and position
    final maxDeflection = (load / 5) * (loadPosition * (1 - loadPosition)) * 4;

    final path = Path();
    path.moveTo(50, supportHeight);

    for (double x = 0; x <= totalLength; x += 5) {
      final normalizedX = x / totalLength;
      double deflection;

      if (normalizedX < loadPosition) {
        deflection = maxDeflection * (normalizedX / loadPosition) * animation.value;
      } else {
        deflection = maxDeflection * ((1 - normalizedX) / (1 - loadPosition)) * animation.value;
      }

      path.lineTo(50 + x, supportHeight - deflection);
    }

    canvas.drawPath(path, paint);

    // Deflected shape (exaggerated)
    final deflectedPath = Path();
    deflectedPath.moveTo(50, supportHeight);
    for (double x = 0; x <= totalLength; x += 5) {
      final normalizedX = x / totalLength;
      double deflection;

      if (normalizedX < loadPosition) {
        deflection = maxDeflection * 1.5 * (normalizedX / loadPosition);
      } else {
        deflection = maxDeflection * 1.5 * ((1 - normalizedX) / (1 - loadPosition));
      }

      deflectedPath.lineTo(50 + x, supportHeight - deflection);
    }
    canvas.drawPath(deflectedPath, deflectionPaint);

    // Supports
    _drawSupport(canvas, 50, supportHeight, 'A');
    _drawSupport(canvas, 50 + totalLength, supportHeight, 'B');

    // Draggable load indicator
    final loadX = 50 + totalLength * loadPosition;
    _drawDraggableLoad(canvas, loadX, supportHeight - maxDeflection * animation.value - 40, load);

    // Reaction forces
    final reactionA = load * (1 - loadPosition);
    final reactionB = load * loadPosition;
    _drawReaction(canvas, 50, supportHeight + 25, 'RA=${reactionA.toStringAsFixed(1)}kN');
    _drawReaction(canvas, 50 + totalLength, supportHeight + 25, 'RB=${reactionB.toStringAsFixed(1)}kN');
  }

  void _drawSupport(Canvas canvas, double x, double y, String label) {
    final supportPaint = Paint()..color = Colors.green.shade600..style = PaintingStyle.fill;

    // Triangle support
    final path = Path()
      ..moveTo(x, y)
      ..lineTo(x - 15, y + 25)
      ..lineTo(x + 15, y + 25)
      ..close();
    canvas.drawPath(path, supportPaint);

    canvas.drawCircle(Offset(x, y), 10, Paint()..color = Colors.green.shade400);

    final textPainter = _createTextPainter(label, const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold));
    textPainter.paint(canvas, Offset(x - 5, y - 7));
  }

  void _drawDraggableLoad(Canvas canvas, double x, double y, double magnitude) {
    // Arrow shaft
    final arrowPaint = Paint()..color = Colors.red.shade600..strokeWidth = 5;
    canvas.drawLine(Offset(x, y), Offset(x, y + 50), arrowPaint);

    // Arrow head
    final arrowHead = Path()
      ..moveTo(x, y + 50)
      ..lineTo(x - 10, y + 35)
      ..lineTo(x + 10, y + 35)
      ..close();
    canvas.drawPath(arrowHead, Paint()..color = Colors.red.shade600);

    // Load circle with drag indicator
    canvas.drawCircle(Offset(x, y), 20, Paint()..color = Colors.red.shade700);
    canvas.drawCircle(Offset(x, y), 18, Paint()..color = Colors.white..style = PaintingStyle.stroke..strokeWidth = 2);

    final textPainter = _createTextPainter('${magnitude.toStringAsFixed(0)}', const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold));
    textPainter.paint(canvas, Offset(x - 10, y - 7));
  }

  void _drawReaction(Canvas canvas, double x, double y, String label) {
    final reactionPaint = Paint()..color = Colors.blue.shade600..strokeWidth = 5;
    canvas.drawLine(Offset(x, y), Offset(x, y - 35), reactionPaint);

    // Arrow head pointing up
    final arrowHead = Path()
      ..moveTo(x, y - 35)
      ..lineTo(x - 8, y - 20)
      ..lineTo(x + 8, y - 20)
      ..close();
    canvas.drawPath(arrowHead, Paint()..color = Colors.blue.shade600);

    final textPainter = _createTextPainter(label, const TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.bold));
    textPainter.paint(canvas, Offset(x - 25, y + 5));
  }

  TextPainter _createTextPainter(String text, TextStyle style) {
    return TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// 2. INTERACTIVE FLUID FLOW TAB
class _FluidFlowTab extends StatelessWidget {
  final Animation<double> animation;
  final double reynoldsNumber;
  final ValueChanged<double> onReynoldsChanged;

  const _FluidFlowTab({
    required this.animation,
    required this.reynoldsNumber,
    required this.onReynoldsChanged,
  });

  String _getFlowRegime(double re) {
    if (re < 2000) return 'Laminar Flow';
    if (re < 4000) return 'Transitional Flow';
    return 'Turbulent Flow';
  }

  Color _getFlowColor(double re) {
    if (re < 2000) return Colors.blue.shade400;
    if (re < 4000) return Colors.yellow.shade700;
    return Colors.red.shade400;
  }

  @override
  Widget build(BuildContext context) {
    final regime = _getFlowRegime(reynoldsNumber);
    final flowColor = _getFlowColor(reynoldsNumber);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
              'Interactive Fluid Flow Visualization',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.cyan)
          ),
          const SizedBox(height: 10),
          Text(
              '🌊 Adjust Reynolds number to see flow regimes',
              style: TextStyle(fontSize: 14, color: Colors.cyan.shade600, fontWeight: FontWeight.w600)
          ),
          const SizedBox(height: 20),

          // Reynolds Number Control
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [flowColor.withOpacity(0.1), Colors.white],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 20)],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.waves, color: flowColor),
                    const SizedBox(width: 10),
                    const Text('Reynolds Number', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Text(reynoldsNumber.toStringAsFixed(0), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: flowColor)),
                  ],
                ),
                const SizedBox(height: 10),
                Slider(
                  value: reynoldsNumber,
                  min: 100.0,
                  max: 10000.0,
                  divisions: 99,
                  activeColor: flowColor,
                  inactiveColor: flowColor.withOpacity(0.3),
                  onChanged: onReynoldsChanged,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: flowColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline, color: flowColor, size: 20),
                      const SizedBox(width: 8),
                      Text(regime, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: flowColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          Container(
            height: 380,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 15)],
            ),
            child: CustomPaint(
              painter: FluidFlowPainter(animation: animation, reynoldsNumber: reynoldsNumber),
              size: const Size(double.infinity, 380),
            ),
          ),

          const SizedBox(height: 20),

          // Flow regime info cards
          Row(
            children: [
              Expanded(child: _buildInfoCard('Laminar', 'Re < 2000', Colors.blue)),
              const SizedBox(width: 10),
              Expanded(child: _buildInfoCard('Transitional', '2000-4000', Colors.yellow.shade700)),
              const SizedBox(width: 10),
              Expanded(child: _buildInfoCard('Turbulent', 'Re > 4000', Colors.red)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String range, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(range, style: TextStyle(fontSize: 11, color: color)),
        ],
      ),
    );
  }
}

class FluidFlowPainter extends CustomPainter {
  final Animation<double> animation;
  final double reynoldsNumber;

  FluidFlowPainter({required this.animation, required this.reynoldsNumber}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final pipeRect = Rect.fromLTWH(50, size.height * 0.35, size.width - 100, 120);
    final progress = animation.value;

    // Pipe walls with gradient
    final pipeGradient = LinearGradient(
      colors: [Colors.grey.shade200, Colors.grey.shade400],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final pipePaint = Paint()
      ..shader = pipeGradient.createShader(pipeRect)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(pipeRect, const Radius.circular(20)), pipePaint);

    // Pipe outline
    canvas.drawRRect(
      RRect.fromRectAndRadius(pipeRect, const Radius.circular(20)),
      Paint()..color = Colors.grey.shade600..style = PaintingStyle.stroke..strokeWidth = 3,
    );

    // Flow visualization
    _drawFlowParticles(canvas, pipeRect, progress);
    _drawStreamlines(canvas, pipeRect, progress);

    // Flow direction arrow
    _drawFlowArrow(canvas, Offset(pipeRect.left - 30, pipeRect.center.dy));
  }

  void _drawStreamlines(Canvas canvas, Rect pipe, double progress) {
    Color streamColor;
    double turbulenceLevel;

    if (reynoldsNumber < 2000) {
      streamColor = Colors.blue.shade400;
      turbulenceLevel = 0;
    } else if (reynoldsNumber < 4000) {
      streamColor = Colors.yellow.shade700;
      turbulenceLevel = (reynoldsNumber - 2000) / 2000 * 3;
    } else {
      streamColor = Colors.red.shade400;
      turbulenceLevel = 5 + (reynoldsNumber - 4000) / 6000 * 10;
    }

    final pathPaint = Paint()
      ..color = streamColor.withOpacity(0.7)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 10; i++) {
      final y = pipe.top + 15 + (i * 10.0);
      final path = Path();
      path.moveTo(pipe.left, y);

      for (double x = pipe.left; x < pipe.right; x += 8) {
        final normalizedX = (x - pipe.left) / pipe.width;
        final wave = math.sin(normalizedX * 15 + progress * 25 + i) * turbulenceLevel;
        final vortex = reynoldsNumber > 4000 ? math.cos(normalizedX * 20 + progress * 30) * (turbulenceLevel * 0.3) : 0;
        path.lineTo(x, y + wave + vortex);
      }

      canvas.drawPath(path, pathPaint);
    }
  }

  void _drawFlowParticles(Canvas canvas, Rect pipe, double progress) {
    final particlePaint = Paint()..color = Colors.white.withOpacity(0.8);

    for (int i = 0; i < 20; i++) {
      final particleProgress = (progress + i * 0.05) % 1.0;
      final x = pipe.left + pipe.width * particleProgress;
      final baseY = pipe.top + 20 + (i % 8) * 12.0;

      double yOffset = 0;
      if (reynoldsNumber > 2000) {
        yOffset = math.sin(particleProgress * 20 + i) * (reynoldsNumber / 1000);
      }

      canvas.drawCircle(Offset(x, baseY + yOffset), 3, particlePaint);
    }
  }

  void _drawFlowArrow(Canvas canvas, Offset position) {
    final arrowPaint = Paint()..color = Colors.cyan.shade700..strokeWidth = 4;

    canvas.drawLine(position, Offset(position.dx + 40, position.dy), arrowPaint);

    final arrowHead = Path()
      ..moveTo(position.dx + 40, position.dy)
      ..lineTo(position.dx + 30, position.dy - 8)
      ..lineTo(position.dx + 30, position.dy + 8)
      ..close();
    canvas.drawPath(arrowHead, Paint()..color = Colors.cyan.shade700);
  }

  TextPainter _createTextPainter(String text, TextStyle style) {
    return TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// 3. INTERACTIVE FREE BODY DIAGRAM TAB
class _FreeBodyDiagramTab extends StatelessWidget {
  final Animation<double> animation;
  final double forceAngle;
  final ValueChanged<double> onAngleChanged;

  const _FreeBodyDiagramTab({
    required this.animation,
    required this.forceAngle,
    required this.onAngleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final forceX = 100 * math.cos(forceAngle * math.pi / 180);
    final forceY = 100 * math.sin(forceAngle * math.pi / 180);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
              'Interactive Free Body Diagram',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.cyan)
          ),
          const SizedBox(height: 10),
          Text(
              '⚡ Adjust force angle to see components',
              style: TextStyle(fontSize: 14, color: Colors.cyan.shade600, fontWeight: FontWeight.w600)
          ),
          const SizedBox(height: 20),

          // Force Angle Control
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade50, Colors.white],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 20)],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.rotate_right, color: Colors.purple),
                    const SizedBox(width: 10),
                    const Text('Force Angle', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Text('${forceAngle.toStringAsFixed(0)}°', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.purple)),
                  ],
                ),
                Slider(
                  value: forceAngle,
                  min: 0,
                  max: 180,
                  divisions: 36,
                  activeColor: Colors.purple,
                  inactiveColor: Colors.purple.shade100,
                  onChanged: onAngleChanged,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          Container(
            height: 420,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 15)],
            ),
            child: CustomPaint(
              painter: FreeBodyPainter(animation: animation, forceAngle: forceAngle),
              size: const Size(double.infinity, 420),
            ),
          ),

          const SizedBox(height: 20),

          // Force components display
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10)],
            ),
            child: Column(
              children: [
                const Row(
                  children: [
                    Icon(Icons.analytics, color: Colors.purple),
                    SizedBox(width: 10),
                    Text('Force Components', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Divider(height: 20),
                Row(children: [
                  const Expanded(child: Text('Horizontal (Fx)', style: TextStyle(fontSize: 16))),
                  Expanded(child: Text('${forceX.toStringAsFixed(1)} N', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red)))
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  const Expanded(child: Text('Vertical (Fy)', style: TextStyle(fontSize: 16))),
                  Expanded(child: Text('${forceY.toStringAsFixed(1)} N', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue)))
                ]),
                const Divider(height: 20),
                Row(children: [
                  const Expanded(child: Text('Resultant', style: TextStyle(fontSize: 16))),
                  Expanded(child: Text('100.0 N @ ${forceAngle.toStringAsFixed(0)}°', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.purple)))
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FreeBodyPainter extends CustomPainter {
  final Animation<double> animation;
  final double forceAngle;

  FreeBodyPainter({required this.animation, required this.forceAngle}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw grid
    _drawGrid(canvas, size);

    // Main body (block)
    final blockRect = Rect.fromCenter(center: Offset(centerX, centerY), width: 80, height: 80);
    final blockPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.blue.shade300, Colors.blue.shade600],
      ).createShader(blockRect);
    canvas.drawRRect(RRect.fromRectAndRadius(blockRect, const Radius.circular(8)), blockPaint);
    canvas.drawRRect(
      RRect.fromRectAndRadius(blockRect, const Radius.circular(8)),
      Paint()..color = Colors.blue.shade900..style = PaintingStyle.stroke..strokeWidth = 3,
    );

    // Force vector (animated)
    final forceLength = 120;
    final angleRad = forceAngle * math.pi / 180;
    final forceEndX = centerX + forceLength * math.cos(angleRad);
    final forceEndY = centerY - forceLength * math.sin(angleRad);

    // Draw components first (dashed lines)
    _drawComponentVector(canvas, Offset(centerX, centerY), Offset(forceEndX, centerY), Colors.red.shade400, 'Fx');
    _drawComponentVector(canvas, Offset(forceEndX, centerY), Offset(forceEndX, forceEndY), Colors.blue.shade400, 'Fy');

    // Draw main force vector
    _drawForceVector(canvas, Offset(centerX, centerY), Offset(forceEndX, forceEndY), Colors.purple.shade600, 'F = 100N', true);

    // Draw angle arc
    _drawAngleArc(canvas, Offset(centerX, centerY), forceAngle);

    // Weight force
    _drawForceVector(canvas, Offset(centerX, centerY), Offset(centerX, centerY + 80), Colors.orange.shade600, 'W', false);

    // Normal force (animated with spring)
    final normalOffset = 80 * animation.value;
    _drawForceVector(canvas, Offset(centerX, centerY), Offset(centerX, centerY - normalOffset), Colors.green.shade600, 'N', false);

    // Ground
    _drawGround(canvas, centerY + 60, size.width);

    // Labels
    final textPainter = _createTextPainter('Mass Block', const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white));
    textPainter.paint(canvas, Offset(centerX - 38, centerY - 7));
  }

  void _drawGrid(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  void _drawComponentVector(Canvas canvas, Offset start, Offset end, Color color, String label) {
    final dashedPaint = Paint()
      ..color = color.withOpacity(0.6)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Draw dashed line
    final path = Path()..moveTo(start.dx, start.dy);
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final distance = math.sqrt(dx * dx + dy * dy);
    final dashLength = 8.0;
    final dashCount = (distance / (dashLength * 2)).floor();

    for (int i = 0; i < dashCount; i++) {
      final t1 = i * 2 * dashLength / distance;
      final t2 = (i * 2 + 1) * dashLength / distance;
      path.moveTo(start.dx + dx * t1, start.dy + dy * t1);
      path.lineTo(start.dx + dx * t2, start.dy + dy * t2);
    }
    canvas.drawPath(path, dashedPaint);

    // Label
    final midX = (start.dx + end.dx) / 2;
    final midY = (start.dy + end.dy) / 2;
    final textPainter = _createTextPainter(label, TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold));
    textPainter.paint(canvas, Offset(midX + 5, midY - 15));
  }

  void _drawAngleArc(Canvas canvas, Offset center, double angle) {
    final arcPaint = Paint()
      ..color = Colors.purple.shade300
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCenter(center: center, width: 60, height: 60),
      0,
      -angle * math.pi / 180,
      false,
      arcPaint,
    );

    // Angle label
    final labelAngle = -angle / 2 * math.pi / 180;
    final labelX = center.dx + 40 * math.cos(labelAngle);
    final labelY = center.dy + 40 * math.sin(labelAngle);
    final textPainter = _createTextPainter('${angle.toStringAsFixed(0)}°', TextStyle(color: Colors.purple.shade700, fontSize: 13, fontWeight: FontWeight.bold));
    textPainter.paint(canvas, Offset(labelX - 10, labelY - 7));
  }

  void _drawGround(Canvas canvas, double y, double width) {
    final groundPaint = Paint()..color = Colors.brown.shade400..strokeWidth = 4;
    canvas.drawLine(Offset(0, y), Offset(width, y), groundPaint);

    // Hatch marks
    for (double x = 0; x < width; x += 20) {
      canvas.drawLine(Offset(x, y), Offset(x - 10, y + 15), Paint()..color = Colors.brown.shade300..strokeWidth = 2);
    }
  }

  void _drawForceVector(Canvas canvas, Offset start, Offset end, Color color, String label, bool isMain) {
    final arrowPaint = Paint()..color = color..strokeWidth = isMain ? 6 : 5;
    canvas.drawLine(start, end, arrowPaint);

    // Arrow head
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final angle = math.atan2(dy, dx);

    final arrowHead = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(end.dx - 15 * math.cos(angle - 0.3), end.dy - 15 * math.sin(angle - 0.3))
      ..lineTo(end.dx - 15 * math.cos(angle + 0.3), end.dy - 15 * math.sin(angle + 0.3))
      ..close();
    canvas.drawPath(arrowHead, Paint()..color = color);

    // Label with background
    final textPainter = _createTextPainter(label, TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold));
    final labelPos = Offset(end.dx + 10, end.dy - 20);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(labelPos.dx - 3, labelPos.dy - 2, textPainter.width + 6, textPainter.height + 4),
        const Radius.circular(4),
      ),
      Paint()..color = color,
    );
    textPainter.paint(canvas, labelPos);
  }

  TextPainter _createTextPainter(String text, TextStyle style) {
    return TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// 4. INTERACTIVE HEAT EXCHANGER TAB
class _HeatExchangeTab extends StatelessWidget {
  final double hotTemp;
  final double coldTemp;
  final bool isCounterFlow;
  final ValueChanged<double> onHotTempChanged;
  final ValueChanged<double> onColdTempChanged;
  final ValueChanged<bool> onFlowTypeChanged;

  const _HeatExchangeTab({
    required this.hotTemp,
    required this.coldTemp,
    required this.isCounterFlow,
    required this.onHotTempChanged,
    required this.onColdTempChanged,
    required this.onFlowTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final efficiency = isCounterFlow ? 85.0 : 65.0;
    final heatTransferred = ((hotTemp - coldTemp) * (efficiency / 100)).toStringAsFixed(1);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
              'Interactive Heat Exchanger',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.cyan)
          ),
          const SizedBox(height: 10),
          Text(
              '🔥 Adjust temperatures and flow type',
              style: TextStyle(fontSize: 14, color: Colors.cyan.shade600, fontWeight: FontWeight.w600)
          ),
          const SizedBox(height: 20),

          // Temperature Controls
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.shade50, Colors.blue.shade50],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 20)],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.local_fire_department, color: Colors.red),
                    const SizedBox(width: 10),
                    const Text('Hot Fluid Temp', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Text('${hotTemp.toStringAsFixed(0)}°C', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
                  ],
                ),
                Slider(
                  value: hotTemp,
                  min: 50.0,
                  max: 150.0,
                  divisions: 20,
                  activeColor: Colors.red,
                  inactiveColor: Colors.red.shade100,
                  onChanged: onHotTempChanged,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(Icons.ac_unit, color: Colors.blue),
                    const SizedBox(width: 10),
                    const Text('Cold Fluid Temp', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Text('${coldTemp.toStringAsFixed(0)}°C', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
                  ],
                ),
                Slider(
                  value: coldTemp,
                  min: 10.0,
                  max: 50.0,
                  divisions: 8,
                  activeColor: Colors.blue,
                  inactiveColor: Colors.blue.shade100,
                  onChanged: onColdTempChanged,
                ),
                const Divider(height: 30),
                Row(
                  children: [
                    const Icon(Icons.swap_horiz, color: Colors.purple),
                    const SizedBox(width: 10),
                    const Text('Flow Configuration', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Switch(
                      value: isCounterFlow,
                      activeColor: Colors.purple,
                      onChanged: onFlowTypeChanged,
                    ),
                    Text(isCounterFlow ? 'Count' : 'Paral', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          Container(
            height: 420,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 15)],
            ),
            child: CustomPaint(
              painter: HeatExchangerPainter(
                hotTemp: hotTemp,
                coldTemp: coldTemp,
                isCounterFlow: isCounterFlow,
              ),
              size: const Size(double.infinity, 420),
            ),
          ),

          const SizedBox(height: 20),

          // Performance metrics
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10)],
            ),
            child: Column(
              children: [
                const Row(
                  children: [
                    Icon(Icons.analytics, color: Colors.purple),
                    SizedBox(width: 10),
                    Text('Performance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Divider(height: 20),
                Row(children: [
                  const Expanded(child: Text('ΔT (Temp Diff)', style: TextStyle(fontSize: 16))),
                  Expanded(child: Text('${(hotTemp - coldTemp).toStringAsFixed(1)}°C', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.orange)))
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  const Expanded(child: Text('Efficiency', style: TextStyle(fontSize: 16))),
                  Expanded(child: Text('${efficiency.toStringAsFixed(0)}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)))
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  const Expanded(child: Text('Heat Transfer', style: TextStyle(fontSize: 16))),
                  Expanded(child: Text('$heatTransferred kW', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red)))
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeatExchangerPainter extends CustomPainter {
  final double hotTemp;
  final double coldTemp;
  final bool isCounterFlow;

  const HeatExchangerPainter({
    required this.hotTemp,
    required this.coldTemp,
    required this.isCounterFlow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final exchangerRect = Rect.fromLTWH(80, size.height * 0.25, size.width - 160, 140);

    // Exchanger body with 3D effect
    final bodyGradient = LinearGradient(
      colors: [Colors.grey.shade100, Colors.grey.shade300, Colors.grey.shade100],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(exchangerRect, const Radius.circular(15)),
      Paint()..shader = bodyGradient.createShader(exchangerRect),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(exchangerRect, const Radius.circular(15)),
      Paint()..color = Colors.grey.shade500..style = PaintingStyle.stroke..strokeWidth = 3,
    );

    // Flow visualization
    if (isCounterFlow) {
      _drawCounterFlow(canvas, exchangerRect);
    } else {
      _drawParallelFlow(canvas, exchangerRect);
    }

    // Temperature labels with thermometers
    _drawTempIndicator(canvas, Offset(exchangerRect.left - 50, exchangerRect.top + 20), hotTemp, Colors.red, 'Hot In');
    _drawTempIndicator(canvas, Offset(exchangerRect.right + 10, exchangerRect.bottom - 20), coldTemp, Colors.blue, 'Cold In');

    // Flow type label
    final flowLabel = isCounterFlow ? 'Counter Flow Configuration' : 'Parallel';
    final labelPainter = _createTextPainter(flowLabel, const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.purple));
    labelPainter.paint(canvas, Offset(size.width / 2 - labelPainter.width / 2, exchangerRect.bottom + 30));

    // Temperature profiles
    _drawTempProfile(canvas, exchangerRect, size);
  }

  void _drawParallelFlow(Canvas canvas, Rect exchanger) {
    // Hot fluid (top, left to right)
    _drawFlowPath(canvas,
      Offset(exchanger.left, exchanger.top + 30),
      Offset(exchanger.right, exchanger.top + 30),
      Colors.red.shade400,
      true,
      hotTemp,
    );

    // Cold fluid (bottom, left to right)
    _drawFlowPath(canvas,
      Offset(exchanger.left, exchanger.bottom - 30),
      Offset(exchanger.right, exchanger.bottom - 30),
      Colors.blue.shade400,
      true,
      coldTemp,
    );
  }

  void _drawCounterFlow(Canvas canvas, Rect exchanger) {
    // Hot fluid (top, left to right)
    _drawFlowPath(canvas,
      Offset(exchanger.left, exchanger.top + 30),
      Offset(exchanger.right, exchanger.top + 30),
      Colors.red.shade400,
      true,
      hotTemp,
    );

    // Cold fluid (bottom, right to left - counter flow)
    _drawFlowPath(canvas,
      Offset(exchanger.right, exchanger.bottom - 30),
      Offset(exchanger.left, exchanger.bottom - 30),
      Colors.blue.shade400,
      false,
      coldTemp,
    );
  }

  void _drawFlowPath(Canvas canvas, Offset start, Offset end, Color color, bool rightward, double temp) {
    final flowPaint = Paint()
      ..color = color.withOpacity(0.7)
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(start, end, flowPaint);

    // Arrow
    final arrowPaint = Paint()..color = color..strokeWidth = 4;
    final arrowPos = rightward ? end : start;
    final arrowDir = rightward ? 1 : -1;

    final arrowPath = Path()
      ..moveTo(arrowPos.dx, arrowPos.dy)
      ..lineTo(arrowPos.dx - 20 * arrowDir, arrowPos.dy - 10)
      ..lineTo(arrowPos.dx - 20 * arrowDir, arrowPos.dy + 10)
      ..close();
    canvas.drawPath(arrowPath, Paint()..color = color);

    // Animated flow particles
    for (int i = 0; i < 5; i++) {
      final progress = i * 0.2;
      final particleX = start.dx + (end.dx - start.dx) * progress;
      canvas.drawCircle(Offset(particleX, start.dy), 5, Paint()..color = Colors.white.withOpacity(0.8));
    }
  }

  void _drawTempIndicator(Canvas canvas, Offset position, double temp, Color color, String label) {
    // Thermometer icon
    canvas.drawCircle(position, 12, Paint()..color = color);
    canvas.drawRect(Rect.fromLTWH(position.dx - 3, position.dy - 25, 6, 20), Paint()..color = color.withOpacity(0.7));

    // Temperature text
    final tempText = _createTextPainter('${temp.toStringAsFixed(0)}°C', TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color));
    tempText.paint(canvas, Offset(position.dx - tempText.width / 2, position.dy + 18));

    final labelText = _createTextPainter(label, TextStyle(fontSize: 11, color: Colors.grey.shade700));
    labelText.paint(canvas, Offset(position.dx - labelText.width / 2, position.dy + 35));
  }

  void _drawTempProfile(Canvas canvas, Rect exchanger, Size size) {
    final profileY = exchanger.bottom + 80;

    // Temperature vs Length graph
    final graphRect = Rect.fromLTWH(exchanger.left, profileY, exchanger.width, 100);

    // Graph background
    canvas.drawRRect(
      RRect.fromRectAndRadius(graphRect, const Radius.circular(8)),
      Paint()..color = Colors.grey.shade50,
    );

    // Hot fluid temperature curve
    final hotPath = Path();
    hotPath.moveTo(graphRect.left, graphRect.top + 20);

    for (double x = 0; x <= graphRect.width; x += 10) {
      final progress = x / graphRect.width;
      final tempDrop = isCounterFlow ? hotTemp - (hotTemp - coldTemp) * 0.7 * progress : hotTemp - (hotTemp - coldTemp) * 0.8 * progress;
      final y = graphRect.top + 20 + (graphRect.height - 40) * (1 - (tempDrop - coldTemp) / (hotTemp - coldTemp));
      if (x == 0) {
        hotPath.moveTo(graphRect.left + x, y);
      } else {
        hotPath.lineTo(graphRect.left + x, y);
      }
    }
    canvas.drawPath(hotPath, Paint()..color = Colors.red.shade400..strokeWidth = 3..style = PaintingStyle.stroke);

    // Cold fluid temperature curve
    final coldPath = Path();
    for (double x = 0; x <= graphRect.width; x += 10) {
      final progress = x / graphRect.width;
      final tempRise = isCounterFlow ? coldTemp + (hotTemp - coldTemp) * 0.65 * progress : coldTemp + (hotTemp - coldTemp) * 0.4 * progress;
      final y = graphRect.top + 20 + (graphRect.height - 40) * (1 - (tempRise - coldTemp) / (hotTemp - coldTemp));
      if (x == 0) {
        coldPath.moveTo(graphRect.left + x, y);
      } else {
        coldPath.lineTo(graphRect.left + x, y);
      }
    }
    canvas.drawPath(coldPath, Paint()..color = Colors.blue.shade400..strokeWidth = 3..style = PaintingStyle.stroke);

    // Axis labels
    final xLabel = _createTextPainter('Length →', const TextStyle(fontSize: 11, color: Colors.grey));
    xLabel.paint(canvas, Offset(graphRect.center.dx - 20, graphRect.bottom + 5));

    final yLabel = _createTextPainter('T', const TextStyle(fontSize: 11, color: Colors.grey));
    yLabel.paint(canvas, Offset(graphRect.left - 15, graphRect.top + 5));
  }

  TextPainter _createTextPainter(String text, TextStyle style) {
    return TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
