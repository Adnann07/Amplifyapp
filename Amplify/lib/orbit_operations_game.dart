// orbit_operations_game.dart
import 'package:flutter/material.dart';
import 'dart:math';

class OrbitOperationsGame extends StatefulWidget {
  const OrbitOperationsGame({super.key});

  @override
  State<OrbitOperationsGame> createState() => _OrbitOperationsGameState();
}

class _OrbitOperationsGameState extends State<OrbitOperationsGame>
    with SingleTickerProviderStateMixin {
  double decimal1 = 0.5;
  String fraction2 = '1/2';
  String comparisonSign = '';
  int score = 0;
  late AnimationController _rocketController;

  @override
  void initState() {
    super.initState();
    _rocketController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _generateProblem();
  }

  @override
  void dispose() {
    _rocketController.dispose();
    super.dispose();
  }

  void _generateProblem() {
    setState(() {
      final problemType = Random().nextInt(2);

      if (problemType == 0) {
        // Decimal comparison
        decimal1 = (Random().nextInt(90) + 10) / 100; // 0.10 to 0.99
        double decimal2 = (Random().nextInt(90) + 10) / 100;
        fraction2 = '${(decimal2 * 100).round()}/100';

        if (decimal1 > decimal2) {
          comparisonSign = '>';
        } else if (decimal1 < decimal2) {
          comparisonSign = '<';
        } else {
          comparisonSign = '=';
        }
      } else {
        // Fraction to decimal
        final denominators = [2, 4, 5, 10];
        final den = denominators[Random().nextInt(denominators.length)];
        final num = Random().nextInt(den - 1) + 1;
        fraction2 = '$num/$den';
        decimal1 = (Random().nextInt(90) + 10) / 100;

        double fractionValue = num / den;
        if (decimal1 > fractionValue) {
          comparisonSign = '>';
        } else if (decimal1 < fractionValue) {
          comparisonSign = '<';
        } else {
          comparisonSign = '=';
        }
      }
    });
  }

  void _checkAnswer(String selected) {
    if (selected == comparisonSign) {
      setState(() {
        score++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🚀 Rocket fueled!', style: TextStyle(fontSize: 16)),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 800),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Future.delayed(const Duration(milliseconds: 1200), _generateProblem);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🛸 Try again!', style: TextStyle(fontSize: 16)),
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
        title: const Text('🚀 Orbit Operations'),
        backgroundColor: Colors.indigo.shade900,
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
            colors: [Colors.indigo.shade900, Colors.purple.shade900, Colors.black],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Stars
              ...List.generate(50, (index) {
                return Positioned(
                  left: Random().nextDouble() * 400,
                  top: Random().nextDouble() * 800,
                  child: const Text('⭐', style: TextStyle(fontSize: 12)),
                );
              }),

              // Main Content
              SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    AnimatedBuilder(
                      animation: _rocketController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _rocketController.value * 20 - 10),
                          child: const Text('🚀', style: TextStyle(fontSize: 80)),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Compare the values!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Comparison Display - FIXED OVERFLOW
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.cyan, width: 3),
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _buildValueBox(decimal1.toStringAsFixed(2), Colors.blue),
                          const Text(
                            '?',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _buildValueBox(fraction2, Colors.purple),
                        ],
                      ),
                    ),

                    const SizedBox(height: 50),

                    // Comparison Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildComparisonButton('<'),
                        _buildComparisonButton('='),
                        _buildComparisonButton('>'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValueBox(String value, MaterialColor color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color, width: 2),
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildComparisonButton(String symbol) {
    return GestureDetector(
      onTap: () => _checkAnswer(symbol),
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyan.shade400, Colors.blue.shade600],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.cyan.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            symbol,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
