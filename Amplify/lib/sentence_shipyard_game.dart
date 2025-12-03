// sentence_shipyard_game.dart
import 'package:flutter/material.dart';
import 'dart:math';

class SentenceShipyardGame extends StatefulWidget {
  const SentenceShipyardGame({super.key});

  @override
  State<SentenceShipyardGame> createState() => _SentenceShipyardGameState();
}

class _SentenceShipyardGameState extends State<SentenceShipyardGame> {
  List<Map<String, dynamic>> sentences = [
    {'words': ['The', 'cat', 'is', 'sleeping'], 'punctuation': '.'},
    {'words': ['I', 'like', 'to', 'play'], 'punctuation': '.'},
    {'words': ['What', 'is', 'your', 'name'], 'punctuation': '?'},
    {'words': ['The', 'dog', 'runs', 'fast'], 'punctuation': '.'},
    {'words': ['Can', 'you', 'help', 'me'], 'punctuation': '?'},
    {'words': ['She', 'loves', 'ice', 'cream'], 'punctuation': '.'},
    {'words': ['Where', 'are', 'you', 'going'], 'punctuation': '?'},
    {'words': ['We', 'are', 'happy', 'today'], 'punctuation': '!'},
  ];

  List<String> scrambledWords = [];
  List<String> correctOrder = [];
  List<String> userSentence = [];
  String correctPunctuation = '.';
  int score = 0;

  @override
  void initState() {
    super.initState();
    _generateProblem();
  }

  void _generateProblem() {
    setState(() {
      final sentence = sentences[Random().nextInt(sentences.length)];
      correctOrder = List<String>.from(sentence['words']);
      correctPunctuation = sentence['punctuation'];
      scrambledWords = List<String>.from(correctOrder);
      scrambledWords.shuffle();
      userSentence = [];
    });
  }

  void _checkSentence() {
    bool isCorrect = userSentence.length == correctOrder.length;
    if (isCorrect) {
      for (int i = 0; i < userSentence.length; i++) {
        if (userSentence[i] != correctOrder[i]) {
          isCorrect = false;
          break;
        }
      }
    }

    if (isCorrect) {
      setState(() {
        score++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⛵ Perfect sentence!', style: TextStyle(fontSize: 16)),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 800),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Future.delayed(const Duration(milliseconds: 1500), _generateProblem);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🔧 Try again!', style: TextStyle(fontSize: 16)),
          backgroundColor: Colors.orange,
          duration: Duration(milliseconds: 800),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _addWord(String word) {
    setState(() {
      userSentence.add(word);
      scrambledWords.remove(word);
    });
  }

  void _removeWord(String word) {
    setState(() {
      scrambledWords.add(word);
      userSentence.remove(word);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('⛵ Sentence Shipyard'),
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
            colors: [Colors.lightBlue.shade100, Colors.lightBlue.shade50],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text(
                  '🚢 Build the correct sentence!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 30),

                // User's Sentence Building Area
                Container(
                  height: 150,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue.shade400, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade200,
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Sentence:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: userSentence.isEmpty
                            ? const Center(
                          child: Text(
                            'Tap words below to build...',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                            : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: userSentence.map((word) {
                            return GestureDetector(
                              onTap: () => _removeWord(word),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.green.shade400,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  word,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green.shade900,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Available Words
                const Text(
                  'Tap words to add:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: scrambledWords.map((word) {
                        return GestureDetector(
                          onTap: () => _addWord(word),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.orange.shade300,
                                  Colors.orange.shade400,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange.shade200,
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              word,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Check Button
                ElevatedButton(
                  onPressed: userSentence.length == correctOrder.length
                      ? _checkSentence
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    '✅ Check Sentence',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
