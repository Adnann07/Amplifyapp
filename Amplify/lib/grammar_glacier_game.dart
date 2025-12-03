// grammar_glacier_game.dart
import 'package:flutter/material.dart';
import 'dart:math';

class GrammarGlacierGame extends StatefulWidget {
  const GrammarGlacierGame({super.key});

  @override
  State<GrammarGlacierGame> createState() => _GrammarGlacierGameState();
}

class _GrammarGlacierGameState extends State<GrammarGlacierGame> {
  final Map<String, List<String>> wordsByType = {
    'noun': ['cat', 'dog', 'tree', 'book', 'car', 'house', 'apple', 'chair'],
    'verb': ['run', 'jump', 'eat', 'sleep', 'play', 'write', 'read', 'sing'],
    'adjective': ['happy', 'big', 'small', 'red', 'fast', 'slow', 'pretty', 'brave'],
  };

  String targetType = 'noun';
  List<Map<String, String>> currentWords = [];
  int score = 0;

  @override
  void initState() {
    super.initState();
    _generateProblem();
  }

  void _generateProblem() {
    setState(() {
      targetType = wordsByType.keys.elementAt(Random().nextInt(3));
      currentWords = [];

      // Add correct word
      String correctWord = wordsByType[targetType]![Random().nextInt(wordsByType[targetType]!.length)];
      currentWords.add({'word': correctWord, 'type': targetType});

      // Add wrong words
      for (String type in wordsByType.keys) {
        if (type != targetType) {
          String word = wordsByType[type]![Random().nextInt(wordsByType[type]!.length)];
          currentWords.add({'word': word, 'type': type});
        }
      }

      currentWords.shuffle();
    });
  }

  void _checkAnswer(String word, String type) {
    if (type == targetType) {
      setState(() {
        score++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❄️ Correct! Crystal collected!', style: TextStyle(fontSize: 16)),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 800),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Future.delayed(const Duration(milliseconds: 1200), _generateProblem);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🧊 Try again!', style: TextStyle(fontSize: 16)),
          backgroundColor: Colors.orange,
          duration: Duration(milliseconds: 800),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  String _getTypeIcon(String type) {
    switch (type) {
      case 'noun':
        return '📦';
      case 'verb':
        return '⚡';
      case 'adjective':
        return '🎨';
      default:
        return '💎';
    }
  }

  MaterialColor _getTypeColor(String type) {
    switch (type) {
      case 'noun':
        return Colors.blue;
      case 'verb':
        return Colors.red;
      case 'adjective':
        return Colors.green;
      default:
        return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('❄️ Grammar Glacier'),
        backgroundColor: Colors.cyan.shade700,
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
            colors: [Colors.cyan.shade200, Colors.cyan.shade50],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  '🧊 Grammar Cave Explorer',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan,
                  ),
                ),
                const SizedBox(height: 30),

                // Target Type Display
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyan.shade200,
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Find the:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _getTypeIcon(targetType),
                            style: const TextStyle(fontSize: 50),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            targetType.toUpperCase(),
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: _getTypeColor(targetType),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Legend
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _LegendItem(icon: '📦', label: 'Noun', color: Colors.blue),
                          _LegendItem(icon: '⚡', label: 'Verb', color: Colors.red),
                          _LegendItem(icon: '🎨', label: 'Adjective', color: Colors.green),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Word Crystals
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 15,
                      childAspectRatio: 3,
                    ),
                    itemCount: currentWords.length,
                    itemBuilder: (context, index) {
                      final wordData = currentWords[index];
                      return _buildWordCrystal(
                        wordData['word']!,
                        wordData['type']!,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWordCrystal(String word, String type) {
    final typeColor = _getTypeColor(type);
    return GestureDetector(
      onTap: () => _checkAnswer(word, type),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [typeColor.shade300, typeColor.shade500],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: typeColor.shade200,
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _getTypeIcon(type),
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(width: 20),
            Text(
              word,
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

class _LegendItem extends StatelessWidget {
  final String icon;
  final String label;
  final MaterialColor color;

  const _LegendItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
