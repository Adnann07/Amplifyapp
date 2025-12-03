import 'dart:async';
import 'package:flutter/material.dart';

class IctTestScreen extends StatefulWidget {
  final int setNumber;
  final List<Map<String, dynamic>> questions;

  const IctTestScreen({
    super.key,
    required this.setNumber,
    required this.questions,
  });

  @override
  State<IctTestScreen> createState() => _IctTestScreenState();
}

class _IctTestScreenState extends State<IctTestScreen> {
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
        title: Text('ICT - সেট ${widget.setNumber}', style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.redAccent, // High visibility for timer
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.white),
                const SizedBox(width: 5),
                Text(
                  _formatTime(remaining),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: (currentIndex + 1) / currentQuestions.length,
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.teal, // Matches theme
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'প্রশ্ন: ${currentIndex + 1}/${currentQuestions.length}',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                    // Score hidden during test to reduce anxiety, can enable if needed
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
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Text(
                      q['question'],
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                        color: Colors.grey.shade900, // High contrast text
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...List.generate(4, (i) {
                    final bool isSelected = selected[currentIndex] == i;
                    return GestureDetector(
                      onTap: () => _selectOption(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.teal.shade50 // Very light background
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? Colors.teal // Strong border for selection
                                : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? Colors.teal
                                    : Colors.grey.shade100,
                                border: Border.all(
                                  color: isSelected ? Colors.teal : Colors.grey.shade400,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  _bnOption(i),
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                q['options'][i],
                                style: TextStyle(
                                  fontSize: 17,
                                  color: isSelected
                                      ? Colors.teal.shade900 // Dark teal text for readability
                                      : Colors.grey.shade800,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                )
              ],
            ),
            child: Row(
              children: [
                if (currentIndex > 0)
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _prev,
                      icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                      label: const Text('পূর্ববর্তী'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey.shade300)
                        ),
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
                        : Icons.arrow_forward_ios, size: 18),
                    label: Text(currentIndex == currentQuestions.length - 1
                        ? 'শেষ করুন'
                        : 'পরবর্তী'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
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
        title: const Text('ফলাফল', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.teal.shade50,
                ),
                child: const Icon(Icons.emoji_events, size: 80, color: Colors.teal),
              ),
              const SizedBox(height: 24),
              Text(
                'আপনার স্কোর',
                style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 12),
              Text(
                '$score / ${currentQuestions.length}',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              Text(
                '($percent%)',
                style: TextStyle(fontSize: 22, color: Colors.teal.shade700, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('নতুন কুইজ শুরু করুন'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
