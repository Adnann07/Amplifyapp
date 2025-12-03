import 'dart:math';
import 'package:flutter/material.dart';
import 'ict_test_screen.dart';

class IctQuizPage extends StatefulWidget {
  const IctQuizPage({super.key});

  @override
  State<IctQuizPage> createState() => _IctQuizPageState();
}

class _IctQuizPageState extends State<IctQuizPage> {
  final Random _random = Random();

  // Track the last played set to prevent immediate repetition
  int? _lastSetNumber;

  // ============== ICT SET 1 ==============
  final List<Map<String, dynamic>> ictSet1 = [
    {
      "question": "বিশ্বগ্রাম (Global Village) ধারণাটির প্রবক্তা কে?",
      "options": ["বিল গেটস", "মার্ক জাকারবার্গ", "মার্শাল ম্যাকলুহান", "টিম বার্নার্স লি"],
      "correct": 2
    },
    {
      "question": "ক্রায়োসার্জারিতে ব্যবহৃত প্রধান উপাদান কোনটি?",
      "options": ["তরল নাইট্রোজেন", "কার্বন ডাই-অক্সাইড", "হিলিয়াম", "অক্সিজেন"],
      "correct": 0
    },
    {
      "question": "বায়োমেট্রিক্স পদ্ধতিতে ব্যক্তিকে অদ্বিতীয়ভাবে শনাক্ত করতে কোনটি ব্যবহৃত হয়?",
      "options": ["ডিএনএ (DNA)", "হাতের ছাপ (Fingerprint)", "আইরিশ (Iris)", "সবকটি"],
      "correct": 3
    },
    {
      "question": "ডেটা কমিউনিকেশনের মাধ্যম কোনটি?",
      "options": ["মডেম", "হাব", "অপটিক্যাল ফাইবার", "রাউটার"],
      "correct": 2
    },
    {
      "question": "ফুল-ডুপ্লেক্স (Full-Duplex) মোডের উদাহরণ কোনটি?",
      "options": ["রেডিও ব্রডকাস্ট", "টেলিভিশন", "ওয়াকি-টকি", "মোবাইল ফোন"],
      "correct": 3
    },
    {
      "question": "কোন টপোলজিতে একটি কেন্দ্রীয় হাব/সুইচ থাকে?",
      "options": ["বাস (Bus)", "রিং (Ring)", "স্টার (Star)", "মেশ (Mesh)"],
      "correct": 2
    },
    {
      "question": "বাইনারি সংখ্যা (11011)₂ এর সমতুল্য দশমিক মান কত?",
      "options": ["25", "26", "27", "29"],
      "correct": 2
    },
    {
      "question": "ইউনিকোড (Unicode) কত বিটের কোড?",
      "options": ["৮ বিট", "১৬ বিট", "৩২ বিট", "৬৪ বিট"],
      "correct": 1
    },
    {
      "question": "A+B+C লজিক গেইটটি কোন গেইট নির্দেশ করে?",
      "options": ["AND", "OR", "NOT", "NAND"],
      "correct": 1
    },
    {
      "question": "X ⊕ Y এর লজিক ফাংশন কোনটি?",
      "options": ["XY + X̄Ȳ", "X̄Y + XȲ", "XY", "X+Y"],
      "correct": 1
    },
    {
      "question": "HTML-এ ছবি যুক্ত করার সঠিক ট্যাগ কোনটি?",
      "options": ["<image src=\"...\">", "<img src=\"...\">", "<pic src=\"...\">", "<img href=\"...\">"],
      "correct": 1
    },
    {
      "question": "<a> ট্যাগ এর প্রধান অ্যাট্রিবিউট কোনটি?",
      "options": ["src", "link", "href", "ref"],
      "correct": 2
    },
    {
      "question": "নিচের কোনটি এম্পটি (Empty) ট্যাগ?",
      "options": ["<b>", "<p>", "<br>", "<h1>"],
      "correct": 2
    },
    {
      "question": "সি (C) ভাষায় চলক (Variable) হিসেবে কোনটি সঠিক?",
      "options": ["1number", "number_1", "number 1", "\$number"],
      "correct": 1
    },
    {
      "question": "printf() ফাংশনটি কোন হেডার ফাইলে থাকে?",
      "options": ["stdio.h", "conio.h", "math.h", "stdlib.h"],
      "correct": 0
    },
    {
      "question": "লুপ (Loop) এর অত্যাবশ্যকীয় অংশ কয়টি?",
      "options": ["২টি", "৩টি", "৪টি", "৫টি"],
      "correct": 1
    },
    {
      "question": "ডেটাবেজ (Database) এর ক্ষুদ্রতম একক কোনটি?",
      "options": ["ফিল্ড (Field)", "রেকর্ড (Record)", "ডেটা (Data)", "টেবিল (Table)"],
      "correct": 2
    },
    {
      "question": "SQL-এ ডেটা মুছতে কোন কমান্ড ব্যবহৃত হয়?",
      "options": ["REMOVE", "DELETE", "DROP", "CLEAR"],
      "correct": 1
    },
    {
      "question": "প্রাইমারি কি (Primary Key) এর বৈশিষ্ট্য কী?",
      "options": ["ডুপ্লিকেট মান হতে পারে", "নাল (Null) মান হতে পারে", "অদ্বিতীয় মান হতে হবে", "সবকটি"],
      "correct": 2
    },
    {
      "question": "ন্যানোটেকনোলজি (Nanotechnology) কোন এককে পরিমাপ করা হয়?",
      "options": ["মাইক্রোমিটার", "ন্যানোমিটার", "মিলিমিটার", "সেন্টিমিটার"],
      "correct": 1
    },
    {
      "question": "কৃত্তিম বুদ্ধিমত্তা (AI) প্রয়োগের ক্ষেত্র কোনটি?",
      "options": ["এক্সপার্ট সিস্টেম", "গেম প্লেইং", "ন্যাচারাল ল্যাঙ্গুয়েজ প্রসেসিং", "সবকটি"],
      "correct": 3
    },
    {
      "question": "ফাইবার অপটিক ক্যাবল এর কোরে (Core) আলো কোন পদ্ধতিতে প্রবাহিত হয়?",
      "options": ["প্রতিসরণ", "পূর্ণ অভ্যন্তরীণ প্রতিফলন", "বিচ্ছুরণ", "শোষণ"],
      "correct": 1
    },
    {
      "question": "(10)₁₀ এর বিসিডি (BCD) কোড কত?",
      "options": ["0001 0000", "1010", "0000 0001", "0001 0010"],
      "correct": 0
    },
    {
      "question": "int a[5] এর মাধ্যমে মেমোরিতে কতটি ইন্টিজার রাখা যাবে?",
      "options": ["৪টি", "৫টি", "৬টি", "অসীম"],
      "correct": 1
    },
    {
      "question": "নিচের কোনটি রিলেশনাল ডেটাবেজ ম্যানেজমেন্ট সিস্টেম (RDBMS)?",
      "options": ["MS Word", "MS Excel", "MS Access", "PowerPoint"],
      "correct": 2
    },
  ];

