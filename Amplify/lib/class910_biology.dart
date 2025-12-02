import 'package:flutter/material.dart';

class BiologyExperimentsPage extends StatelessWidget {
  const BiologyExperimentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biology Experiments'),
        backgroundColor: Colors.green[800],
      ),
      body: ListView(
        children: [
          _buildExperimentTile(
            context,
            'Dissection and study of various plant and animal tissues',
            const DissectionSimulation(),
            Colors.green,
          ),
          _buildExperimentTile(
            context,
            'Photosynthesis rate measurement at different light intensities',
            const PhotosynthesisSimulation(),
            Colors.lightGreen,
          ),
          _buildExperimentTile(
            context,
            'Study and drawing of microscope slides (e.g., plant stem, leaf structure)',
            const MicroscopeSlidesSimulation(),
            Colors.blue,
          ),
          _buildExperimentTile(
            context,
            'Reflex reaction measurement in humans',
            const ReflexSimulation(),
            Colors.orange,
          ),
          _buildExperimentTile(
            context,
            'Examining microbial growth in different food samples or water',
            const MicrobialGrowthSimulation(),
            Colors.brown,
          ),
          _buildExperimentTile(
            context,
            'Enzyme reaction under varying temperatures',
            const EnzymeSimulation(),
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildExperimentTile(BuildContext context, String title, Widget page, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      child: ListTile(
        leading: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Icon(Icons.biotech, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        },
      ),
    );
  }
}

class DissectionSimulation extends StatefulWidget {
  const DissectionSimulation({super.key});

  @override
  State<DissectionSimulation> createState() => _DissectionSimulationState();
}

class _DissectionSimulationState extends State<DissectionSimulation> {
  String tissue = 'Plant stem';
  double magnification = 1.0;

  Map<String, Map<String, dynamic>> tissueDetails = {
    'Plant stem': {
      'color': Colors.brown,
      'structure': 'Vascular bundles, xylem, phloem',
      'image': Icons.park,
      'layers': ['Epidermis', 'Cortex', 'Vascular Tissue', 'Pith'],
    },
    'Animal muscle': {
      'color': Colors.red,
      'structure': 'Striated muscle fibers, nuclei',
      'image': Icons.fitness_center,
      'layers': ['Epimysium', 'Muscle Fascicle', 'Muscle Fiber', 'Myofibrils'],
    },
    'Leaf': {
      'color': Colors.green,
      'structure': 'Palisade mesophyll, spongy mesophyll, stomata',
      'image': Icons.eco,
      'layers': ['Cuticle', 'Upper Epidermis', 'Palisade Layer', 'Spongy Layer'],
    },
  };

  @override
  Widget build(BuildContext context) {
    var currentTissue = tissueDetails[tissue]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dissection Simulation'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Tissue visualization
                  Container(
                    width: 300.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: currentTissue['color'] as Color,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey, width: 2.0),
                    ),
                    child: Stack(
                      children: [
                        // Magnified view
                        Positioned(
                          right: 10.0,
                          top: 10.0,
                          child: Transform.scale(
                            scale: magnification,
                            child: Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                color: (currentTissue['color'] as Color).withOpacity(0.8),
                                border: Border.all(color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child: Icon(
                                currentTissue['image'] as IconData,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                          ),
                        ),
                        // Tissue layers
                        Positioned(
                          left: 20.0,
                          top: 20.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: (currentTissue['layers'] as List<String>).map((layer) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0),
                                child: Text(
                                  layer,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    tissue,
                    style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    currentTissue['structure'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  const SizedBox(height: 20.0),
                  // Layer indicators
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: (currentTissue['layers'] as List<String>).asMap().entries.map((entry) {
                        int index = entry.key;
                        String layer = entry.value;
                        return ListTile(
                          leading: Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              color: (currentTissue['color'] as Color).withOpacity(0.2 + index * 0.2),
                              shape: BoxShape.circle,
                            ),
                          ),
                          title: Text(layer),
                          trailing: Text('Layer ${index + 1}'),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  DropdownButton<String>(
                    value: tissue,
                    items: tissueDetails.keys.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => tissue = value!),
                  ),
                  const SizedBox(height: 20.0),
                  Slider(
                    value: magnification,
                    min: 1.0,
                    max: 3.0,
                    divisions: 20,
                    label: 'Magnification: ${magnification.toStringAsFixed(1)}x',
                    onChanged: (value) => setState(() => magnification = value),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhotosynthesisSimulation extends StatefulWidget {
  const PhotosynthesisSimulation({super.key});

  @override
  State<PhotosynthesisSimulation> createState() => _PhotosynthesisSimulationState();
}

class _PhotosynthesisSimulationState extends State<PhotosynthesisSimulation> with SingleTickerProviderStateMixin {
  double lightIntensity = 50.0;
  late AnimationController _bubbleController;

  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    super.dispose();
  }

  double getRate() {
    // Photosynthesis rate follows a curve - increases then plateaus
    return (lightIntensity * 2) / (1 + lightIntensity / 80);
  }

  Color getLightColor() {
    if (lightIntensity < 25) return Colors.blue[200]!;
    if (lightIntensity < 50) return Colors.yellow[200]!;
    if (lightIntensity < 75) return Colors.orange[200]!;
    return Colors.orange[400]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photosynthesis Rate'),
        backgroundColor: Colors.lightGreen[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Plant and light setup
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Light source
                      Container(
                        width: 300.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              getLightColor().withOpacity(lightIntensity / 100),
                              Colors.transparent,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Icon(
                          Icons.lightbulb,
                          color: getLightColor(),
                          size: 40.0,
                        ),
                      ),
                      // Plant
                      Positioned(
                        bottom: 0,
                        child: Column(
                          children: [
                            // Oxygen bubbles
                            AnimatedBuilder(
                              animation: _bubbleController,
                              builder: (context, child) {
                                return Stack(
                                  children: [
                                    for (int i = 0; i < (lightIntensity / 10).floor(); i++)
                                      Positioned(
                                        left: i * 15.0 - 30.0,
                                        bottom: 50.0 + _bubbleController.value * 100,
                                        child: Container(
                                          width: 8.0 + i * 0.5,
                                          height: 8.0 + i * 0.5,
                                          decoration: BoxDecoration(
                                            color: Colors.blue[100]!.withOpacity(0.8),
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.blue[300]!),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                            // Plant
                            const Icon(
                              Icons.local_florist,
                              color: Colors.green,
                              size: 80.0,
                            ),
                            Container(
                              width: 10.0,
                              height: 40.0,
                              color: Colors.brown,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  // Rate visualization
                  Container(
                    width: 300.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Text(
                        'Photosynthesis Rate: ${getRate().toStringAsFixed(1)} units',
                        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Graph indicator
                  Container(
                    width: 300.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: CustomPaint(
                      painter: PhotosynthesisGraphPainter(lightIntensity, getRate()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Slider(
                  value: lightIntensity,
                  min: 0.0,
                  max: 100.0,
                  divisions: 100,
                  label: 'Light Intensity: ${lightIntensity.toStringAsFixed(0)}%',
                  onChanged: (value) => setState(() => lightIntensity = value),
                ),
                Text(
                  'Light Intensity: ${lightIntensity.toStringAsFixed(0)}%',
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PhotosynthesisGraphPainter extends CustomPainter {
  final double lightIntensity;
  final double rate;

  PhotosynthesisGraphPainter(this.lightIntensity, this.rate);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = Colors.blue.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final pointPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // Draw axes
    canvas.drawLine(Offset(30.0, size.height - 30.0), Offset(size.width - 10.0, size.height - 30.0), paint);
    canvas.drawLine(Offset(30.0, 20.0), Offset(30.0, size.height - 30.0), paint);

    // Draw curve
    final path = Path();
    path.moveTo(30.0, size.height - 30.0);

    for (double x = 0; x <= 100; x += 5) {
      double yRate = (x * 2) / (1 + x / 80);
      double xPos = 30.0 + (x / 100) * (size.width - 40.0);
      double yPos = size.height - 30.0 - (yRate / 200) * (size.height - 50.0);
      path.lineTo(xPos, yPos);
    }

    canvas.drawPath(path, paint);

    // Fill under curve
    final fillPath = Path()..addPath(path, Offset.zero);
    fillPath.lineTo(size.width - 10.0, size.height - 30.0);
    fillPath.lineTo(30.0, size.height - 30.0);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);

    // Draw current point
    double currentX = 30.0 + (lightIntensity / 100) * (size.width - 40.0);
    double currentY = size.height - 30.0 - (rate / 200) * (size.height - 50.0);
    canvas.drawCircle(Offset(currentX, currentY), 6.0, pointPaint);

    // Labels
    final textStyle = TextStyle(color: Colors.black, fontSize: 10.0);
    final textPainter = TextPainter(
      text: TextSpan(text: 'Light Intensity', style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(size.width / 2 - 30.0, size.height - 15.0));

    final textPainter2 = TextPainter(
      text: TextSpan(text: 'Rate', style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter2.paint(canvas, Offset(5.0, size.height / 2 - 10.0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class MicroscopeSlidesSimulation extends StatefulWidget {
  const MicroscopeSlidesSimulation({super.key});

  @override
  State<MicroscopeSlidesSimulation> createState() => _MicroscopeSlidesSimulationState();
}

class _MicroscopeSlidesSimulationState extends State<MicroscopeSlidesSimulation> {
  String slide = 'Plant stem';
  double focus = 50.0;

  Map<String, Map<String, dynamic>> slideDetails = {
    'Plant stem': {
      'color': Colors.brown,
      'description': 'Cross-section showing vascular bundles',
      'cells': ['Xylem vessels', 'Phloem tubes', 'Cambium', 'Parenchyma'],
      'stain': Colors.green,
    },
    'Leaf structure': {
      'color': Colors.green,
      'description': 'Showing palisade and spongy mesophyll',
      'cells': ['Upper epidermis', 'Palisade cells', 'Spongy mesophyll', 'Stomata'],
      'stain': Colors.blue,
    },
    'Root tip': {
      'color': Colors.orange,
      'description': 'Showing root cap and meristematic zone',
      'cells': ['Root cap', 'Meristem', 'Elongation zone', 'Maturation zone'],
      'stain': Colors.purple,
    },
  };

  @override
  Widget build(BuildContext context) {
    var currentSlide = slideDetails[slide]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Microscope Slides'),
        backgroundColor: Colors.blue[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Microscope view
                  Container(
                    width: 300.0,
                    height: 300.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(150.0),
                      border: Border.all(color: Colors.grey, width: 3.0),
                    ),
                    child: Stack(
                      children: [
                        // Slide content
                        Center(
                          child: Container(
                            width: 200.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: currentSlide['stain'] as Color,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Stack(
                              children: [
                                // Cell structures
                                for (int i = 0; i < (currentSlide['cells'] as List<String>).length; i++)
                                  Positioned(
                                    left: 20.0 + i * 40.0,
                                    top: 20.0 + (i % 2) * 30.0,
                                    child: Container(
                                      width: 30.0 - i * 2.0,
                                      height: 30.0 - i * 2.0,
                                      decoration: BoxDecoration(
                                        color: (currentSlide['stain'] as Color).withOpacity(0.5 + i * 0.1),
                                        border: Border.all(color: Colors.white, width: 1.0),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        // Focus effect
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150.0),
                            border: Border.all(
                              color: Colors.yellow.withOpacity(focus / 100),
                              width: 3.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    slide,
                    style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    currentSlide['description'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  const SizedBox(height: 20.0),
                  // Cell labels
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 5.0,
                    children: (currentSlide['cells'] as List<String>).map((cell) {
                      return Chip(
                        label: Text(cell),
                        backgroundColor: (currentSlide['stain'] as Color).withOpacity(0.2),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  DropdownButton<String>(
                    value: slide,
                    items: slideDetails.keys.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => slide = value!),
                  ),
                  const SizedBox(height: 20.0),
                  Slider(
                    value: focus,
                    min: 0.0,
                    max: 100.0,
                    divisions: 100,
                    label: 'Focus: ${focus.toStringAsFixed(0)}%',
                    onChanged: (value) => setState(() => focus = value),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReflexSimulation extends StatefulWidget {
  const ReflexSimulation({super.key});

  @override
  State<ReflexSimulation> createState() => _ReflexSimulationState();
}

class _ReflexSimulationState extends State<ReflexSimulation> with SingleTickerProviderStateMixin {
  double reactionTime = 0.2;
  bool isTesting = false;
  late AnimationController _testController;
  DateTime? testStartTime;

  @override
  void initState() {
    super.initState();
    _testController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _testController.dispose();
    super.dispose();
  }

  void startTest() {
    setState(() {
      isTesting = true;
      testStartTime = DateTime.now();
    });

    // Random delay before showing stimulus
    Future.delayed(Duration(milliseconds: 1000 + (DateTime.now().millisecond % 2000)), () {
      if (mounted) {
        _testController.forward();
      }
    });
  }

  void recordReaction() {
    if (isTesting && _testController.status == AnimationStatus.completed) {
      final endTime = DateTime.now();
      final duration = endTime.difference(testStartTime!).inMilliseconds / 1000.0;
      setState(() {
        reactionTime = duration;
        isTesting = false;
        _testController.reset();
      });
    }
  }

  Color _getReactionColor() {
    if (reactionTime < 0.2) return Colors.green;
    if (reactionTime < 0.3) return Colors.yellow;
    if (reactionTime < 0.4) return Colors.orange;
    return Colors.red;
  }

  String _getReactionAssessment() {
    if (reactionTime < 0.2) return 'Excellent!';
    if (reactionTime < 0.3) return 'Good';
    if (reactionTime < 0.4) return 'Average';
    return 'Slow';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reflex Reaction Measurement'),
        backgroundColor: Colors.orange[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Hand visualization
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Arm
                      Container(
                        width: 200.0,
                        height: 100.0,
                        color: const Color(0xFFFFDAB9),
                      ),
                      // Hand
                      const Icon(
                        Icons.pan_tool,
                        size: 80.0,
                        color: Color(0xFFFFDAB9),
                      ),
                      // Stimulus
                      if (isTesting)
                        AnimatedBuilder(
                          animation: _testController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0.0, -50.0 * _testController.value),
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.5),
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.bolt,
                                  color: Colors.yellow,
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  // Results display
                  Container(
                    width: 300.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: _getReactionColor(),
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10.0,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Reaction Time',
                            style: TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                          Text(
                            '${reactionTime.toStringAsFixed(3)} s',
                            style: const TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _getReactionAssessment(),
                            style: const TextStyle(fontSize: 14.0, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Reaction scale
                  Container(
                    width: 300.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.green,
                          Colors.yellow,
                          Colors.orange,
                          Colors.red,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: (reactionTime / 1.0) * 300 - 10,
                          child: Container(
                            width: 20.0,
                            height: 30.0,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                '↑',
                                style: TextStyle(color: Colors.white, fontSize: 12.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Fast'),
                      Text('Slow'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: isTesting ? recordReaction : startTest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isTesting ? Colors.green : Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                  ),
                  child: Text(
                    isTesting ? 'TAP NOW!' : 'Start Reflex Test',
                    style: const TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Instructions: ${isTesting ? 'Tap when you see the stimulus!' : 'Click start and tap when you see the red circle'}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MicrobialGrowthSimulation extends StatefulWidget {
  const MicrobialGrowthSimulation({super.key});

  @override
  State<MicrobialGrowthSimulation> createState() => _MicrobialGrowthSimulationState();
}

class _MicrobialGrowthSimulationState extends State<MicrobialGrowthSimulation> with SingleTickerProviderStateMixin {
  String sample = 'Water';
  double timeElapsed = 0.0;
  late AnimationController _growthController;

  @override
  void initState() {
    super.initState();
    _growthController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _growthController.dispose();
    super.dispose();
  }

  Map<String, Map<String, dynamic>> sampleDetails = {
    'Water': {
      'color': Colors.blue,
      'growthRate': 1.0,
      'description': 'Moderate bacterial growth',
      'microbes': ['E. coli', 'Salmonella', 'Coliforms'],
    },
    'Food sample': {
      'color': Colors.brown,
      'growthRate': 2.0,
      'description': 'Rapid microbial colonization',
      'microbes': ['Mold', 'Yeast', 'Bacteria'],
    },
    'Soil': {
      'color': Colors.orange,
      'growthRate': 1.5,
      'description': 'Diverse microbial ecosystem',
      'microbes': ['Actinomycetes', 'Fungi', 'Nematodes'],
    },
  };

  double getGrowthLevel() {
    return timeElapsed * sampleDetails[sample]!['growthRate'] as double;
  }

  String getGrowthDescription() {
    double growth = getGrowthLevel();
    if (growth < 10) return 'No visible growth';
    if (growth < 30) return 'Slight growth';
    if (growth < 60) return 'Moderate growth';
    if (growth < 90) return 'Heavy growth';
    return 'Extensive growth';
  }

  @override
  Widget build(BuildContext context) {
    var currentSample = sampleDetails[sample]!;
    double growth = getGrowthLevel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Microbial Growth Examination'),
        backgroundColor: Colors.brown[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Petri dish visualization
                  Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 3.0),
                    ),
                    child: AnimatedBuilder(
                      animation: _growthController,
                      builder: (context, child) {
                        return Stack(
                          children: [
                            // Sample medium
                            Container(
                              decoration: BoxDecoration(
                                color: (currentSample['color'] as Color).withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                            ),
                            // Microbial colonies
                            for (int i = 0; i < (growth / 10).floor(); i++)
                              Positioned(
                                left: 30.0 + (i * 25.0) % 140.0,
                                top: 30.0 + ((i * 17.0) % 140.0),
                                child: Container(
                                  width: 10.0 + (growth / 20) + _growthController.value * 5.0,
                                  height: 10.0 + (growth / 20) + _growthController.value * 5.0,
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.8),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.green[800]!),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    sample,
                    style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    getGrowthDescription(),
                    style: TextStyle(
                      fontSize: 18.0,
                      color: _getGrowthColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Growth progress
                  Container(
                    width: 300.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: growth * 3.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.green[300]!,
                                Colors.green[700]!,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Growth Level: ${growth.toStringAsFixed(1)}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Microbe types
                  Wrap(
                    spacing: 10.0,
                    children: (currentSample['microbes'] as List<String>).map((microbe) {
                      return Chip(
                        label: Text(microbe),
                        backgroundColor: Colors.green[100],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                DropdownButton<String>(
                  value: sample,
                  items: sampleDetails.keys.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      sample = value!;
                      timeElapsed = 0.0;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                Slider(
                  value: timeElapsed,
                  min: 0.0,
                  max: 30.0,
                  divisions: 30,
                  label: 'Time: ${timeElapsed.toStringAsFixed(0)} hours',
                  onChanged: (value) => setState(() => timeElapsed = value),
                ),
                Text(
                  'Incubation Time: ${timeElapsed.toStringAsFixed(0)} hours',
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getGrowthColor() {
    double growth = getGrowthLevel();
    if (growth < 30) return Colors.green;
    if (growth < 60) return Colors.orange;
    return Colors.red;
  }
}

class EnzymeSimulation extends StatefulWidget {
  const EnzymeSimulation({super.key});

  @override
  State<EnzymeSimulation> createState() => _EnzymeSimulationState();
}

class _EnzymeSimulationState extends State<EnzymeSimulation> with SingleTickerProviderStateMixin {
  double temperature = 37.0;
  late AnimationController _reactionController;

  @override
  void initState() {
    super.initState();
    _reactionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _reactionController.dispose();
    super.dispose();
  }

  double getRate() {
    // Enzyme activity follows a bell curve with optimum around 37°C
    double diff = (temperature - 37.0).abs();
    if (diff > 40) return 0.0;
    return 100 * (1 - (diff / 40));
  }

  Color getSolutionColor() {
    double rate = getRate();
    if (rate < 25) return Colors.blue[100]!;
    if (rate < 50) return Colors.yellow[100]!;
    if (rate < 75) return Colors.orange[100]!;
    return Colors.red[100]!;
  }

  @override
  Widget build(BuildContext context) {
    double rate = getRate();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enzyme Reaction Under Temperature'),
        backgroundColor: Colors.red[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Reaction vessel
                  Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: getSolutionColor(),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 3.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10.0,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: AnimatedBuilder(
                      animation: _reactionController,
                      builder: (context, child) {
                        return Stack(
                          children: [
                            // Bubbles indicating activity
                            for (int i = 0; i < (rate / 10).floor(); i++)
                              Positioned(
                                left: 40.0 + (i * 25.0) % 120.0,
                                top: 40.0 + ((i * 20.0) % 120.0),
                                child: Container(
                                  width: 5.0 + _reactionController.value * 10.0,
                                  height: 5.0 + _reactionController.value * 10.0,
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.science,
                                    size: 40.0,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '${rate.toStringAsFixed(0)}%',
                                    style: const TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    'Activity',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  // Temperature gauge
                  Container(
                    width: 300.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Text(
                        'Temperature: ${temperature.toStringAsFixed(1)}°C',
                        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Activity curve
                  Container(
                    width: 300.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: CustomPaint(
                      painter: EnzymeActivityPainter(temperature, rate),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Slider(
                  value: temperature,
                  min: 0.0,
                  max: 100.0,
                  divisions: 100,
                  label: '${temperature.toStringAsFixed(1)}°C',
                  onChanged: (value) => setState(() => temperature = value),
                ),
                Text(
                  'Optimal Range: 35-40°C',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: (temperature >= 35 && temperature <= 40) ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EnzymeActivityPainter extends CustomPainter {
  final double temperature;
  final double rate;

  EnzymeActivityPainter(this.temperature, this.rate);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final optimalPaint = Paint()
      ..color = Colors.green.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final pointPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // Draw axes
    canvas.drawLine(Offset(30.0, size.height - 30.0), Offset(size.width - 10.0, size.height - 30.0), paint);
    canvas.drawLine(Offset(30.0, 20.0), Offset(30.0, size.height - 30.0), paint);

    // Draw optimal range
    canvas.drawRect(
      Rect.fromPoints(
        Offset(30.0 + (35.0 / 100) * (size.width - 40.0), 20.0),
        Offset(30.0 + (40.0 / 100) * (size.width - 40.0), size.height - 30.0),
      ),
      optimalPaint,
    );

    // Draw bell curve
    final path = Path();
    path.moveTo(30.0, size.height - 30.0);

    for (double temp = 0; temp <= 100; temp += 2) {
      double diff = (temp - 37.0).abs();
      double activity = diff > 40 ? 0.0 : 100 * (1 - (diff / 40));
      double xPos = 30.0 + (temp / 100) * (size.width - 40.0);
      double yPos = size.height - 30.0 - (activity / 100) * (size.height - 50.0);
      path.lineTo(xPos, yPos);
    }

    canvas.drawPath(path, paint);

    // Draw current point
    double currentX = 30.0 + (temperature / 100) * (size.width - 40.0);
    double currentY = size.height - 30.0 - (rate / 100) * (size.height - 50.0);
    canvas.drawCircle(Offset(currentX, currentY), 6.0, pointPaint);

    // Labels
    final textStyle = TextStyle(color: Colors.black, fontSize: 10.0);
    final textPainter = TextPainter(
      text: TextSpan(text: 'Temperature (°C)', style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(size.width / 2 - 40.0, size.height - 15.0));

    final textPainter2 = TextPainter(
      text: TextSpan(text: 'Activity %', style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter2.paint(canvas, Offset(5.0, size.height / 2 - 10.0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
