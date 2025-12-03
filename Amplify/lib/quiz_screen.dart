import 'package:flutter/material.dart';
import 'gemini_api_service.dart';

class QuizScreen extends StatefulWidget {
  final String notes;
  const QuizScreen({super.key, required this.notes});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String quiz = "";
  bool isLoading = true;
  String? error;
  List<QuizQuestion> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  bool showResults = false;
  String? selectedAnswer;
  bool hasAnswered = false;

  @override
  void initState() {
    super.initState();
    _getQuiz();
  }

  void _getQuiz() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final prompt = """Create exactly 10 multiple choice questions based on the following notes. 
Format each question exactly like this:

Q1: [Question text here]
A) [Option A]
B) [Option B] 
C) [Option C]
D) [Option D]
Answer: A

Q2: [Question text here]
A) [Option A]
B) [Option B]
C) [Option C] 
D) [Option D]
Answer: B

Continue this pattern for all 10 questions.

Notes:
${widget.notes}""";

      final result = await GeminiAPI.generate(prompt);
      setState(() {
        quiz = result;
        questions = _parseQuiz(result);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  List<QuizQuestion> _parseQuiz(String quizText) {
    List<QuizQuestion> parsedQuestions = [];

    // Split by question markers
    List<String> questionBlocks = quizText.split(RegExp(r'Q\d+:'));
    questionBlocks.removeAt(0); // Remove empty first element

    for (String block in questionBlocks) {
      try {
        List<String> lines = block.trim().split('\n').where((line) => line.trim().isNotEmpty).toList();

        if (lines.length >= 6) {
          String questionText = lines[0].trim();
          List<String> options = [];
          String correctAnswer = '';

          // Extract options A, B, C, D
          for (int i = 1; i < lines.length; i++) {
            String line = lines[i].trim();
            if (line.startsWith(RegExp(r'^[A-D]\)'))) {
              options.add(line.substring(2).trim());
            } else if (line.toLowerCase().startsWith('answer:')) {
              correctAnswer = line.split(':')[1].trim().toUpperCase();
            }
          }

          if (options.length == 4 && correctAnswer.isNotEmpty) {
            parsedQuestions.add(QuizQuestion(
              question: questionText,
              options: options,
              correctAnswer: correctAnswer,
            ));
          }
        }
      } catch (e) {
        print('Error parsing question: $e');
      }
    }

    return parsedQuestions;
  }

  void _selectAnswer(String answer) {
    if (!hasAnswered) {
      setState(() {
        selectedAnswer = answer;
      });
    }
  }

  void _submitAnswer() {
    if (selectedAnswer != null && !hasAnswered) {
      setState(() {
        hasAnswered = true;
        if (selectedAnswer == questions[currentQuestionIndex].correctAnswer) {
          score++;
        }
      });
    }
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        hasAnswered = false;
      });
    } else {
      setState(() {
        showResults = true;
      });
    }
  }

  void _restartQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      selectedAnswer = null;
      hasAnswered = false;
      showResults = false;
    });
  }

  Color _getScoreColor() {
    double percentage = score / questions.length;
    if (percentage >= 0.8) return Colors.green;
    if (percentage >= 0.6) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
        title: const Text(
          "Quiz",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          if (!isLoading && questions.isNotEmpty && !showResults)
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "${currentQuestionIndex + 1}/${questions.length}",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _getQuiz,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.greenAccent),
            SizedBox(height: 20),
            Text(
              "Generating quiz questions...",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      );
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 64),
            const SizedBox(height: 20),
            Text(
              "Error generating quiz",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              error!,
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getQuiz,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
              ),
              child: const Text("Try Again"),
            ),
          ],
        ),
      );
    }

    if (questions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.quiz, color: Colors.white60, size: 64),
            const SizedBox(height: 20),
            Text(
              "Unable to generate quiz from your notes",
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "Try with more detailed notes or check your connection",
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getQuiz,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
              ),
              child: const Text("Try Again"),
            ),
          ],
        ),
      );
    }

    if (showResults) {
      return _buildResultsScreen();
    }

    return _buildQuestionScreen();
  }

  Widget _buildQuestionScreen() {
    final question = questions[currentQuestionIndex];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Progress indicator
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (currentQuestionIndex + 1) / questions.length,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Question
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
            ),
            child: Text(
              question.question,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Options
          ...question.options.asMap().entries.map((entry) {
            int index = entry.key;
            String option = entry.value;
            String optionLetter = String.fromCharCode(65 + index); // A, B, C, D

            bool isSelected = selectedAnswer == optionLetter;
            bool isCorrect = hasAnswered && optionLetter == question.correctAnswer;
            bool isWrong = hasAnswered && isSelected && optionLetter != question.correctAnswer;

            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _selectAnswer(optionLetter),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isCorrect
                          ? Colors.green.withOpacity(0.2)
                          : isWrong
                          ? Colors.red.withOpacity(0.2)
                          : isSelected
                          ? Colors.greenAccent.withOpacity(0.2)
                          : Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isCorrect
                            ? Colors.green
                            : isWrong
                            ? Colors.red
                            : isSelected
                            ? Colors.greenAccent
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: isCorrect
                                ? Colors.green
                                : isWrong
                                ? Colors.red
                                : isSelected
                                ? Colors.greenAccent
                                : Colors.grey[600],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              optionLetter,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            option,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (hasAnswered && isCorrect)
                          const Icon(Icons.check_circle, color: Colors.green),
                        if (hasAnswered && isWrong)
                          const Icon(Icons.cancel, color: Colors.red),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),

          const SizedBox(height: 30),

          // Action button
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: hasAnswered ? _nextQuestion : (selectedAnswer != null ? _submitAnswer : null),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 5,
              ),
              child: Text(
                hasAnswered
                    ? (currentQuestionIndex == questions.length - 1 ? "View Results" : "Next Question")
                    : "Submit Answer",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsScreen() {
    double percentage = (score / questions.length) * 100;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: _getScoreColor().withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(color: _getScoreColor(), width: 4),
            ),
            child: Center(
              child: Text(
                "${percentage.toInt()}%",
                style: TextStyle(
                  color: _getScoreColor(),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          Text(
            "Quiz Complete!",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "You scored $score out of ${questions.length}",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            _getScoreMessage(percentage),
            style: TextStyle(
              color: _getScoreColor(),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 40),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _restartQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Retake Quiz",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Back to Notes",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getScoreMessage(double percentage) {
    if (percentage >= 90) return "Excellent! You've mastered this material! 🎉";
    if (percentage >= 80) return "Great job! You have a solid understanding! 👏";
    if (percentage >= 70) return "Good work! A bit more practice will help! 👍";
    if (percentage >= 60) return "Not bad! Keep studying to improve! 📚";
    return "Keep practicing! Review your notes and try again! 💪";
  }
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final String correctAnswer;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}