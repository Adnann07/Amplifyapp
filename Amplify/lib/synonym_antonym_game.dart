// synonym_antonym_game.dart
import 'package:flutter/material.dart';
import 'dart:math';

class SynonymAntonymGame extends StatefulWidget {
  const SynonymAntonymGame({super.key});

  @override
  State<SynonymAntonymGame> createState() => _SynonymAntonymGameState();
}

class _SynonymAntonymGameState extends State<SynonymAntonymGame> {
  final Map<String, Map<String, List<String>>> wordPairs = {
    'happy': {'synonyms': ['joyful', 'glad', 'cheerful'], 'antonyms': ['sad', 'unhappy', 'gloomy']},
    'big': {'synonyms': ['large', 'huge', 'giant'], 'antonyms': ['small', 'tiny', 'little']},
    'fast': {'synonyms': ['quick', 'speedy', 'rapid'], 'antonyms': ['slow', 'sluggish', 'gradual']},
    'hot': {'synonyms': ['warm', 'heated', 'burning'], 'antonyms': ['cold', 'cool', 'freezing']},
    'bright': {'synonyms': ['shiny', 'brilliant', 'radiant'], 'antonyms': ['dark', 'dim', 'dull']},
  };

  String targetWord = '';
  String questionType = 'synonym'; // or 'antonym'
  List<String> options = [];
  String correctAnswer = '';
  int score = 0;

  @override
  void initState() {
    super.initState();
    _generateProblem();
  }

  void _generateProblem() {
    setState(() {
      final words = wordPairs.keys.toList();
      targetWord = words[Random().nextInt(words.length)];
      questionType = Random().nextBool() ? 'synonym' : 'antonym';

      final correctOptions = wordPairs[targetWord]![questionType + 's']!;
      correctAnswer = correctOptions[Random().nextInt(correctOptions.length)];

      // Get wrong options from opposite type
      final oppositeType = questionType == 'synonym' ? 'antonyms' : 'synonyms';
      final wrongOptions = List<String>.from(wordPairs[targetWord]![oppositeType]!);

      options = [correctAnswer];
      wrongOptions.shuffle();
      options.addAll(wrongOptions.take(3));
      options.shuffle();
    });
  }

  void _checkAnswer(String selected) {
    if (selected == correctAnswer) {
      setState(() {
        score++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            questionType == 'synonym' ? '☀️ Correct synonym!' : '🌙 Correct antonym!',
            style: const TextStyle(fontSize: 16),
          ),
          backgroundColor: Colors.green,
          duration: const Duration(milliseconds: 800),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Future.delayed(const Duration(milliseconds: 1200), _generateProblem);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🏜️ Try again!', style: TextStyle(fontSize: 16)),
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
        title: const Text('🏜️ Word Oasis'),
        backgroundColor: Colors.orange.shade700,
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
            colors: [Colors.orange.shade200, Colors.yellow.shade100],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  questionType == 'synonym' ? '☀️ Find the SYNONYM' : '🌙 Find the ANTONYM',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: questionType == 'synonym' ? Colors.orange.shade900 : Colors.indigo.shade900,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  questionType == 'synonym' ? '(Same meaning)' : '(Opposite meaning)',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 40),

                // Target Word Display
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.shade300,
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        questionType == 'synonym' ? '☀️' : '🌙',
                        style: const TextStyle(fontSize: 60),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        targetWord.toUpperCase(),
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: questionType == 'synonym'
                              ? Colors.orange.shade700
                              : Colors.indigo.shade700,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // Options
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 15,
                      childAspectRatio: 3.5,
                    ),
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      return _buildOptionButton(options[index]);
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

  Widget _buildOptionButton(String word) {
    return GestureDetector(
      onTap: () => _checkAnswer(word),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: questionType == 'synonym'
                ? [Colors.yellow.shade400, Colors.orange.shade400]
                : [Colors.indigo.shade400, Colors.purple.shade400],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: questionType == 'synonym'
                  ? Colors.orange.shade300
                  : Colors.indigo.shade300,
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            word,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