  // ============== ICT SET 2 ==============
  final List<Map<String, dynamic>> ictSet2 = [
    {
      "question": "ভার্চুয়াল রিয়েলিটিতে (VR) কোন ধরনের ইমেজ ব্যবহার করা হয়?",
      "options": ["একমাত্রিক (1D)", "দ্বিমাত্রিক (2D)", "ত্রিমাত্রিক (3D)", "চতুর্মাত্রিক (4D)"],
      "correct": 2
    },
    {
      "question": "জেনেটিক ইঞ্জিনিয়ারিং এর মাধ্যমে তৈরি জীবকে কী বলা হয়?",
      "options": ["ক্লোন", "ট্রান্সজেনিক (Transgenic)", "হাইব্রিড", "মিউট্যান্ট"],
      "correct": 1
    },
    {
      "question": "রোবটের যে অংশটি মানুষের হাতের মতো কাজ করে তাকে কী বলে?",
      "options": ["সেন্সর", "অ্যাকচুয়েটর", "ম্যানিপুলেটর", "কন্ট্রোলার"],
      "correct": 2
    },
    {
      "question": "ব্যান্ডউইথ (Bandwidth) কী?",
      "options": ["ডেটা প্রবাহের দিক", "ডেটা প্রবাহের হার", "ডেটা প্রবাহের মাধ্যম", "ডেটা সংরক্ষণের স্থান"],
      "correct": 1
    },
    {
      "question": "ওয়াই-ফাই (Wi-Fi) কোন স্ট্যান্ডার্ডের ওপর ভিত্তি করে কাজ করে?",
      "options": ["IEEE 802.11", "IEEE 802.16", "IEEE 802.15", "IEEE 802.3"],
      "correct": 0
    },
    {
      "question": "নিচের কোনটি আনগাইডেড মিডিয়া (Unguided Media)?",
      "options": ["কো-এক্সিয়াল ক্যাবল", "টুইস্টেড পেয়ার ক্যাবল", "রেডিও ওয়েভ", "অপটিক্যাল ফাইবার"],
      "correct": 2
    },
    {
      "question": "৩-বিট বাইনারি কাউন্টারের সর্বোচ্চ গণনা সংখ্যা কত?",
      "options": ["৩", "৭", "৮", "১৬"],
      "correct": 1
    },
    {
      "question": "হেক্সাডেসিমেল সংখ্যা F এর পরের সংখ্যাটি কত?",
      "options": ["10", "16", "G", "15"],
      "correct": 0
    },
    {
      "question": "A+0 এর মান কত?",
      "options": ["0", "1", "A", "Ā"],
      "correct": 2
    },
    {
      "question": "এনকোডার (Encoder) এর ইনপুট 2ⁿ হলে আউটপুট কত হবে?",
      "options": ["n", "2n", "n²", "2ⁿ"],
      "correct": 0
    },
    {
      "question": "ওয়েব পেজ তৈরির জন্য ব্যবহৃত ভাষা কোনটি?",
      "options": ["C++", "HTML", "Python", "Java"],
      "correct": 1
    },
    {
      "question": "HTML-এ সবচেয়ে বড় হেডিং ট্যাগ কোনটি?",
      "options": ["<h6>", "<h1>", "<head>", "<title>"],
      "correct": 1
    },
    {
      "question": "<ul> ট্যাগ দ্বারা কী তৈরি করা হয়?",
      "options": ["অর্ডারড লিস্ট (Ordered List)", "আন-অর্ডারড লিস্ট (Unordered List)", "ডেটা লিস্ট", "টেবিল"],
      "correct": 1
    },
    {
      "question": "সি ভাষায় float ডেটা টাইপ মেমোরিতে কত বাইট জায়গা নেয়?",
      "options": ["২ বাইট", "৪ বাইট", "৮ বাইট", "১ বাইট"],
      "correct": 1
    },
    {
      "question": "নিচের কোনটি রিলেশনাল অপারেটর?",
      "options": ["&&", "||", ">=", "++"],
      "correct": 2
    },
    {
      "question": "do-while লুপে কন্ডিশন কোথায় থাকে?",
      "options": ["শুরুতে", "শেষে", "মাঝখানে", "থাকে না"],
      "correct": 1
    },
    {
      "question": "ডেটাবেজ টেবিলের সারিকে (Row) কী বলা হয়?",
      "options": ["ফিল্ড", "রেকর্ড (Record)", "অ্যাট্রিবিউট", "ভ্যালু"],
      "correct": 1
    },
    {
      "question": "SELECT * FROM Student; কমান্ডটি কী করবে?",
      "options": ["স্টুডেন্ট টেবিল ডিলিট করবে", "স্টুডেন্ট টেবিলের সব ডেটা দেখাবে", "নতুন স্টুডেন্ট যোগ করবে", "টেবিল আপডেট করবে"],
      "correct": 1
    },
    {
      "question": "ফরেন কি (Foreign Key) এর কাজ কী?",
      "options": ["ডেটা ইউনিক করা", "দুটি টেবিলের মধ্যে সম্পর্ক তৈরি করা", "ডেটা মুছে ফেলা", "ডেটা ইনপুট নেওয়া"],
      "correct": 1
    },
    {
      "question": "বঙ্গবন্ধু স্যাটেলাইট-১ কত সালে উৎক্ষেপণ করা হয়?",
      "options": ["২০১৭", "২০১৮", "২০১৯", "২০২০"],
      "correct": 1
    },
    {
      "question": "ই-কমার্স (E-commerce) এর প্রকারভেদ কোনটি?",
      "options": ["B2B", "B2C", "C2C", "সবকটি"],
      "correct": 3
    },
    {
      "question": "ব্লুটুথ (Bluetooth) কোন ধরনের নেটওয়ার্ক?",
      "options": ["LAN", "MAN", "PAN", "WAN"],
      "correct": 2
    },
    {
      "question": "(1111)₂ + (1)₂ = ?",
      "options": ["10000", "1110", "10001", "10010"],
      "correct": 0
    },
    {
      "question": "সি প্রোগ্রামে \\n এর কাজ কী?",
      "options": ["নতুন ট্যাব নেওয়া", "নতুন লাইন তৈরি করা", "শব্দ মুছে ফেলা", "প্রোগ্রাম শেষ করা"],
      "correct": 1
    },
    {
      "question": "ডেটাবেজে Sort করা মানে কী?",
      "options": ["ডেটা খোঁজা", "ডেটা ক্রমানুসারে সাজানো", "ডেটা মুছে ফেলা", "ডেটা আপডেট করা"],
      "correct": 1
    },
  ];

