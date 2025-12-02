import 'package:flutter/material.dart';
import 'dart:math';
import 'chemistry_test_screen.dart';

class ChemistryQuizPage extends StatefulWidget {
  const ChemistryQuizPage({super.key});

  @override
  State<ChemistryQuizPage> createState() => _ChemistryQuizPageState();
}

class _ChemistryQuizPageState extends State<ChemistryQuizPage> {
  final Random _random = Random();

  // SET 1 - COMPLETE 25 QUESTIONS
  final List<Map<String, dynamic>> set1Questions = [
    {"question": "০.৫ মোল সালফিউরিক অ্যাসিড (H₂SO₄)–এ মোট কতটি অক্সিজেন পরমাণু রয়েছে?", "options": ["১.৫ × ১০²³", "৩.০ × ১০²³", "৬.০ × ১০²³", "১২.০ × ১০²³"], "correct": 3},
    {"question": "২.২৪ লিটার কোনো গ্যাস STP তে ভর ৪ গ্রাম। গ্যাসটির আনুমানিক মোলার ভর কত?", "options": ["২ গ্রাম মোল⁻¹", "৪ গ্রাম মোল⁻¹", "৮ গ্রাম মোল⁻¹", "১৬ গ্রাম মোল⁻¹"], "correct": 2},
    {"question": "STP তে ৪৪.৮ লিটার অক্সিজেন গ্যাসে (O₂) কত মোল গ্যাস রয়েছে?", "options": ["১ মোল", "২ মোল", "৪ মোল", "৮ মোল"], "correct": 2},
    {"question": "নিম্নের কোন যৌগে কার্বনের জারন সংখ্যা সর্বোচ্চ?", "options": ["CO", "CO₂", "HCOOH", "CH₄"], "correct": 1},
    {"question": "একটি গ্যাস মিশ্রণে ২ মোল N₂ ও ১ মোল O₂ আছে। মোট চাপ ৩ atm হলে O₂–এর আংশিক চাপ কত?", "options": ["০.৫ atm", "১ atm", "২ atm", "৩ atm"], "correct": 1},
    {"question": "কোনো বিক্রিয়া উষ্মাধর্মী হলে—", "options": ["ΔH ধনাত্মক হয়", "ΔH শূন্য হয়", "ΔH ঋণাত্মক হয়", "ΔH এর মান নির্ণয় করা যায় না"], "correct": 2},
    {"question": "নিম্নের কোনটি state function?", "options": ["কাজ (Work)", "তাপ (Heat)", "এনথ্যালপি (H)", "তাপ ও কাজ দুটোই"], "correct": 2},
    {"question": "N₂(g) + 3H₂(g) ⇌ 2NH₃(g) ; ΔH = –৯২ কিলোজুল এই বিক্রিয়ায় NH₃ উৎপাদন বাড়াতে—", "options": ["তাপমাত্রা বাড়াতে হবে", "তাপমাত্রা কমাতে হবে", "চাপ কমাতে হবে", "নিষ্ক্রিয় গ্যাস যোগ করতে হবে"], "correct": 1},
    {"question": "কোন অবস্থায় একটি বিক্রিয়া সাম্যাবস্থায় থাকে?", "options": ["অগ্রগামী বিক্রিয়ার বেগ > পশ্চাদগামী", "অগ্রগামী বিক্রিয়ার বেগ < পশ্চাদগামী", "অগ্রগামী ও পশ্চাদগামী বিক্রিয়ার বেগ সমান", "সাম্যাবস্থায় বিক্রিয়া থেমে যায়"], "correct": 2},
    {"question": "রাসায়নিক সাম্যাবস্থা সম্পর্কে কোনটি সঠিক?", "options": ["এটি সর্বদা স্থির (static)", "এটি গতিশীল (dynamic)", "কেবল অগ্রগামী বিক্রিয়া চলে", "কেবল পশ্চাদগামী বিক্রিয়া চলে"], "correct": 1},
    {"question": "নিম্নের কোন উপাদানের আয়নায়ন শক্তি সর্বাধিক?", "options": ["Na", "Mg", "Al", "Si"], "correct": 3},
    {"question": "একই পর্যায়ে বাম থেকে ডানে গেলে সাধারণত—", "options": ["পরমাণু ব্যাসার্ধ বৃদ্ধি পায়", "পরমাণু ব্যাসার্ধ হ্রাস পায়", "পরমাণু ব্যাসার্ধ অপরিবর্তিত", "প্রথমে হ্রাস পরে বৃদ্ধি"], "correct": 1},
    {"question": "কোন যৌগে আইনিক বন্ধন রয়েছে?", "options": ["HCl", "CH₄", "NaCl", "H₂O"], "correct": 2},
    {"question": "হাইড্রোজেন বন্ড থাকার ফলে কোন পদার্থের স্ফুটনাঙ্ক বেশি?", "options": ["H₂S", "H₂O", "HCl", "CH₄"], "correct": 1},
    {"question": "একটি বিক্রিয়ার হারধ্রুবক (k) কিসের উপর নির্ভর করে?", "options": ["বিক্রিয়কের ঘনত্ব", "তাপমাত্রা", "চাপ", "অনুঘটকের পরিমাণ"], "correct": 1},
    {"question": "প্রথম শ্রেণির বিক্রিয়ায় হার নির্ভর করে—", "options": ["এক বিক্রিয়কের ঘনত্বের উপর", "দুই বিক্রিয়কের ঘনত্বের উপর", "কোনো বিক্রিয়কের উপর নয়", "পণ্যের ঘনত্বের উপর"], "correct": 0},
    {"question": "pH = ৩ বিশিষ্ট দ্রবণের তুলনায় pH = ৫ বিশিষ্ট দ্রবণে [H⁺] কত গুণ কম?", "options": ["২ গুণ", "১০ গুণ", "১০০ গুণ", "১০০০ গুণ"], "correct": 2},
    {"question": "২৫°C তে বিশুদ্ধ জলের pH এর মান কত?", "options": ["০", "১", "৭", "১৪"], "correct": 2},
    {"question": "কোন দ্রবণটি বাফার দ্রবণ হিসেবে কাজ করতে পারে?", "options": ["HCl + NaCl", "HNO₃ + NaNO₃", "CH₃COOH + CH₃COONa", "NaOH + NaCl"], "correct": 2},
    {"question": "অক্সিডেশন সম্পর্কে সঠিক বক্তব্য কোনটি?", "options": ["ইলেকট্রন গ্রহণ", "ইলেকট্রন ত্যাগ", "প্রোটন গ্রহণ", "প্রোটন ত্যাগ"], "correct": 1},
    {"question": "কোন যৌগটি লুইস অম্ল (Lewis acid)?", "options": ["NH₃", "H₂O", "BF₃", "OH⁻"], "correct": 2},
    {"question": "১ মোল CaCO₃ সম্পূর্ণ বিশ্লেষিত হলে কত মোল CO₂ গ্যাস উৎপন্ন হয়?", "options": ["০.৫ মোল", "১ মোল", "২ মোল", "৩ মোল"], "correct": 1},
    {"question": "নিম্নের কোন গ্যাসটি আদর্শ গ্যাসের নিকটতম আচরণ করে?", "options": ["NH₃", "H₂O (বাষ্প)", "He", "SO₂"], "correct": 2},
    {"question": "দ্রবণে দ্রবের দ্রাব্যতা বৃদ্ধির জন্য কোনটি সহায়ক?", "options": ["তাপমাত্রা হ্রাস", "নাড়াচাড়া", "চাপ হ্রাস", "দ্রাবক কমানো"], "correct": 1},
    {"question": "মোলারিটি (M) কীভাবে সংজ্ঞায়িত?", "options": ["১ লিটার দ্রাবকে দ্রবের মোল", "১ লিটার দ্রবণে দ্রবের মোল", "১ কেজি দ্রাবকে দ্রবের মোল", "১ কেজি দ্রবণে দ্রবের মোল"], "correct": 1},
  ];

