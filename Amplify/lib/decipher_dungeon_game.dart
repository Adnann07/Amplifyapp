// decipher_dungeon_game.dart
import 'package:flutter/material.dart';
import 'dart:math';

class DecipherDungeonGame extends StatefulWidget {
  const DecipherDungeonGame({super.key});

  @override
  State<DecipherDungeonGame> createState() => _DecipherDungeonGameState();
}

class _DecipherDungeonGameState extends State<DecipherDungeonGame> {
  int score = 0;
  int doorLevel = 1;
  String currentProblem = '';
  int correctAnswer = 0;
  List<int> options = [];

  @override
  void initState() {
    super.initState();
    _generateProblem();
  }

  void _generateProblem() {
    final problemType = Random().nextInt(3);

    setState(() {
      switch (problemType) {
        case 0: // Two-step addition/subtraction
          int a = Random().nextInt(50) + 10;
          int b = Random().nextInt(30) + 5;
          int c = Random().nextInt(20) + 5;
          correctAnswer = a + b - c;
          currentProblem = '$a + $b - $c = ?';
          break;
        case 1: // Multiplication
          int x = Random().nextInt(9) + 2;
          int y = Random().nextInt(9) + 2;
          correctAnswer = x * y;
          currentProblem = '$x × $y = ?';
          break;
        case 2: // Division
          int divisor = Random().nextInt(8) + 2;
          int quotient = Random().nextInt(10) + 2;
          int dividend = divisor * quotient;
          correctAnswer = quotient;
          currentProblem = '$dividend ÷ $divisor = ?';
          break;
      }

      // Generate options
      options = [correctAnswer];
      while (options.length < 4) {
        int option = max(1, correctAnswer + Random().nextInt(15) - 7);
        if (!options.contains(option)) {
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
        doorLevel++;
        if (doorLevel > 10) doorLevel = 10;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🗝️ Door unlocked!', style: TextStyle(fontSize: 16)),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 800),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Future.delayed(const Duration(milliseconds: 1200), _generateProblem);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🚪 Try again!', style: TextStyle(fontSize: 16)),
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
        title: const Text('🏛️ Decipher Dungeon'),
        backgroundColor: Colors.deepPurple.shade700,
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
            colors: [Colors.deepPurple.shade900, Colors.deepPurple.shade700],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    '🗝️ Solve to unlock doors!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Dungeon Progress
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.amber, width: 2),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Dungeon Progress',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 5,
                          runSpacing: 5,
                          children: List.generate(10, (index) {
                            return Text(
                              index < doorLevel ? '🚪' : '🔒',
                              style: const TextStyle(fontSize: 24),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Problem Display - FIXED OVERFLOW
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(0.3),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          '🔮 Mysterious Problem',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 20),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            currentProblem,
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Answer Options
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      return _buildAnswerButton(options[index]);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerButton(int number) {
    return GestureDetector(
      onTap: () => _checkAnswer(number),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber.shade600, Colors.amber.shade800],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.amber.shade400,
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            '$number',
            style: const TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
