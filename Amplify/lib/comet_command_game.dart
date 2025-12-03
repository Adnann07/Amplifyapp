// comet_command_game.dart
import 'package:flutter/material.dart';
import 'dart:math';

class CometCommandGame extends StatefulWidget {
  const CometCommandGame({super.key});

  @override
  State<CometCommandGame> createState() => _CometCommandGameState();
}

class _CometCommandGameState extends State<CometCommandGame> {
  final List<Map<String, String>> sentences = [
    {
      'main': 'The cat sleeps',
      'dependent': 'when it is tired',
      'combined': 'The cat sleeps when it is tired.'
    },
    {
      'main': 'I will go outside',
      'dependent': 'if it stops raining',
      'combined': 'I will go outside if it stops raining.'
    },
    {
      'main': 'She reads books',
      'dependent': 'because she loves stories',
      'combined': 'She reads books because she loves stories.'
    },
    {
      'main': 'We play soccer',
      'dependent': 'after school ends',
      'combined': 'We play soccer after school ends.'
    },
  ];

  String mainClause = '';
  String dependentClause = '';
  String correctSentence = '';
  String userSentence = '';
  int score = 0;

  @override
  void initState() {
    super.initState();
    _generateProblem();
  }

  void _generateProblem() {
    setState(() {
      final sentence = sentences[Random().nextInt(sentences.length)];
      mainClause = sentence['main']!;
      dependentClause = sentence['dependent']!;
      correctSentence = sentence['combined']!;
      userSentence = '';
    });
  }

  void _buildSentence() {
    setState(() {
      userSentence = '$mainClause $dependentClause.';
    });
  }

  void _checkSentence() {
    if (userSentence.trim().toLowerCase() == correctSentence.toLowerCase()) {
      setState(() {
        score++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('☄️ Perfect transmission!', style: TextStyle(fontSize: 16)),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 800),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Future.delayed(const Duration(milliseconds: 1500), _generateProblem);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('📡 Try again!', style: TextStyle(fontSize: 16)),
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
        title: const Text('☄️ Comet Command'),
        backgroundColor: Colors.deepPurple.shade900,
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
            colors: [Colors.indigo.shade900, Colors.black],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  '📡 Space Station Repairs',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Combine the clauses!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.cyan,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 40),

                // Main Clause
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade700, Colors.blue.shade500],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        '🛰️ Main Clause',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        mainClause,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Dependent Clause
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple.shade700, Colors.purple.shade500],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.5),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        '☄️ Dependent Clause',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        dependentClause,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Combined Sentence Display
                Container(
                  height: 120,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.cyan, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      userSentence.isEmpty ? 'Tap "Combine" below' : userSentence,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: userSentence.isEmpty ? Colors.grey : Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _buildSentence,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan.shade600,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          '🔗 Combine',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: userSentence.isNotEmpty ? _checkSentence : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          '✅ Check',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