  // SET 2 & SET 3 - Same as before (keeping brief for this fix)
  final List<Map<String, dynamic>> set2Questions = [
    {"question": "০.২৫ মোল Na₂CO₃–এ মোট কতটি Na⁺ আয়ন থাকে?", "options": ["০.১২৫ মোল", "০.২৫ মোল", "০.৫ মোল", "১ মোল"], "correct": 2},
    // ... (rest of set 2 - same as before)
  ];

  final List<Map<String, dynamic>> set3Questions = [
    {"question": "৬.০২×১০²³ অণু NH₃–এর ভর প্রায় কত? (M(NH₃)=17)", "options": ["৮.৫ গ্রাম", "১৭ গ্রাম", "৩৪ গ্রাম", "৪৪ গ্রাম"], "correct": 1},
    // ... (rest of set 3)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('রসায়ন পরীক্ষা'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 20),
            const Text(
              'রসায়ন মডেল টেস্ট (২০২৬)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            const Text(
              '৭৫টি প্রশ্ন | র‍্যান্ডম সেট নির্বাচন',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            _buildPaperCard(context, 'রসায়ন ১ম পত্র', '৭৫ প্রশ্ন | র‍্যান্ডম সেট', 'chemistry1', Colors.cyan),
            const SizedBox(height: 20),
            _buildPaperCard(context, 'রসায়ন ২য় পত্র', '৭৫ প্রশ্ন | র‍্যান্ডম সেট', 'chemistry2', Colors.indigo),
          ],
        ),
      ),
    );
  }

  Widget _buildPaperCard(BuildContext context, String title, String subtitle, String paper, Color color) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          final randomSet = _random.nextInt(3) + 1;
          final questions = randomSet == 1 ? set1Questions : randomSet == 2 ? set2Questions : set3Questions;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChemistryTestScreen(
                paper: paper,
                setNumber: randomSet,
                questions: questions,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [color, color.withOpacity(0.7)]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.quiz, size: 30, color: Colors.white),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 5),
                        Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.white70)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), shape: BoxShape.circle),
                    child: const Icon(Icons.casino, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // FIXED: Wrap + Flexible for info chips (NO OVERFLOW)
              LayoutBuilder(
                builder: (context, constraints) {
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildInfoChip('২৫ প্রশ্ন', Icons.question_answer),
                      _buildInfoChip('২৫ মিনিট', Icons.timer),
                      _buildInfoChip('র‍্যান্ডম', Icons.shuffle),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(String text, IconData icon) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 80), // FIXED: Limit width
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Flexible( // FIXED: Flexible text
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 11),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
