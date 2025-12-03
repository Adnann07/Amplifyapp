import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:async';

class BrainSharperPage extends StatelessWidget {
  const BrainSharperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Brain Sharper'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            const Text(
              'Choose a Game to Sharpen Your Brain!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 48),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MentalMathPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Mental Math',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MemoryExercisesPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Memory Exercises',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReactionTimePage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Reaction Time',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MentalMathPage extends StatefulWidget {
  const MentalMathPage({super.key});
  @override
  State<MentalMathPage> createState() => _MentalMathPageState();
}
class _MentalMathPageState extends State<MentalMathPage> {
  String currentQuestion = '';
  int correctAnswer = 0;
  int userAnswer = 0;
  int score = 0;
  int streak = 0;
  int totalQuestions = 0;
  String difficulty = 'Easy';
  Timer? gameTimer;
  int timeLeft = 60;
  bool isGameActive = false;
  List<int> answerOptions = [];
  final Random random = Random();
  final TextEditingController answerController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadStats();
    generateNewQuestion();
  }
  @override
  void dispose() {
    gameTimer?.cancel();
    answerController.dispose();
    super.dispose();
  }
  Future<void> loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      score = prefs.getInt('mathScore') ?? 0;
      streak = prefs.getInt('mathStreak') ?? 0;
    });
  }
  Future<void> saveStats() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('mathScore', score);
    await prefs.setInt('mathStreak', streak);
  }
  void generateNewQuestion() {
    int num1, num2;
    String operation;
    switch (difficulty) {
      case 'Easy':
        num1 = random.nextInt(20) + 1;
        num2 = random.nextInt(20) + 1;
        operation = ['+', '-'][random.nextInt(2)];
        break;
      case 'Medium':
        num1 = random.nextInt(50) + 1;
        num2 = random.nextInt(50) + 1;
        operation = ['+', '-', '*'][random.nextInt(3)];
        break;
      case 'Hard':
        num1 = random.nextInt(100) + 1;
        num2 = random.nextInt(100) + 1;
        operation = ['+', '-', '*', '/'][random.nextInt(4)];
        break;
      default:
        num1 = random.nextInt(10) + 1;
        num2 = random.nextInt(10) + 1;
        operation = '+';
    }
    // Handle division to ensure whole numbers
    if (operation == '/') {
      correctAnswer = num1;
      num1 = correctAnswer * num2;
    } else {
      switch (operation) {
        case '+':
          correctAnswer = num1 + num2;
          break;
        case '-':
          if (num1 < num2) {
            int temp = num1;
            num1 = num2;
            num2 = temp;
          }
          correctAnswer = num1 - num2;
          break;
        case '*':
          correctAnswer = num1 * num2;
          break;
      }
    }
    setState(() {
      currentQuestion = '$num1 $operation $num2 = ?';
      answerOptions = generateAnswerOptions();
    });
    answerController.clear();
  }
  List<int> generateAnswerOptions() {
    List<int> options = [correctAnswer];
    while (options.length < 4) {
      int wrongAnswer;
      if (difficulty == 'Easy') {
        wrongAnswer = correctAnswer + (random.nextInt(20) - 10);
      } else {
        wrongAnswer = correctAnswer + (random.nextInt(40) - 20);
      }
      if (wrongAnswer != correctAnswer && !options.contains(wrongAnswer) &&
          wrongAnswer > 0) {
        options.add(wrongAnswer);
      }
    }
    options.shuffle();
    return options;
  }
  void checkAnswer(int answer) {
    bool isCorrect = answer == correctAnswer;
    setState(() {
      totalQuestions++;
      if (isCorrect) {
        score++;
        streak++;
      } else {
        streak = 0;
      }
    });
    showAnswerDialog(isCorrect);
    saveStats();
  }
  void showAnswerDialog(bool isCorrect) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          AlertDialog(
            backgroundColor: Colors.grey[900],
            title: Text(
              isCorrect ? 'Correct! 🎉' : 'Incorrect 😞',
              style: TextStyle(
                color: isCorrect ? Colors.greenAccent : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              isCorrect
                  ? 'Great job! Keep it up!'
                  : 'The correct answer was $correctAnswer',
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  generateNewQuestion();
                },
                child: const Text('Next Question'),
              ),
            ],
          ),
    );
  }
  void startTimedGame() {
    setState(() {
      isGameActive = true;
      timeLeft = 60;
      score = 0;
      totalQuestions = 0;
    });
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeLeft--;
      });
      if (timeLeft <= 0) {
        endGame();
      }
    });
  }
  void endGame() {
    gameTimer?.cancel();
    setState(() {
      isGameActive = false;
    });
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            backgroundColor: Colors.grey[900],
            title: const Text(
              'Game Over!',
              style: TextStyle(
                  color: Colors.greenAccent, fontWeight: FontWeight.bold),
            ),
            content: Text(
              'You answered $score out of $totalQuestions questions correctly!\nAccuracy: ${totalQuestions >
                  0 ? ((score / totalQuestions) * 100).round() : 0}%',
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
  Widget buildDifficultySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: ['Easy', 'Medium', 'Hard'].map((level) {
        return GestureDetector(
          onTap: () {
            setState(() {
              difficulty = level;
            });
            generateNewQuestion();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: difficulty == level ? Colors.greenAccent : Colors
                  .grey[800],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              level,
              style: TextStyle(
                color: difficulty == level ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
  Widget buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.greenAccent, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Mental Math'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Timer (if game is active)
            if (isGameActive) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: timeLeft <= 10 ? Colors.red[900] : Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Time Left: ${timeLeft}s',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            // Stats
            Row(
              children: [
                Expanded(child: buildStatCard(
                    'Score', score.toString(), Icons.star)),
                const SizedBox(width: 12),
                Expanded(child: buildStatCard(
                    'Streak', streak.toString(), Icons.local_fire_department)),
                const SizedBox(width: 12),
                Expanded(child: buildStatCard(
                    'Questions', totalQuestions.toString(), Icons.quiz)),
              ],
            ),
            const SizedBox(height: 24),
            // Difficulty selector
            const Text(
              'Difficulty',
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            buildDifficultySelector(),
            const SizedBox(height: 32),
            // Question
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                currentQuestion,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Answer options
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: answerOptions.map((option) {
                return GestureDetector(
                  onTap: () => checkAnswer(option),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        option.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            // Start timed game button
            GestureDetector(
              onTap: isGameActive ? null : startTimedGame,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: isGameActive ? Colors.grey[700] : Colors.greenAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isGameActive
                      ? 'Game in Progress...'
                      : 'Start 60-Second Challenge',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isGameActive ? Colors.white70 : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MemoryExercisesPage extends StatefulWidget {
  const MemoryExercisesPage({super.key});
  @override
  State<MemoryExercisesPage> createState() => _MemoryExercisesPageState();
}
class _MemoryExercisesPageState extends State<MemoryExercisesPage> {
  String currentGame = 'Number Sequence';
  List<int> sequence = [];
  List<int> userSequence = [];
  int currentLevel = 1;
  int score = 0;
  bool showingSequence = false;
  bool gameActive = false;
  Timer? displayTimer;
  int currentDisplayIndex = 0;
  // Color Memory Game
  List<Color> colorSequence = [];
  List<Color> availableColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
  ];
  final Random random = Random();
  @override
  void initState() {
    super.initState();
    loadStats();
  }
  @override
  void dispose() {
    displayTimer?.cancel();
    super.dispose();
  }
  Future<void> loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      score = prefs.getInt('memoryScore') ?? 0;
      currentLevel = prefs.getInt('memoryLevel') ?? 1;
    });
  }
  Future<void> saveStats() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('memoryScore', score);
    await prefs.setInt('memoryLevel', currentLevel);
  }
  void startNumberSequenceGame() {
    setState(() {
      gameActive = true;
      showingSequence = true;
      sequence.clear();
      userSequence.clear();
      currentDisplayIndex = 0;
    });
    // Generate sequence based on level
    int sequenceLength = 3 + currentLevel;
    for (int i = 0; i < sequenceLength; i++) {
      sequence.add(random.nextInt(9) + 1);
    }
    // Display sequence
    displaySequence();
  }
  void displaySequence() {
    displayTimer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (currentDisplayIndex >= sequence.length) {
        timer.cancel();
        setState(() {
          showingSequence = false;
          currentDisplayIndex = 0;
        });
        return;
      }
      setState(() {
        currentDisplayIndex++;
      });
    });
  }
  void addToUserSequence(int number) {
    if (!gameActive || showingSequence) return;
    setState(() {
      userSequence.add(number);
    });
    if (userSequence.length == sequence.length) {
      checkSequence();
    }
  }
  void checkSequence() {
    bool correct = true;
    for (int i = 0; i < sequence.length; i++) {
      if (sequence[i] != userSequence[i]) {
        correct = false;
        break;
      }
    }
    setState(() {
      gameActive = false;
      if (correct) {
        score += currentLevel * 10;
        currentLevel++;
      } else {
        currentLevel = max(1, currentLevel - 1);
      }
    });
    saveStats();
    showResultDialog(correct);
  }
  void startColorSequenceGame() {
    setState(() {
      gameActive = true;
      showingSequence = true;
      colorSequence.clear();
      userSequence.clear();
      currentDisplayIndex = 0;
    });
    // Generate color sequence
    int sequenceLength = 3 + currentLevel;
    for (int i = 0; i < sequenceLength; i++) {
      colorSequence.add(availableColors[random.nextInt(availableColors.length)]);
    }
    displayColorSequence();
  }
  void displayColorSequence() {
    displayTimer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (currentDisplayIndex >= colorSequence.length) {
        timer.cancel();
        setState(() {
          showingSequence = false;
          currentDisplayIndex = 0;
        });
        return;
      }
      setState(() {
        currentDisplayIndex++;
      });
    });
  }
  void addToColorSequence(Color color) {
    if (!gameActive || showingSequence) return;
    setState(() {
      userSequence.add(availableColors.indexOf(color));
    });
    if (userSequence.length == colorSequence.length) {
      checkColorSequence();
    }
  }
  void checkColorSequence() {
    bool correct = true;
    for (int i = 0; i < colorSequence.length; i++) {
      if (availableColors.indexOf(colorSequence[i]) != userSequence[i]) {
        correct = false;
        break;
      }
    }
    setState(() {
      gameActive = false;
      if (correct) {
        score += currentLevel * 15;
        currentLevel++;
      } else {
        currentLevel = max(1, currentLevel - 1);
      }
    });
    saveStats();
    showResultDialog(correct);
  }
  void showResultDialog(bool correct) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          correct ? 'Excellent! 🧠' : 'Try Again! 🤔',
          style: TextStyle(
            color: correct ? Colors.greenAccent : Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          correct
              ? 'Level up! Now at level $currentLevel'
              : 'Don\'t worry, practice makes perfect!',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
  Widget buildGameSelector() {
    return Row(
      children: ['Number Sequence', 'Color Memory'].map((game) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                currentGame = game;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: currentGame == game ? Colors.greenAccent : Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                game,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: currentGame == game ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
  Widget buildNumberGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 1,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: List.generate(9, (index) {
        int number = index + 1;
        bool isCurrentlyShowing = showingSequence &&
            currentDisplayIndex > 0 &&
            currentDisplayIndex <= sequence.length &&
            sequence[currentDisplayIndex - 1] == number;
        return GestureDetector(
          onTap: () => addToUserSequence(number),
          child: Container(
            decoration: BoxDecoration(
              color: isCurrentlyShowing ? Colors.greenAccent : Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
              border: gameActive && !showingSequence
                  ? Border.all(color: Colors.greenAccent, width: 1)
                  : null,
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: TextStyle(
                  color: isCurrentlyShowing ? Colors.black : Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
  Widget buildColorGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 1,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: availableColors.map((color) {
        bool isCurrentlyShowing = showingSequence &&
            currentDisplayIndex > 0 &&
            currentDisplayIndex <= colorSequence.length &&
            colorSequence[currentDisplayIndex - 1] == color;
        return GestureDetector(
          onTap: () => addToColorSequence(color),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: isCurrentlyShowing
                  ? Border.all(color: Colors.white, width: 4)
                  : gameActive && !showingSequence
                  ? Border.all(color: Colors.white, width: 1)
                  : Border.all(color: Colors.grey[700]!, width: 1),
            ),
          ),
        );
      }).toList(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Memory Exercises'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.star, color: Colors.greenAccent),
                        const SizedBox(height: 8),
                        Text(
                          score.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Score',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.trending_up, color: Colors.greenAccent),
                        const SizedBox(height: 8),
                        Text(
                          currentLevel.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Level',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Game selector
            const Text(
              'Choose Game Type',
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            buildGameSelector(),
            const SizedBox(height: 32),
            // Game status
            if (gameActive) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: showingSequence ? Colors.blue[900] : Colors.green[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  showingSequence
                      ? 'Watch the sequence...'
                      : 'Now repeat the sequence!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            // Game grid
            if (currentGame == 'Number Sequence')
              buildNumberGrid()
            else
              buildColorGrid(),
            const SizedBox(height: 32),
            // Start game button
            GestureDetector(
              onTap: gameActive ? null : (currentGame == 'Number Sequence'
                  ? startNumberSequenceGame
                  : startColorSequenceGame),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: gameActive ? Colors.grey[700] : Colors.greenAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  gameActive ? 'Game in Progress...' : 'Start Memory Game',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: gameActive ? Colors.white70 : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Instructions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How to Play',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    currentGame == 'Number Sequence'
                        ? '1. Watch the numbers light up in sequence\n2. Remember the order\n3. Tap the numbers in the same sequence\n4. Level up with each success!'
                        : '1. Watch the colors flash in sequence\n2. Remember the order\n3. Tap the colors in the same sequence\n4. Level up with each success!',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
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

class ReactionTimePage extends StatefulWidget {
  const ReactionTimePage({super.key});

  @override
  State<ReactionTimePage> createState() => _ReactionTimePageState();
}

class _ReactionTimePageState extends State<ReactionTimePage> {
  bool isWaiting = false;
  bool isReady = false;
  bool tooSoon = false;
  int reactionTime = 0;
  int bestTime = 999999; // High initial value
  double averageTime = 0.0;
  int totalAttempts = 0;
  int sumTimes = 0;
  Timer? _timer;
  DateTime? startTime;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    loadStats();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bestTime = prefs.getInt('reactionBest') ?? 999999;
      totalAttempts = prefs.getInt('reactionAttempts') ?? 0;
      sumTimes = prefs.getInt('reactionSum') ?? 0;
      averageTime = totalAttempts > 0 ? sumTimes / totalAttempts : 0.0;
    });
  }

  Future<void> saveStats() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('reactionBest', bestTime);
    await prefs.setInt('reactionAttempts', totalAttempts);
    await prefs.setInt('reactionSum', sumTimes);
  }

  void startGame() {
    setState(() {
      isWaiting = true;
      isReady = false;
      tooSoon = false;
      reactionTime = 0;
    });
    int delay = random.nextInt(3000) + 1000; // 1-4 seconds
    _timer = Timer(Duration(milliseconds: delay), () {
      setState(() {
        isWaiting = false;
        isReady = true;
      });
      startTime = DateTime.now();
    });
  }

  void handleTap() {
    if (isReady) {
      DateTime endTime = DateTime.now();
      reactionTime = endTime.difference(startTime!).inMilliseconds;
      setState(() {
        isReady = false;
        totalAttempts++;
        sumTimes += reactionTime;
        averageTime = sumTimes / totalAttempts;
        if (reactionTime < bestTime) {
          bestTime = reactionTime;
        }
      });
      saveStats();
    } else if (isWaiting) {
      _timer?.cancel();
      setState(() {
        tooSoon = true;
        isWaiting = false;
      });
    }
  }

  Widget buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.greenAccent, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color screenColor = Colors.grey[900]!;
    String message = 'Tap to start';
    if (isWaiting) {
      screenColor = Colors.red[900]!;
      message = 'Wait for green...';
    } else if (isReady) {
      screenColor = Colors.green[900]!;
      message = 'Tap now!';
    } else if (tooSoon) {
      screenColor = Colors.orange[900]!;
      message = 'Too soon! Tap to try again.';
    } else if (reactionTime > 0) {
      message = 'Your time: $reactionTime ms\nTap to try again.';
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Reaction Time'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: tooSoon || reactionTime > 0 || !isWaiting && !isReady ? startGame : handleTap,
        child: Column(
          children: [
            // Stats
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(child: buildStatCard('Best', '${bestTime == 999999 ? "--" : bestTime} ms', Icons.star)),
                  const SizedBox(width: 12),
                  Expanded(child: buildStatCard('Average', '${averageTime.round()} ms', Icons.timeline)),
                  const SizedBox(width: 12),
                  Expanded(child: buildStatCard('Attempts', totalAttempts.toString(), Icons.repeat)),
                ],
              ),
            ),
            // Main game area
            Expanded(
              child: Container(
                color: screenColor,
                child: Center(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Instructions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How to Play',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '1. Tap to start\n2. Wait for the screen to turn green\n3. Tap as quickly as possible!\n4. Improve your reaction time with practice.',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
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