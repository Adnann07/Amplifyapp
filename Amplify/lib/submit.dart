import 'package:flutter/material.dart';
import 'flashcard_screen.dart';
import 'quiz_screen.dart';
import 'chatbot_screen.dart';

class Submit extends StatefulWidget {
  const Submit({super.key});

  @override
  State<Submit> createState() => _SubmitState();
}

class _SubmitState extends State<Submit> {
  final _controller = TextEditingController();

  String notes = "";

  void _navigateTo(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
        title: const Text(
          'AI assistance',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              "Paste Your Study Notes",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Enter your notes below to generate flashcards, quizzes, or chat with AI",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Powered by Google Gemini",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
              ),
              child: TextField(
                controller: _controller,
                maxLines: 6,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  hintText: "Paste your notes here...\n\nExample:\n- Key concepts\n- Important definitions\n- Study material",
                  hintStyle: TextStyle(color: Colors.white60),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(20),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 5,
                ),
                onPressed: () {
                  if (_controller.text.trim().isNotEmpty) {
                    setState(() {
                      notes = _controller.text;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter some notes first"),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  }
                },
                child: const Text(
                  "Analyze Notes",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            if (notes.isNotEmpty) ...[
              Text(
                "Choose Your Study Method:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              _buildStudyButton(
                icon: Icons.style,
                title: "Generate Flashcards",
                subtitle: "Create interactive flashcards for review",
                onPressed: () => _navigateTo(FlashcardScreen(notes: notes)),
              ),

              const SizedBox(height: 15),

              _buildStudyButton(
                icon: Icons.quiz,
                title: "Take Quiz",
                subtitle: "Test your knowledge with 10 questions",
                onPressed: () => _navigateTo(QuizScreen(notes: notes)),
              ),

              const SizedBox(height: 15),

              _buildStudyButton(
                icon: Icons.chat,
                title: "Ask AI Chatbot",
                subtitle: "Get personalized help and explanations",
                onPressed: () => _navigateTo(ChatbotScreen(notes: notes)),
              ),

              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "AI features powered by Google Gemini",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStudyButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 75,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.greenAccent.withOpacity(0.3)),
          ),
          elevation: 3,
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(22.5),
                ),
                child: Icon(
                  icon,
                  color: Colors.greenAccent,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.greenAccent,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}