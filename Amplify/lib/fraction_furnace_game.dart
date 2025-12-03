// fraction_furnace_game.dart
import 'package:flutter/material.dart';
import 'dart:math';

class FractionFurnaceGame extends StatefulWidget {
  const FractionFurnaceGame({super.key});

  @override
  State<FractionFurnaceGame> createState() => _FractionFurnaceGameState();
}

class _FractionFurnaceGameState extends State<FractionFurnaceGame> {
  int numerator = 1;
  int denominator = 2;
  int score = 0;
  List<Map<String, dynamic>> options = [];

  @override
  void initState() {
    super.initState();
    _generateProblem();
  }

  void _generateProblem() {
    setState(() {
      denominator = [2, 3, 4, 6, 8][Random().nextInt(5)];
      numerator = Random().nextInt(denominator - 1) + 1;

      options = [];
      // Correct answer
      options.add({'numerator': numerator, 'denominator': denominator, 'isCorrect': true});

      // Wrong answers
      while (options.length < 4) {
        int wrongNum = Random().nextInt(denominator - 1) + 1;
        int wrongDen = denominator;

        bool alreadyExists = options.any((opt) =>
        opt['numerator'] == wrongNum && opt['denominator'] == wrongDen);

        if (!alreadyExists && wrongNum != numerator) {
          options.add({'numerator': wrongNum, 'denominator': wrongDen, 'isCorrect': false});
        }
      }
      options.shuffle();
    });
  }

  void _checkAnswer(bool isCorrect) {
    if (isCorrect) {
      setState(() {
        score++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🧪 Perfect potion!', style: TextStyle(fontSize: 16)),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 800),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Future.delayed(const Duration(milliseconds: 1200), _generateProblem);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚗️ Try again!', style: TextStyle(fontSize: 16)),
          backgroundColor: Colors.orange,
          duration: Duration(milliseconds: 800),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🧪 Fraction Furnace'),
        backgroundColor: Colors.purple.shade700,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'Score: $score',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade200, Colors.purple.shade50],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text(
                  '🧙‍♂️ Mix the correct fraction!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 30),

                // Visual Fraction Display
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.shade200,
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Recipe needed:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildFractionCircle(numerator, denominator),
                      const SizedBox(height: 15),
                      Text(
                        'Fill $numerator out of $denominator parts',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                const Text(
                  'Select the matching fraction:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),

                // Options - FIXED OVERFLOW
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final option = options[index];
                    return _buildOptionCard(
                      option['numerator'],
                      option['denominator'],
                      option['isCorrect'],
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFractionCircle(int num, int den) {
    return SizedBox(
      width: 200,
      height: 200,
      child: CustomPaint(
        painter: FractionCirclePainter(numerator: num, denominator: den),
      ),
    );
  }

  Widget _buildOptionCard(int num, int den, bool isCorrect) {
    return GestureDetector(
      onTap: () => _checkAnswer(isCorrect),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade300, Colors.orange.shade500],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.shade200,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '⚗️',
              style: TextStyle(fontSize: 35),
            ),
            const SizedBox(height: 8),
            Text(
              '$num',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Container(
              height: 3,
              width: 40,
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 4),
            ),
            Text(
              '$den',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FractionCirclePainter extends CustomPainter {
  final int numerator;
  final int denominator;

  FractionCirclePainter({required this.numerator, required this.denominator});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final anglePerSection = (2 * pi) / denominator;

    // Draw filled sections
    for (int i = 0; i < denominator; i++) {
      final paint = Paint()
        ..color = i < numerator ? Colors.purple.shade400 : Colors.grey.shade300
        ..style = PaintingStyle.fill;

      final startAngle = -pi / 2 + (i * anglePerSection);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        anglePerSection,
        true,
        paint,
      );

      // Draw borders
      final borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        anglePerSection,
        true,
        borderPaint,
      );
    }

    // Draw outer circle
    final outerPaint = Paint()
      ..color = Colors.purple.shade700
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(center, radius, outerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
