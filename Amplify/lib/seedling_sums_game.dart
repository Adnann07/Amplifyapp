// seedling_sums_game.dart
import 'package:flutter/material.dart';
import 'dart:math';

class SeedlingSumsGame extends StatefulWidget {
  const SeedlingSumsGame({super.key});

  @override
  State<SeedlingSumsGame> createState() => _SeedlingSumsGameState();
}

class _SeedlingSumsGameState extends State<SeedlingSumsGame> {
  int num1 = 0;
  int num2 = 0;
  int correctAnswer = 0;
  int score = 0;
  List<int> options = [];
  bool isSubtraction = false;

  @override
  void initState() {
    super.initState();
    _generateProblem();
  }

  void _generateProblem() {
    setState(() {
      isSubtraction = Random().nextBool();

      if (isSubtraction) {
        num1 = Random().nextInt(6) + 5; // 5-10
        num2 = Random().nextInt(num1); // Ensure positive result
        correctAnswer = num1 - num2;
      } else {
        num1 = Random().nextInt(5) + 1;
        num2 = Random().nextInt(5) + 1;
        correctAnswer = num1 + num2;
      }

      // Generate 4 unique options
      options = [correctAnswer];
      while (options.length < 4) {
        int option = max(1, correctAnswer + Random().nextInt(5) - 2);
        if (!options.contains(option) && option <= 20) {
          options.add(option);
        }
      }
      options.shuffle();
    });
  }

  void _checkAnswer(int selected) {
    if (selected == correctAnswer) {
      setState(() {
        score++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Text('🎉 Correct! Great job!', style: TextStyle(fontSize: 16)),
            ],
          ),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 800),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Future.delayed(const Duration(milliseconds: 1200), () {
        _generateProblem();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🌱 Try again!', style: TextStyle(fontSize: 16)),
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
        title: const Text('🌰 Seedling Sums'),
        backgroundColor: Colors.green.shade700,
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
            colors: [Colors.green.shade100, Colors.green.shade50],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // Squirrel Character
                  const Text('🐿️', style: TextStyle(fontSize: 80)),
                  const SizedBox(height: 10),
                  const Text(
                    'Help me collect the right number of nuts!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Problem Display - FIXED OVERFLOW
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade300,
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _buildNutGroup(num1),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                isSubtraction ? '−' : '+',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: isSubtraction ? Colors.red.shade600 : Colors.green.shade600,
                                ),
                              ),
                            ),
                            _buildNutGroup(num2),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '=',
                                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade100,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text(
                                '?',
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Answer Options
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Tap the correct answer:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 15,
                          runSpacing: 15,
                          alignment: WrapAlignment.center,
                          children: options.map((option) {
                            return _buildAnswerButton(option);
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNutGroup(int count) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.brown.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: List.generate(count, (index) {
          return const Text('🌰', style: TextStyle(fontSize: 24));
        }),
      ),
    );
  }

  Widget _buildAnswerButton(int number) {
    return GestureDetector(
      onTap: () => _checkAnswer(number),
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.orange.shade400, Colors.orange.shade600],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.shade300,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            '$number',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
