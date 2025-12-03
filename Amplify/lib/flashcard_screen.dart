import 'package:flutter/material.dart';
import 'gemini_api_service.dart';

class FlashcardScreen extends StatefulWidget {
  final String notes;
  const FlashcardScreen({super.key, required this.notes});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  String flashcards = "Generating...";
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _getFlashcards();
  }

  void _getFlashcards() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
        flashcards = "Generating flashcards...";
      });

      print("Notes received: ${widget.notes}");
      final prompt = "Create 20 flashcards in question and answer format from the following notes. Format each flashcard as:\n\nQ: [Question]\nA: [Answer]\n\nNotes:\n${widget.notes}";

      print("Sending prompt to API...");
      final result = await GeminiAPI.generate(prompt);
      print("API response received: ${result.substring(0, result.length > 200 ? 200 : result.length)}...");

      setState(() {
        flashcards = result;
        isLoading = false;
      });
    } catch (e) {
      print("Error generating flashcards: $e");
      setState(() {
        error = e.toString();
        flashcards = "Failed to generate flashcards. Please check your internet connection and try again.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flashcards"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _getFlashcards,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.notes.isNotEmpty) ...[
              const Text(
                "Your Notes:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.notes,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
            ],

            const Text(
              "Generated Flashcards:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.greenAccent[100]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isLoading)
                      const Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text("Generating flashcards...")
                        ],
                      )
                    else if (error != null)
                      Column(
                        children: [
                          const Icon(Icons.error, color: Colors.red, size: 48),
                          const SizedBox(height: 16),
                          Text(
                            "Error: $error",
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _getFlashcards,
                            child: const Text("Try Again"),
                          ),
                        ],
                      )
                    else
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            flashcards,
                            style: const TextStyle(fontSize: 14, height: 1.5),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Alternative simplified version if you prefer minimal changes
class SimpleFlashcardScreen extends StatefulWidget {
  final String notes;
  const SimpleFlashcardScreen({super.key, required this.notes});

  @override
  State<SimpleFlashcardScreen> createState() => _SimpleFlashcardScreenState();
}

class _SimpleFlashcardScreenState extends State<SimpleFlashcardScreen> {
  String flashcards = "Generating...";

  @override
  void initState() {
    super.initState();
    _getFlashcards();
  }

  void _getFlashcards() async {
    try {
      final prompt = "Create 5 flashcards (Q & A) from the following notes:\n${widget.notes}";
      final result = await GeminiAPI.generate(prompt);
      setState(() => flashcards = result);
    } catch (e) {
      setState(() => flashcards = "Error: $e\n\nPlease check your API key and internet connection.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flashcards")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(flashcards),
        ),
      ),
    );
  }
}