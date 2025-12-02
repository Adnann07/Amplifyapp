import 'dart:math';
import 'package:flutter/material.dart';
import 'physics_test_screen.dart';

class PhysicsQuizPage extends StatelessWidget {
  PhysicsQuizPage({super.key});

  final Random _random = Random();

  // ---------------- PHYSICS 1ST PAPER ----------------

  final List<Map<String, dynamic>> physics1Set1 = [
    {
      "question": "পদার্থবিজ্ঞানের মূল লক্ষ্য কী?",
      "options": [
        "প্রকৃতির মৌলিক নিয়ম আবিষ্কার",
        "যন্ত্র নির্মাণ",
        "রাসায়নিক বিক্রিয়া ব্যাখ্যা",
        "জীবের গঠন বিশ্লেষণ"
      ],
      "correct": 0
    },
    {
      "question": "কোনটি মৌলিক একক (fundamental unit)?",
      "options": ["নিউটন", "জুল", "মিটার", "ওয়াট"],
      "correct": 2
    },
    {
      "question": "১ পারসেক = কত মিটার?",
      "options": [
        "৩.০৮×১০¹⁶ মিটার",
        "৩.০৮×১০¹⁵ মিটার",
        "৯.৪৬×১০¹⁵ মিটার",
        "১.৫×১০¹¹ মিটার"
      ],
      "correct": 0
    },
    {
      "question": "স্থিতিস্থাপক সীমার মধ্যে পীড়ন ও বিকৃতির অনুপাত—",
      "options": ["পরিবর্তনশীল", "স্থির", "শূন্য", "অসীম"],
      "correct": 1
    },
    {
      "question": "ইয়ং মডুলাস (Y) এর একক—",
      "options": ["N/m", "N/m²", "N·m", "J/m³"],
      "correct": 1
    },
    {
      "question": "পৃষ্ঠটান–এর একক SI তে—",
      "options": ["N", "N/m", "N·m", "J"],
      "correct": 1
    },
    {
      "question": "তরলের সান্দ্রতা বৃদ্ধি পেলে—",
      "options": [
        "প্রবাহিত হওয়া সহজ হয়",
        "প্রবাহিত হওয়া কঠিন হয়",
        "ঘনত্ব কমে",
        "ফুটনাঙ্ক বাড়ে"
      ],
      "correct": 1
    },
    {
      "question": "বার্নোলির নীতি কোন ধারণার উপর প্রতিষ্ঠিত?",
      "options": [
        "ভর সংরক্ষণ",
        "শক্তি সংরক্ষণ",
        "ভরবেগ সংরক্ষণ",
        "কৌণিক ভরবেগ সংরক্ষণ"
      ],
      "correct": 1
    },
    {
      "question": "পর্যায়কাল (T) ও কম্পাঙ্ক (f)–এর সম্পর্ক—",
      "options": ["T = f", "T = 1/f", "T = f²", "T = 2πf"],
      "correct": 1
    },
    {
      "question": "সরল দোলন গতিতে ত্বরণ—",
      "options": [
        "সর্বদা ধ্রুবক",
        "সাম্যাবস্থান থেকে দূরত্বের সমানুপাতিক",
        "সাম্যাবস্থান থেকে দূরত্বের ব্যস্তানুপাতিক",
        "শূন্য"
      ],
      "correct": 2
    },
    {
      "question": "একটি সরল দোলকের দৈর্ঘ্য চার গুণ করলে পর্যায়কাল—",
      "options": ["চার গুণ হয়", "দুই গুণ হয়", "অর্ধেক হয়", "অপরিবর্তিত থাকে"],
      "correct": 1
    },
    {
      "question": "শব্দতরঙ্গ—",
      "options": ["অনুদৈর্ঘ্য", "অনুপ্রস্থ", "তড়িৎচুম্বকীয়", "ম্যাটার ওয়েভ"],
      "correct": 0
    },
    {
      "question": "শব্দের বেগ নির্ভর করে—",
      "options": [
        "মাধ্যমের তাপমাত্রা ও প্রকৃতি",
        "শব্দের তীব্রতা",
        "শব্দের কম্পাঙ্ক",
        "উৎসের দূরত্ব"
      ],
      "correct": 0
    },
    {
      "question": "কোন তাপমাত্রায় সেলসিয়াস ও ফারেনহাইট স্কেল সমান পাঠ দেয়?",
      "options": ["0°", "–40°", "100°", "32°"],
      "correct": 1
    },
    {
      "question": "তাপ ও তাপমাত্রার পার্থক্য—",
      "options": [
        "তাপমাত্রা শক্তি, তাপ পরিমাপ",
        "তাপ শক্তি, তাপমাত্রা পরিমাপ",
        "তাপমাত্রা তীব্রতা, তাপ শক্তি",
        "কোন পার্থক্য নেই"
      ],
      "correct": 2
    },
    {
      "question": "তাপগতিবিদ্যার প্রথম সূত্রে কী সংরক্ষিত থাকে?",
      "options": ["ভর", "শক্তি", "ভরবেগ", "তাপমাত্রা"],
      "correct": 1
    },
    {
      "question": "আদর্শ কার্নো ইঞ্জিনের দক্ষতা নির্ভর করে—",
      "options": [
        "শুধু উৎসের তাপমাত্রায়",
        "শুধু নিমজ্জকের তাপমাত্রায়",
        "উৎস ও নিমজ্জক উভয়ের তাপমাত্রায়",
        "কার্যকারী পদার্থের প্রকৃতিতে"
      ],
      "correct": 2
    },
    {
      "question": "তরঙ্গের বেগ (v), কম্পাঙ্ক (f) ও তরঙ্গদৈর্ঘ্য (λ)—",
      "options": ["v = f/λ", "v = fλ", "v = f + λ", "v = λ/f"],
      "correct": 1
    },
    {
      "question": "প্রতিসরণাঙ্ক (n) এর সংজ্ঞা—",
      "options": ["n = sin i / sin r", "n = sin r / sin i", "n = c / v", "উভয় ক ও গ"],
      "correct": 3
    },
    {
      "question": "লেন্সের ক্ষমতা (P) ও ফোকাস দৈর্ঘ্য (f)—",
      "options": ["P = f", "P = 1/f (f মিটারে)", "P = 2f", "P = f²"],
      "correct": 1
    },
    {
      "question": "উত্তল লেন্সের ফোকাস দৈর্ঘ্য—",
      "options": ["ধনাত্মক", "ঋণাত্মক", "শূন্য", "অসীম"],
      "correct": 0
    },
    {
      "question": "ব্যতিচার ঘটার জন্য তরঙ্গ উৎসগুলো হতে হবে—",
      "options": ["সুসম্বদ্ধ (coherent)", "অসম্বদ্ধ", "ভিন্ন কম্পাঙ্কের", "ভিন্ন মাধ্যমে"],
      "correct": 0
    },
    {
      "question": "সিঙ্গেল স্লিট বিবর্তনে কেন্দ্রীয় উজ্জ্বল ফ্রিঞ্জ—",
      "options": ["সরু", "প্রশস্ত", "থাকে না", "দুর্বল"],
      "correct": 1
    },
    {
      "question": "পোলারাইজেশন প্রমাণ করে যে আলো—",
      "options": ["কণা", "অনুপ্রস্থ তরঙ্গ", "অনুদৈর্ঘ্য তরঙ্গ", "স্থির তরঙ্গ"],
      "correct": 1
    },
    {
      "question": "একটি সমতল দর্পণের সামনে বস্তু ২ মিটার দূরে রাখলে প্রতিবিম্ব কোথায় গঠিত হবে?",
      "options": [
        "দর্পণের সামনে ২ মিটার",
        "দর্পণের পেছনে ২ মিটার",
        "দর্পণের উপর",
        "অসীমে"
      ],
      "correct": 1
    },
  ];

