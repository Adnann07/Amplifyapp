import 'package:flutter/material.dart';

class VocabularyFlashcardPage extends StatefulWidget {
  const VocabularyFlashcardPage({super.key});

  @override
  State<VocabularyFlashcardPage> createState() => _VocabularyFlashcardPageState();
}

class _VocabularyFlashcardPageState extends State<VocabularyFlashcardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  bool _isFront = true;
  int _currentIndex = 0;

  // Vocabulary data - cleaned up (no Japanese/symbols)
  final List<Map<String, String>> vocabulary = [
    // Core academic verbs (1-30)
    {'word': 'analyse', 'meaning': 'বিশ্লেষণ করা', 'category': 'Core Verbs'},
    {'word': 'assess', 'meaning': 'মূল্যায়ন করা', 'category': 'Core Verbs'},
    {'word': 'evaluate', 'meaning': 'মূল্যায়ন/পরিমাপ করা', 'category': 'Core Verbs'},
    {'word': 'interpret', 'meaning': 'ব্যাখ্যা করা', 'category': 'Core Verbs'},
    {'word': 'demonstrate', 'meaning': 'প্রমাণ/প্রদর্শন করা', 'category': 'Core Verbs'},
    {'word': 'illustrate', 'meaning': 'উদাহরণসহ ব্যাখ্যা করা', 'category': 'Core Verbs'},
    {'word': 'indicate', 'meaning': 'ইঙ্গিত করা, দেখানো', 'category': 'Core Verbs'},
    {'word': 'imply', 'meaning': 'পরোক্ষভাবে বোঝানো', 'category': 'Core Verbs'},
    {'word': 'infer', 'meaning': 'অনুসিদ্ধান্তে পৌঁছানো', 'category': 'Core Verbs'},
    {'word': 'deduce', 'meaning': 'যুক্তি করে নির্ণয় করা', 'category': 'Core Verbs'},
    {'word': 'estimate', 'meaning': 'আনুমানিক হিসাব করা', 'category': 'Core Verbs'},
    {'word': 'predict', 'meaning': 'ভবিষ্যদ্বাণী করা', 'category': 'Core Verbs'},
    {'word': 'conclude', 'meaning': 'উপসংহারে পৌঁছানো', 'category': 'Core Verbs'},
    {'word': 'contribute', 'meaning': 'অবদান রাখা', 'category': 'Core Verbs'},
    {'word': 'participate', 'meaning': 'অংশগ্রহণ করা', 'category': 'Core Verbs'},
    {'word': 'maintain', 'meaning': 'বজায় রাখা', 'category': 'Core Verbs'},
    {'word': 'achieve', 'meaning': 'অর্জন করা', 'category': 'Core Verbs'},
    {'word': 'acquire', 'meaning': 'অর্জন করা, লাভ করা', 'category': 'Core Verbs'},
    {'word': 'adapt', 'meaning': 'মানিয়ে নেওয়া', 'category': 'Core Verbs'},
    {'word': 'modify', 'meaning': 'পরিবর্তন/পরিমার্জন করা', 'category': 'Core Verbs'},
    {'word': 'generate', 'meaning': 'উৎপন্ন করা', 'category': 'Core Verbs'},
    {'word': 'eliminate', 'meaning': 'দূর করা, বাদ দেওয়া', 'category': 'Core Verbs'},
    {'word': 'facilitate', 'meaning': 'সহজতর করা', 'category': 'Core Verbs'},
    {'word': 'implement', 'meaning': 'কার্যকর/বাস্তবায়ন করা', 'category': 'Core Verbs'},
    {'word': 'establish', 'meaning': 'প্রতিষ্ঠা করা', 'category': 'Core Verbs'},
    {'word': 'justify', 'meaning': 'সঙ্গত প্রমাণ করা', 'category': 'Core Verbs'},
    {'word': 'regulate', 'meaning': 'নিয়ন্ত্রণ করা', 'category': 'Core Verbs'},
    {'word': 'restrict', 'meaning': 'সীমিত/সীমাবদ্ধ করা', 'category': 'Core Verbs'},
    {'word': 'alter', 'meaning': 'পরিবর্তন করা', 'category': 'Core Verbs'},
    {'word': 'emerge', 'meaning': 'প্রকাশ পাওয়া, আবির্ভূত হওয়া', 'category': 'Core Verbs'},

    // Core academic nouns
    {'word': 'factor', 'meaning': 'উপাদান, কারণ', 'category': 'Core Nouns'},
    {'word': 'impact', 'meaning': 'প্রভাব', 'category': 'Core Nouns'},
    {'word': 'resource', 'meaning': 'সম্পদ', 'category': 'Core Nouns'},
    {'word': 'issue', 'meaning': 'বিষয়, সমস্যা', 'category': 'Core Nouns'},
    {'word': 'trend', 'meaning': 'প্রবণতা', 'category': 'Core Nouns'},
    {'word': 'concept', 'meaning': 'ধারণা', 'category': 'Core Nouns'},
    {'word': 'evidence', 'meaning': 'প্রমাণ', 'category': 'Core Nouns'},
    {'word': 'data', 'meaning': 'তথ্য', 'category': 'Core Nouns'},
    {'word': 'research', 'meaning': 'গবেষণা', 'category': 'Core Nouns'},

    // High-frequency adjectives/adverbs
    {'word': 'significant', 'meaning': 'গুরুত্বপূর্ণ, তাৎপর্যপূর্ণ', 'category': 'Adjectives'},
    {'word': 'considerable', 'meaning': 'উল্লেখযোগ্য', 'category': 'Adjectives'},
    {'word': 'substantial', 'meaning': 'যথেষ্ট বড়/প্রচুর', 'category': 'Adjectives'},
    {'word': 'efficient', 'meaning': 'দক্ষ ও সাশ্রয়ী', 'category': 'Adjectives'},
    {'word': 'effective', 'meaning': 'কার্যকর', 'category': 'Adjectives'},

    // SAT-style higher words
    {'word': 'ambiguous', 'meaning': 'দ্ব্যর্থক, অস্পষ্ট', 'category': 'SAT Words'},
    {'word': 'analogous', 'meaning': 'সাদৃশ্যপূর্ণ', 'category': 'SAT Words'},
    {'word': 'benevolent', 'meaning': 'পরোপকারী, দয়ালু', 'category': 'SAT Words'},
    {'word': 'conspicuous', 'meaning': 'স্পষ্টভাবে নজরকাড়া', 'category': 'SAT Words'},

    // Essay boosters
    {'word': 'intricate', 'meaning': 'জটিল ও সূক্ষ্ম', 'category': 'Essay Boosters'},
    {'word': 'mitigate', 'meaning': 'কমিয়ে আনা, লঘু করা', 'category': 'Essay Boosters'},
    {'word': 'resilient', 'meaning': 'সহনশীল; দ্রুত ঘুরে দাঁড়ায় এমন', 'category': 'Essay Boosters'},
  ];

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _flipCard() {
    setState(() {
      if (_flipController.isCompleted) {
        _flipController.reverse();
      } else {
        _flipController.forward();
      }
      _isFront = !_isFront;
    });
  }

  void _nextCard() {
    setState(() {
      if (_currentIndex < vocabulary.length - 1) {
        _currentIndex++;
        _resetCard();
      }
    });
  }

  void _previousCard() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _resetCard();
      }
    });
  }

  void _resetCard() {
    if (!_isFront) {
      _flipController.reverse();
      _isFront = true;
    }
  }

  void _jumpToIndex(int index) {
    setState(() {
      _currentIndex = index;
      _resetCard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IELTS Vocabulary Flashcards'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showCategoryFilter,
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress indicator
          LinearProgressIndicator(
            value: (_currentIndex + 1) / vocabulary.length,
            backgroundColor: Colors.grey[300],
            color: Colors.deepPurple,
            minHeight: 4,
          ),
          const SizedBox(height: 8),

          // Card counter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_currentIndex + 1} / ${vocabulary.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurple,
                  ),
                ),
                Text(
                  vocabulary[_currentIndex]['word']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Flashcard area - Fixed single card layout
          Expanded(
            child: GestureDetector(
              onTap: _flipCard,
              child: AnimatedBuilder(
                animation: _flipAnimation,
                builder: (context, child) {
                  final angle = _flipAnimation.value * 3.14159;
                  final transform = Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(angle);

                  return Transform(
                    transform: transform,
                    alignment: Alignment.center,
                    child: _isFront
                        ? _buildFrontCard()
                        : Transform(
                      transform: Matrix4.identity()..rotateY(3.14159),
                      alignment: Alignment.center,
                      child: _buildBackCard(),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Category indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _getCategoryColor(vocabulary[_currentIndex]['category']!),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                vocabulary[_currentIndex]['category']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Navigation controls - Fixed layout
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  mini: true,
                  heroTag: 'prev',
                  onPressed: _currentIndex > 0 ? _previousCard : null,
                  backgroundColor: Colors.deepPurple.shade100,
                  foregroundColor: Colors.deepPurple,
                  child: const Icon(Icons.arrow_back),
                ),
                ElevatedButton.icon(
                  onPressed: _flipCard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  icon: const Icon(Icons.flip, size: 20),
                  label: Text(_isFront ? 'Show Meaning' : 'Show Word'),
                ),
                FloatingActionButton(
                  mini: true,
                  heroTag: 'next',
                  onPressed: _currentIndex < vocabulary.length - 1 ? _nextCard : null,
                  backgroundColor: Colors.deepPurple.shade100,
                  foregroundColor: Colors.deepPurple,
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Quick navigation dots - Fixed height and scrollable
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: vocabulary.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _jumpToIndex(index),
                  child: Container(
                    width: 36,
                    height: 36,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: index == _currentIndex
                          ? Colors.deepPurple
                          : Colors.grey[300],
                      shape: BoxShape.circle,
                      boxShadow: [
                        if (index == _currentIndex)
                          BoxShadow(
                            color: Colors.deepPurple.withOpacity(0.3),
                            blurRadius: 4,
                          ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          color: index == _currentIndex
                              ? Colors.white
                              : Colors.grey[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFrontCard() {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.2),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.language,
                size: 64,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 24),
              Text(
                vocabulary[_currentIndex]['word']!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Tap card or press Flip',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackCard() {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.deepPurple,
            Colors.deepPurple.shade700,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              vocabulary[_currentIndex]['word']!,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Text(
                vocabulary[_currentIndex]['meaning']!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.deepPurple,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Tap to flip back',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Core Verbs':
        return Colors.blue.shade600;
      case 'Core Nouns':
        return Colors.green.shade600;
      case 'Adjectives':
        return Colors.orange.shade600;
      case 'SAT Words':
        return Colors.purple.shade600;
      case 'Essay Boosters':
        return Colors.red.shade600;
      default:
        return Colors.deepPurple;
    }
  }

  void _showCategoryFilter() {
    final categories = vocabulary.map((v) => v['category']!).toSet().toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.3,
          maxChildSize: 0.6,
          builder: (context, scrollController) {
            return Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Filter by Category',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                            leading: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: _getCategoryColor(category),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: _getCategoryColor(category).withOpacity(0.3),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                            title: Text(
                              category,
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              final index = vocabulary.indexWhere((v) => v['category'] == category);
                              if (index != -1) {
                                _jumpToIndex(index);
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Close', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
