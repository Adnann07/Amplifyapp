import 'dart:async';
import 'package:flutter/material.dart';

class PhysicsTestScreen extends StatefulWidget {
  final String paper; // 'physics1' / 'physics2'
  final int setNumber; // 1, 2, 3
  final List<Map<String, dynamic>> questions;

  const PhysicsTestScreen({
    super.key,
    required this.paper,
    required this.setNumber,
    required this.questions,
  });

  @override
  State<PhysicsTestScreen> createState() => _PhysicsTestScreenState();
}

class _PhysicsTestScreenState extends State<PhysicsTestScreen> {
  late List<Map<String, dynamic>> currentQuestions;
  late List<int?> selected;
  int currentIndex = 0;
  int score = 0;
  bool finished = false;
  Timer? _timer;
  int remaining = 25 * 60; // 25 মিনিট

  @override
  void initState() {
    super.initState();
    currentQuestions = widget.questions;
    selected = List<int?>.filled(currentQuestions.length, null);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remaining > 0) {
        setState(() => remaining--);
      } else {
        _showResult();
      }
    });
  }

  String _formatTime(int s) {
    final m = s ~/ 60;
    final r = s % 60;
    return '${m.toString().padLeft(2, '0')}:${r.toString().padLeft(2, '0')}';
  }

  void _selectOption(int index) {
    setState(() {
      selected[currentIndex] = index;
    });
  }

  void _next() {
    if (currentIndex < currentQuestions.length - 1) {
      setState(() => currentIndex++);
    } else {
      _showResult();
    }
  }

  void _prev() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
    }
  }

  void _showResult() {
    _timer?.cancel();
    score = 0;
    for (int i = 0; i < currentQuestions.length; i++) {
      if (selected[i] == currentQuestions[i]['correct']) {
        score++;
      }
    }
    setState(() => finished = true);
  }

  String _bnOption(int i) => ['ক', 'খ', 'গ', 'ঘ'][i];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (finished) return _buildResult();

    final q = currentQuestions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.paper == 'physics1' ? 'পদার্থবিজ্ঞান ১ম পত্র' : 'পদার্থবিজ্ঞান ২য় পত্র'} - সেট ${widget.setNumber}',
        ),
        backgroundColor: Colors.green.shade700,
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _formatTime(remaining),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // progress
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: (currentIndex + 1) / currentQuestions.length,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${currentIndex + 1}/${currentQuestions.length}'),
                    Text('স্কোর: $score'),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // question
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Text(
                      q['question'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // options
                  ...List.generate(4, (i) {
                    final bool isSelected = selected[currentIndex] == i;
                    return GestureDetector(
                      onTap: () => _selectOption(i),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                          isSelected ? Colors.green.shade400 : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white.withOpacity(0.3)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _bnOption(i),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.green.shade800,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                q['options'][i],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey.shade800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          // nav buttons
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _prev,
                    icon: const Icon(Icons.arrow_back_ios),
                    label: const Text('আগের'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _next,
                    icon: const Icon(Icons.arrow_forward_ios),
                    label: Text(currentIndex < currentQuestions.length - 1
                        ? 'পরবর্তী'
                        : 'ফলাফল'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildResult() {
    final pct = (score / currentQuestions.length * 100).round();
    String grade;
    if (pct >= 80) grade = 'A+';
    else if (pct >= 70) grade = 'A';
    else if (pct >= 60) grade = 'A-';
    else if (pct >= 50) grade = 'B';
    else if (pct >= 40) grade = 'C';
    else grade = 'F';

    return Scaffold(
      appBar: AppBar(
        title: const Text('ফলাফল'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$score / ${currentQuestions.length}',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('$pct%  |  গ্রেড: $grade'),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.home),
                label: const Text('হোমে ফিরে যান'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