  final List<Map<String, dynamic>> physics1Set2 = [
    {
      "question": "মাত্রা বিশ্লেষণে [MLT⁻²] কিসের মাত্রা?",
      "options": ["বল", "কাজ", "ক্ষমতা", "ভরবেগ"],
      "correct": 0
    },
    {
      "question": "ভেক্টর রাশি—",
      "options": ["দূরত্ব", "সময়", "বেগ", "তাপমাত্রা"],
      "correct": 2
    },
    {
      "question": "স্কেলার গুণফল A·B = ?",
      "options": ["AB cos θ", "AB sin θ", "AB tan θ", "A/B"],
      "correct": 0
    },
    {
      "question": "নিউটনের প্রথম সূত্র অন্য নাম—",
      "options": ["জড়তার সূত্র", "ত্বরণের সূত্র", "ক্রিয়া–প্রতিক্রিয়া সূত্র", "মহাকর্ষ সূত্র"],
      "correct": 0
    },
    {
      "question": "ভরবেগের পরিবর্তনের হার—",
      "options": ["বেগ", "ত্বরণ", "বল", "শক্তি"],
      "correct": 2
    },
    {
      "question": "কাজের একক—",
      "options": ["নিউটন", "জুল", "ওয়াট", "পাস্কেল"],
      "correct": 1
    },
    {
      "question": "1 J = কত erg?",
      "options": ["10⁵ erg", "10⁷ erg", "10⁹ erg", "10³ erg"],
      "correct": 1
    },
    {
      "question": "সংরক্ষণশীল বল—",
      "options": ["ঘর্ষণ বল", "মহাকর্ষ বল", "সান্দ্র বল", "স্থিতি ঘর্ষণ বল"],
      "correct": 1
    },
    {
      "question": "একটি বস্তু ভূপৃষ্ঠ থেকে h উচ্চতায় থাকলে তার বিভব শক্তি—",
      "options": ["mgh", "½mv²", "Fd", "Pt"],
      "correct": 0
    },
    {
      "question": "ঘূর্ণন গতির জড়তা নির্ভর করে—",
      "options": [
        "ভর ও ঘূর্ণন অক্ষের দূরত্ব",
        "কেবল ভর",
        "কেবল আকৃতি",
        "কেবল বেগ"
      ],
      "correct": 0
    },
    {
      "question": "টর্কের একক—",
      "options": ["N", "J", "N·m", "W"],
      "correct": 2
    },
    {
      "question": "কৌণিক ভরবেগ সংরক্ষিত থাকে যখন—",
      "options": ["বাহ্যিক টর্ক শূন্য", "বাহ্যিক বল শূন্য", "ভর শূন্য", "বেগ শূন্য"],
      "correct": 0
    },
    {
      "question": "মহাকর্ষীয় ধ্রুবক G এর একক—",
      "options": ["N·m²/kg²", "N·m²·kg²", "N/kg", "m/s²"],
      "correct": 0
    },
    {
      "question": "পৃথিবীর পৃষ্ঠে অভিকর্ষজ ত্বরণ g = ?",
      "options": ["৯.৮ m/s²", "১০ m/s²", "৯.৮ km/s²", "৬.৬৭×১০⁻¹¹ m/s²"],
      "correct": 0
    },
    {
      "question": "কৃত্রিম উপগ্রহের কক্ষীয় বেগ নির্ভর করে—",
      "options": [
        "উপগ্রহের ভরে",
        "কক্ষপথের ব্যাসার্ধে",
        "উপগ্রহের আকৃতিতে",
        "উপগ্রহের তাপমাত্রায়"
      ],
      "correct": 1
    },
    {
      "question": "পয়সনের অনুপাত (σ) এর মান সাধারণত—",
      "options": ["০.২ থেকে ০.৫", "১ থেকে ২", "শূন্য", "নেগেটিভ"],
      "correct": 0
    },
    {
      "question": "স্প্রিং ধ্রুবক k এর একক—",
      "options": ["N", "N/m", "J", "Pa"],
      "correct": 1
    },
    {
      "question": "পানিতে ডোবা বস্তুর ওজন—",
      "options": ["বাড়ে", "কমে", "অপরিবর্তিত থাকে", "দ্বিগুণ হয়"],
      "correct": 1
    },
    {
      "question": "আর্কিমিডিসের নীতি সম্পর্কিত—",
      "options": ["প্লবতা", "পৃষ্ঠটান", "সান্দ্রতা", "তাপ"],
      "correct": 0
    },
    {
      "question": "সরল স্পন্দন গতির শক্তি—",
      "options": ["ধ্রুবক", "সময়ের সাথে রৈখিকভাবে পরিবর্তিত", "পর্যায়বৃত্তভাবে পরিবর্তিত", "শূন্য"],
      "correct": 0
    },
    {
      "question": "দোলককে চন্দ্রপৃষ্ঠে নিয়ে গেলে পর্যায়কাল—",
      "options": ["বাড়ে", "কমে", "অপরিবর্তিত থাকে", "শূন্য হয়"],
      "correct": 0
    },
    {
      "question": "শব্দের প্রতিধ্বনি শোনার জন্য ন্যূনতম দূরত্ব (প্রায়)—",
      "options": ["১৭ মিটার", "৩৪ মিটার", "৫০ মিটার", "১০০ মিটার"],
      "correct": 1
    },
    {
      "question": "ডপলার ক্রিয়া প্রযোজ্য—",
      "options": [
        "স্থির উৎস ও শ্রোতা",
        "আপেক্ষিক গতিশীল উৎস বা শ্রোতা",
        "মাধ্যমহীন স্থানে",
        "শুধু আলোতে"
      ],
      "correct": 1
    },
    {
      "question": "তাপ পরিবাহিতা (k) এর একক—",
      "options": ["J/s", "W/(m·K)", "J/(kg·K)", "cal"],
      "correct": 1
    },
    {
      "question": "আদর্শ গ্যাস সমীকরণ—",
      "options": ["PV = nRT", "PV = RT", "P = nRT", "V = nRT"],
      "correct": 0
    },
  ];

