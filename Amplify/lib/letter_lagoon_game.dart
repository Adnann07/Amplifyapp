// letter_lagoon_game.dart
import 'package:flutter/material.dart';
import 'dart:math';

class LetterLagoonGame extends StatefulWidget {
  const LetterLagoonGame({super.key});

  @override
  State<LetterLagoonGame> createState() => _LetterLagoonGameState();
}

class _LetterLagoonGameState extends State<LetterLagoonGame>
    with TickerProviderStateMixin {
  final Map<String, Map<String, String>> wordData = {
    '🐱': {'word': 'Cat', 'letter': 'C'},
    '🐶': {'word': 'Dog', 'letter': 'D'},
    '🐟': {'word': 'Fish', 'letter': 'F'},
    '🐝': {'word': 'Bee', 'letter': 'B'},
    '🐘': {'word': 'Elephant', 'letter': 'E'},
    '🦁': {'word': 'Lion', 'letter': 'L'},
    '🐯': {'word': 'Tiger', 'letter': 'T'},
    '🐻': {'word': 'Bear', 'letter': 'B'},
    '🐰': {'word': 'Rabbit', 'letter': 'R'},
    '🐵': {'word': 'Monkey', 'letter': 'M'},
  };

  String currentEmoji = '🐱';
  String currentWord = 'Cat';
  String correctLetter = 'C';
  List<String> letterOptions = [];
  int score = 0;
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      4,
          (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2500 + index * 400),
      )..repeat(),
    );
    _generateProblem();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _generateProblem() {
    setState(() {
      final entries = wordData.entries.toList();
      final randomEntry = entries[Random().nextInt(entries.length)];
      currentEmoji = randomEntry.key;
      currentWord = randomEntry.value['word']!;
      correctLetter = randomEntry.value['letter']!;

      // Generate letter options (FIXED LOGIC)
      letterOptions = [correctLetter];
      final allLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
      allLetters.remove(correctLetter); // Remove correct letter from pool

      while (letterOptions.length < 4) {
        String letter = allLetters[Random().nextInt(allLetters.length)];
        if (!letterOptions.contains(letter)) {
          letterOptions.add(letter);
        }
      }
      letterOptions.shuffle();
    });
  }

  void _checkAnswer(String selected) {
    if (selected == correctLetter) {
      setState(() {
        score++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🎣 Perfect catch!', style: TextStyle(fontSize: 16)),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 800),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Future.delayed(const Duration(milliseconds: 1200), _generateProblem);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🐟 Try fishing again!', style: TextStyle(fontSize: 16)),
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
        title: const Text('🎣 Letter Lagoon'),
        backgroundColor: Colors.blue.shade700,
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
            colors: [Colors.blue.shade300, Colors.cyan.shade100],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Current Animal Card
            Container(
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade200,
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'What letter does it start with?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(currentEmoji, style: const TextStyle(fontSize: 90)),
                  const SizedBox(height: 10),
                  Text(
                    currentWord,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '🎣 Tap the fish with the correct letter:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Fishing Area
            Expanded(
              child: Stack(
                children: List.generate(letterOptions.length, (index) {
                  return _buildSwimmingFish(
                    letterOptions[index],
                    index,
                    _controllers[index],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwimmingFish(
      String letter, int index, AnimationController controller) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final xPosition = (controller.value * screenWidth) % screenWidth;
        final yPosition = 50.0 + (index * 100.0);

        return Positioned(
          left: xPosition,
          top: yPosition,
          child: GestureDetector(
            onTap: () => _checkAnswer(letter),
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade600, Colors.blue.shade400],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade300,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Text('🐠', style: TextStyle(fontSize: 35)),
                  ),
                  Center(
                    child: Text(
                      letter,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