  // ============== ICT SET 3 ==============
  final List<Map<String, dynamic>> ictSet3 = [
    {
      "question": "ন্যানো টেকনোলজির জনক কে?",
      "options": ["রিচার্ড ফাইনম্যান", "চার্লস ব্যাবেজ", "জন ভন নিউম্যান", "অ্যালান টুরিং"],
      "correct": 0
    },
    {
      "question": "কৃত্রিম বুদ্ধিমত্তা (AI) শব্দটি প্রথম কে ব্যবহার করেন?",
      "options": ["জন ম্যাকার্থি", "এলান টুরিং", "স্টিভ জবস", "বিল গেটস"],
      "correct": 0
    },
    {
      "question": "ড্রোন (Drone) প্রযুক্তি মূলত কী?",
      "options": ["মনুষ্যবাহী বিমান", "মনুষ্যবিহীন বিমান (UAV)", "স্যাটেলাইট", "রাডার"],
      "correct": 1
    },
    {
      "question": "ডেটা ট্রান্সমিশন মোড কত প্রকার?",
      "options": ["২ প্রকার", "৩ প্রকার", "৪ প্রকার", "৫ প্রকার"],
      "correct": 1
    },
    {
      "question": "নিচের কোনটি তারবিহীন মাধ্যম?",
      "options": ["মাইক্রোওয়েভ", "ইনফ্রারেড", "রেডিও ওয়েভ", "সবকটি"],
      "correct": 3
    },
    {
      "question": "ক্লাউড কম্পিউটিং এর বৈশিষ্ট্য কোনটি?",
      "options": ["অন-ডিমান্ড সার্ভিস", "ব্রড নেটওয়ার্ক এক্সেস", "রিসোর্স পুলিং", "সবকটি"],
      "correct": 3
    },
    {
      "question": "আসকি (ASCII) কোডে কতটি ক্যারেক্টার থাকে?",
      "options": ["১২৮", "২৫৬", "৫১২", "১০২৪"],
      "correct": 0
    },
    {
      "question": "২-এর পরিপূরক (2's Complement) নির্ণয়ের সূত্র কী?",
      "options": ["১-এর পরিপূরক + ১", "১-এর পরিপূরক - ১", "১-এর পরিপূরক + ১০", "শুধু ১-এর পরিপূরক"],
      "correct": 0
    },
    {
      "question": "হাফ অ্যাডার (Half Adder) এ কয়টি আউটপুট থাকে?",
      "options": ["১টি", "২টি", "৩টি", "৪টি"],
      "correct": 1
    },
    {
      "question": "ইউনিভার্সাল গেইট (Universal Gate) কোনটি?",
      "options": ["AND", "OR", "NOR", "XOR"],
      "correct": 2
    },
    {
      "question": "<td> ট্যাগ কোথায় ব্যবহৃত হয়?",
      "options": ["টেবিলের হেডার তৈরিতে", "টেবিলের ডেটা সেলে", "ছবির ক্যাপশনে", "লিস্ট তৈরিতে"],
      "correct": 1
    },
    {
      "question": "হাইপারলিংক এর ডিফল্ট রং কী হয়?",
      "options": ["লাল", "সবুজ", "নীল", "কালো"],
      "correct": 2
    },
    {
      "question": "HTML ফাইলে বাংলা ফন্ট ব্যবহারের জন্য কোন ট্যাগ বা অ্যাট্রিবিউট সহায়ক?",
      "options": ["<font face=\"SutonnyMJ\">", "<lang=\"bd\">", "<meta charset=\"UTF-8\">", "<bangla>"],
      "correct": 2
    },
    {
      "question": "সি ভাষায় scanf() ফাংশন কেন ব্যবহৃত হয়?",
      "options": ["আউটপুট দেখাতে", "ইনপুট নিতে", "লুপ চালাতে", "ফাইল খুলতে"],
      "correct": 1
    },
    {
      "question": "% অপারেটরটি কী নির্দেশ করে?",
      "options": ["ভাগফল", "ভাগশেষ (Modulus)", "গুণফল", "শতকরা"],
      "correct": 1
    },
    {
      "question": "অ্যারে (Array) ইনডেক্স শুরু হয় কত থেকে?",
      "options": ["১", "০", "-১", "যেকোনো সংখ্যা"],
      "correct": 1
    },
    {
      "question": "কোন ফিল্ডটি প্রাইমারি কি হতে পারে না?",
      "options": ["রোল নম্বর", "মোবাইল নম্বর", "নাম", "রেজিস্ট্রেশন নম্বর"],
      "correct": 2
    },
    {
      "question": "ডেটাবেজ রিলেশন কত প্রকার?",
      "options": ["২ প্রকার", "৩ প্রকার", "৪ প্রকার", "৫ প্রকার"],
      "correct": 1
    },
    {
      "question": "SQL-এ ডেটা সাজানোর জন্য কোন ক্লজ (Clause) ব্যবহৃত হয়?",
      "options": ["ORDER BY", "SORT BY", "ARRANGE BY", "GROUP BY"],
      "correct": 0
    },
    {
      "question": "ক্রায়োসার্জারি চিকিৎসায় তাপমাত্রা কত হতে পারে?",
      "options": ["-৪১০°C", "-১৯৬°C", "০°C", "-১০০°C"],
      "correct": 1
    },
    {
      "question": "বায়োইনফরমেটিক্স (Bioinformatics) এ প্রধানত কী ব্যবহৃত হয়?",
      "options": ["জীববিজ্ঞান ও কম্পিউটার বিজ্ঞান", "পদার্থবিজ্ঞান", "রসায়ন", "গণিত"],
      "correct": 0
    },
    {
      "question": "মোবাইল ফোনের কোন প্রজন্মে ইন্টারনেট ব্যবহার শুরু হয়?",
      "options": ["১জি (1G)", "২জি (2G)", "৩জি (3G)", "৪জি (4G)"],
      "correct": 1
    },
    {
      "question": "(101101)₂ এর হেক্সাডেসিমেল মান কত?",
      "options": ["2D", "2C", "3D", "45"],
      "correct": 0
    },
    {
      "question": "break স্টেটমেন্ট এর কাজ কী?",
      "options": ["লুপ থেকে বের হওয়া", "লুপ চালিয়ে যাওয়া", "ফাংশন কল করা", "প্রোগ্রাম শুরু করা"],
      "correct": 0
    },
    {
      "question": "one-to-many রিলেশনের উদাহরণ কোনটি?",
      "options": ["একজন ছাত্রের একটি রোল", "একজন শিক্ষকের অনেক ছাত্র", "একজন ব্যক্তির একটি এনআইডি", "একটি দেশের একটি রাজধানী"],
      "correct": 1
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HSC ICT কুইজ', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.science, // Changed icon to look more like a lab
                  size: 80,
                  color: Colors.teal,
                ),
                const SizedBox(height: 20),
                const Text(
                  'তথ্য ও যোগাযোগ প্রযুক্তি',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '৩টি সেট | প্রতি সেটে ২৫টি MCQ',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
                ),
                const SizedBox(height: 40),
                _buildInfoCard('২৫টি প্রশ্ন', Icons.quiz),
                const SizedBox(height: 12),
                _buildInfoCard('২৫ মিনিট সময়', Icons.timer),
                const SizedBox(height: 12),
                _buildInfoCard('র‍্যান্ডম সেট নির্বাচন', Icons.shuffle),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // Ensure we don't pick the same set twice in a row
                    int setNo;
                    do {
                      setNo = _random.nextInt(3) + 1;
                    } while (setNo == _lastSetNumber);

                    _lastSetNumber = setNo;

                    final rawQuestions = switch (setNo) {
                      1 => ictSet1,
                      2 => ictSet2,
                      3 => ictSet3,
                      _ => ictSet1,
                    };

                    // Shuffle questions so even if the set is repeated later, order is new
                    List<Map<String, dynamic>> shuffledQuestions = List.from(rawQuestions)..shuffle();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => IctTestScreen(
                          setNumber: setNo,
                          questions: shuffledQuestions,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'পরীক্ষা শুরু করুন',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal, size: 30),
          const SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800
            ),
          ),
        ],
      ),
    );
  }
}