  final List<Map<String, dynamic>> physics1Set3 = [
    {
      "question": "কোনটি মৌলিক রাশি?",
      "options": ["বল", "ভর", "বেগ", "শক্তি"],
      "correct": 1
    },
    {
      "question": "১ আলোকবর্ষ = কত মিটার (প্রায়)?",
      "options": [
        "৯.৪৬×১০¹৫ m",
        "৩.০৮×১০¹⁶ m",
        "১.৫×১০¹¹ m",
        "৬.৬৭×১০⁻¹¹ m"
      ],
      "correct": 0
    },
    {
      "question": "ত্রিভুজ সূত্রে A + B + C = ০ হলে—",
      "options": [
        "A, B, C সমরেখ",
        "A, B, C ত্রিভুজ গঠন করে",
        "A, B, C শূন্য",
        "A, B, C সমান্তরাল"
      ],
      "correct": 1
    },
    {
      "question": "নিউটনের দ্বিতীয় সূত্র—",
      "options": ["F = ma", "F = mv", "F = m/a", "F = v/t"],
      "correct": 0
    },
    {
      "question": "ভরবেগ সংরক্ষণ সূত্র প্রযোজ্য যখন—",
      "options": ["বাহ্যিক বল শূন্য", "বাহ্যিক টর্ক শূন্য", "ঘর্ষণ শূন্য", "বেগ শূন্য"],
      "correct": 0
    },
    {
      "question": "ক্ষমতা (P) = ?",
      "options": ["কাজ / সময়", "বল × সময়", "শক্তি × সময়", "বল / দূরত্ব"],
      "correct": 0
    },
    {
      "question": "1 HP = কত ওয়াট?",
      "options": ["৫৫০ W", "৭৪৬ W", "১০০০ W", "১০ W"],
      "correct": 1
    },
    {
      "question": "গতিশক্তি (KE) = ?",
      "options": ["mgh", "½mv²", "mv", "½kx²"],
      "correct": 1
    },
    {
      "question": "সংঘর্ষে কোনটি সর্বদা সংরক্ষিত?",
      "options": ["গতিশক্তি", "ভরবেগ", "বিভব শক্তি", "তাপ"],
      "correct": 1
    },
    {
      "question": "জড়তার ভ্রামক (I) নির্ভর করে—",
      "options": [
        "ভর বিন্যাস ও অক্ষ",
        "কেবল ভর",
        "কেবল বেগ",
        "কেবল সময়"
      ],
      "correct": 0
    },
    {
      "question": "একটি চাকা ঘূর্ণায়মান, এর কৌণিক বেগ ω, তবে রৈখিক বেগ v = ?",
      "options": ["v = ω/r", "v = ωr", "v = ω + r", "v = ω²r"],
      "correct": 1
    },
    {
      "question": "নিউটনের সার্বজনীন মহাকর্ষ সূত্রে F ∝ ?",
      "options": ["m₁m₂ / r", "m₁m₂ / r²", "m₁m₂ × r²", "(m₁ + m₂) / r"],
      "correct": 1
    },
    {
      "question": "পলায়ন বেগ (escape velocity) পৃথিবীতে প্রায়—",
      "options": ["৭.৯ km/s", "১১.২ km/s", "৯.৮ km/s", "৩০ km/s"],
      "correct": 1
    },
    {
      "question": "কৃত্রিম উপগ্রহের কক্ষে ওজন—",
      "options": [
        "শূন্য (ভারহীনতা)",
        "পৃথিবীর সমান",
        "দ্বিগুণ",
        "অর্ধেক"
      ],
      "correct": 0
    },
    {
      "question": "Hooke's law প্রযোজ্য—",
      "options": [
        "স্থিতিস্থাপক সীমায়",
        "প্লাস্টিক অবস্থায়",
        "সর্বদা",
        "শূন্য পীড়নে"
      ],
      "correct": 0
    },
    {
      "question": "পীড়ন (stress) = ?",
      "options": ["বল / ক্ষেত্রফল", "বল × ক্ষেত্রফল", "ক্ষেত্রফল / বল", "বল × দূরত্ব"],
      "correct": 0
    },
    {
      "question": "পৃষ্ঠটান সৃষ্টির কারণ—",
      "options": [
        "তরল অণুর মধ্যে আকর্ষণ বল",
        "তরল অণুর বিকর্ষণ বল",
        "মহাকর্ষ",
        "তাপ"
      ],
      "correct": 0
    },
    {
      "question": "বার্নোলির সমীকরণ (P + ½ρv² + ρgh) যা সংরক্ষিত থাকে—",
      "options": ["ভর", "শক্তি", "তাপমাত্রা", "ভরবেগ"],
      "correct": 1
    },
    {
      "question": "সরল ছন্দিত স্পন্দনে ত্বরণ (a) ∝ ?",
      "options": ["–x (সরণ)", "+x", "x²", "1/x"],
      "correct": 0
    },
    {
      "question": "স্প্রিং দোলকের পর্যায়কাল T = ?",
      "options": [
        "2π√(m/k)",
        "2π√(k/m)",
        "2π√(l/g)",
        "2π√(g/l)"
      ],
      "correct": 0
    },
    {
      "question": "তরঙ্গের শক্তি সঞ্চালন হয় কিন্তু—",
      "options": [
        "মাধ্যম সঞ্চালিত হয় না",
        "মাধ্যম সঞ্চালিত হয়",
        "শক্তি সঞ্চালন হয় না",
        "কোনটিই সঞ্চালিত হয় না"
      ],
      "correct": 0
    },
    {
      "question": "শব্দতরঙ্গ শূন্যস্থানে—",
      "options": ["চলতে পারে", "চলতে পারে না", "দ্রুত চলে", "ধীরে চলে"],
      "correct": 1
    },
    {
      "question": "প্রতিফলনে আপতন কোণ ও প্রতিফলন কোণ—",
      "options": ["সমান", "ভিন্ন", "আপতন কোণ দ্বিগুণ", "প্রতিফলন কোণ অর্ধেক"],
      "correct": 0
    },
    {
      "question": "অবতল দর্পণে বস্তু ফোকাসে থাকলে প্রতিবিম্ব—",
      "options": ["অসীমে", "ফোকাসে", "বক্রতা কেন্দ্রে", "দর্পণে"],
      "correct": 0
    },
    {
      "question": "লেন্স নির্মাতার সূত্রে 1/f নির্ভর করে—",
      "options": [
        "প্রতিসরাঙ্ক ও বক্রতা ব্যাসার্ধ",
        "কেবল বক্রতা ব্যাসার্ধ",
        "কেবল প্রতিসরাঙ্ক",
        "লেন্সের রং"
      ],
      "correct": 0
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HSC পদার্থবিজ্ঞান কুইজ'),
        backgroundColor: Colors.green.shade700,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 20),
          const Text(
            'পত্র নির্বাচন করুন',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildPaperCard(
            context: context,
            title: 'পদার্থবিজ্ঞান ১ম পত্র',
            subtitle: '৩টি সেট | প্রতি সেটে ২৫টি MCQ',
            paper: 'physics1',
            color: Colors.green,
          ),
          const SizedBox(height: 16),
          // পরে ২য় পত্রের কার্ড এখানেই যোগ করবে
        ],
      ),
    );
  }

  Widget _buildPaperCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String paper,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          final int setNo = _random.nextInt(3) + 1;
          final questions = switch (setNo) {
            1 => physics1Set1,
            2 => physics1Set2,
            3 => physics1Set3,
            _ => physics1Set1,
          };

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PhysicsTestScreen(
                paper: paper,
                setNumber: setNo,
                questions: questions,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withOpacity(0.75)],
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _infoChip('২৫টি প্রশ্ন'),
                  const SizedBox(width: 8),
                  _infoChip('২৫ মিনিট'),
                  const SizedBox(width: 8),
                  _infoChip('র‍্যান্ডম সেট'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
