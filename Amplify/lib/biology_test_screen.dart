import 'dart:async';
import 'package:flutter/material.dart';

class BiologyTestScreen extends StatefulWidget {
  final String paper;
  final int setNumber;
  final List<Map<String, dynamic>> questions;

  const BiologyTestScreen({
    super.key,
    required this.paper,
    required this.setNumber,
    required this.questions,
  });

  @override
  State<BiologyTestScreen> createState() => _BiologyTestScreenState();
}

class _BiologyTestScreenState extends State<BiologyTestScreen> {
  late List<Map<String, dynamic>> currentQuestions;
  late List<int?> selected;
  int currentIndex = 0;
  int score = 0;
  bool finished = false;
  Timer? _timer;
  int remaining = 25 * 60;

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
          '${widget.paper == 'biology1' ? 'জীববিজ্ঞান ১ম পত্র' : 'জীববিজ্ঞান ২য় পত্র'} - সেট ${widget.setNumber}',
        ),
        backgroundColor: Colors.teal.shade700,
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
                  ...List.generate(4, (i) {
                    final bool isSelected = selected[currentIndex] == i;
                    return GestureDetector(
                      onTap: () => _selectOption(i),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.teal.shade100
                              : Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? Colors.teal
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? Colors.teal
                                    : Colors.transparent,
                                border: Border.all(
                                  color:
                                  isSelected ? Colors.teal : Colors.grey,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  _bnOption(i),
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                q['options'][i],
                                style: const TextStyle(fontSize: 16),
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, -2),
                )
              ],
            ),
            child: Row(
              children: [
                if (currentIndex > 0)
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _prev,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('পূর্ববর্তী'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                if (currentIndex > 0) const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: selected[currentIndex] != null ? _next : null,
                    icon: Icon(currentIndex == currentQuestions.length - 1
                        ? Icons.check_circle
                        : Icons.arrow_forward),
                    label: Text(currentIndex == currentQuestions.length - 1
                        ? 'শেষ করুন'
                        : 'পরবর্তী'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    final percent = (score / currentQuestions.length * 100).toStringAsFixed(1);
    return Scaffold(
      appBar: AppBar(
        title: const Text('পরীক্ষা সমাপ্ত'),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 100, color: Colors.teal.shade700),
              const SizedBox(height: 24),
              Text(
                'আপনার স্কোর',
                style: TextStyle(fontSize: 22, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 12),
              Text(
                '$score/${currentQuestions.length}',
                style: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
              Text(
                '($percent%)',
                style: const TextStyle(fontSize: 24, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.home),
                label: const Text('হোম পেজে ফিরুন'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
