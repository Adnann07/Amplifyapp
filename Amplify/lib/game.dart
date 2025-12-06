import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class EmergencyActsPage extends StatefulWidget {
  const EmergencyActsPage({super.key});

  @override
  State<EmergencyActsPage> createState() => _EmergencyActsPageState();
}

class _EmergencyActsPageState extends State<EmergencyActsPage>
    with TickerProviderStateMixin {
  // Animations
  late AnimationController _shakeController;
  late AnimationController _breathingController;
  late AnimationController _bgFloatController;
  late AnimationController _pulseController;

  Timer? _gameTimer;
  int _score = 0;
  int _lives = 3;
  int _level = 1;
  double _health = 100.0;
  int _timeLeft = 60;

  bool _showIntro = true;
  bool _showStepResult = false;
  bool _showScenarioComplete = false;
  bool _showGameOver = false;
  bool _lastStepCorrect = false;

  String _currentScenarioKey = 'first_aid_bleeding';
  int _dialogIndex = 0;
  int _currentStepIndex = 0;

  int _earnedStars = 0;
  int _totalCorrectSteps = 0;

  late Scenario _currentScenario;
  String _currentExplanation = '';

  @override
  void initState() {
    super.initState();

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _bgFloatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    _loadScenario(_currentScenarioKey);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _breathingController.dispose();
    _bgFloatController.dispose();
    _pulseController.dispose();
    _gameTimer?.cancel();
    super.dispose();
  }

  // ===== DATA MODEL =====

  final Map<String, Scenario> _scenarios = {
    'first_aid_bleeding': Scenario(
      id: 'first_aid_bleeding',
      type: ScenarioType.firstAid,
      bgColor: const Color(0xFFE57373),
      bgEmoji: '🩸',
      npcName: 'রহিম',
      npcImage: 'assets/images/rahim.png',
      title: 'রক্তক্ষরণ বন্ধ করার মিশন',
      sceneText: 'রহিমের হাত কেটে গেছে এবং রক্ত পড়ছে!',
      dialogs: [
        'আরে! আমার হাত কেটে গেছে... রক্ত থামছে না!',
        'তুমি কি আমাকে সাহায্য করতে পারবে? দয়া করে দ্রুত!',
      ],
      steps: [
        ScenarioStep(
          question: 'প্রথমে তুমি কী করবে?',
          options: [
            GameOption('🧤 নিজের সুরক্ষার জন্য গ্লাভস/পরিষ্কার কাপড় ব্যবহার করো', true),
            GameOption('💧 সরাসরি রক্তে হাত দিয়ে সাহায্য করো', false),
            GameOption('📞 প্রথমে ১০ মিনিট ফোন করো', false),
            GameOption('🏃 দ্রুত দৌড়ে পালাও', false),
          ],
          scientificExplain:
          '🧪 বৈজ্ঞানিক কারণ: অন্যের রক্তে সরাসরি হাত দিলে তোমার শরীরে রোগজীবাণু (যেমন হেপাটাইটিস, এইচআইভি) ঢুকতে পারে। সবসময় গ্লাভস বা পরিষ্কার কাপড় দিয়ে নিজেকে সুরক্ষিত রাখো — এটা Standard Precautions নামে পরিচিত।',
        ),
        ScenarioStep(
          question: 'রক্ত বন্ধ করতে কোন পদ্ধতি সবচেয়ে কার্যকর?',
          options: [
            GameOption('🩹 ক্ষতস্থানে পরিষ্কার কাপড় দিয়ে সরাসরি চাপ দাও', true),
            GameOption('💦 শুধু পানি ঢালো', false),
            GameOption('🧈 ঘি বা মাখন লাগাও', false),
            GameOption('🌿 পাতা বা মাটি লাগাও', false),
          ],
          scientificExplain:
          '🧪 বৈজ্ঞানিক কারণ: ক্ষতস্থানে চাপ দিলে রক্তনালীগুলো সাময়িকভাবে সংকুচিত হয় এবং রক্ত জমাট বাঁধার প্রক্রিয়া (clotting) দ্রুত হয়। ৫–১০ মিনিট টানা চাপ দিলে বেশিরভাগ রক্তক্ষরণ বন্ধ হয়। ঘি/মাখন/পাতা সংক্রমণ বাড়াতে পারে এবং কোনো চিকিৎসা সুবিধা দেয় না।',
        ),
        ScenarioStep(
          question: 'যদি রক্ত বন্ধ না হয়, তাহলে কী করবে?',
          options: [
            GameOption('🩹 প্রথম প্যাডের উপর আরেকটি প্যাড দিয়ে শক্ত করে চাপ দাও', true),
            GameOption('🧺 প্রথম প্যাড সরিয়ে নতুন লাগাও', false),
            GameOption('🏃 হাত নাড়িয়ে দেখো', false),
            GameOption('⏰ ৩০ মিনিট অপেক্ষা করো', false),
          ],
          scientificExplain:
          '🧪 বৈজ্ঞানিক কারণ: প্রথম প্যাড সরালে আবার নতুন করে রক্তক্ষরণ শুরু হতে পারে কারণ জমাট বাঁধা রক্ত (clot) উঠে যাবে। তাই প্যাডের উপর আরও প্যাড দিয়ে চাপ বাড়াও এবং জরুরি চিকিৎসার জন্য ডাক্তার বা হাসপাতালে যোগাযোগ করো।',
        ),
      ],
    ),
    'first_aid_cpr': Scenario(
      id: 'first_aid_cpr',
      type: ScenarioType.firstAid,
      bgColor: const Color(0xFF64B5F6),
      bgEmoji: '💙',
      npcName: 'বুবাই ভাই',
      npcImage: 'assets/images/bubai.png',
      title: 'CPR উদ্ধার মিশন',
      sceneText: 'বুবাই ভাই মাটিতে পড়ে আছেন, সাড়া দিচ্ছেন না!',
      dialogs: [
        'বুবাই ভাই সাড়া দিচ্ছেন না... মনে হচ্ছে হার্ট অ্যাটাক!',
        'সঠিকভাবে সাহায্য না করলে মস্তিষ্কে অক্সিজেন পৌঁছাবে না!',
      ],
      steps: [
        ScenarioStep(
          question: 'প্রথম কাজ কী হবে?',
          options: [
            GameOption('👤 নিরাপদ কিনা চেক করো + তাকে সাড়া দিতে বলো (চাঁপাচাঁপি দাও)', true),
            GameOption('💦 মুখে পানি ছিটাও', false),
            GameOption('📞 ৩০ মিনিট ফোনে কথা বলো', false),
            GameOption('🏃 তাকে দাঁড় করানোর চেষ্টা করো', false),
          ],
          scientificExplain:
          '🧪 বৈজ্ঞানিক কারণ: CPR শুরু করার আগে নিশ্চিত হতে হবে পরিবেশ নিরাপদ (যেমন রাস্তা, বিদ্যুৎ তার) এবং রোগী সত্যিই অচেতন কিনা। কাঁধে চাপ দিয়ে জিজ্ঞেস করো "আপনি ঠিক আছেন?" — কোনো সাড়া না পেলেই CPR দরকার।',
        ),
        ScenarioStep(
          question: 'পরবর্তী জরুরি পদক্ষেপ কী?',
          options: [
            GameOption('📞 ৯৯৯ (বা ১৯০/অ্যাম্বুলেন্স) ডাকো এবং সাহায্য চাও', true),
            GameOption('🚶 তাকে একা রেখে হাসপাতালে যাও', false),
            GameOption('💆 শুধু মাথায় হাত দাও', false),
            GameOption('⏳ ১০ মিনিট অপেক্ষা করো', false),
          ],
          scientificExplain:
          '🧪 বৈজ্ঞানিক কারণ: হার্ট অ্যাটাকে মস্তিষ্ক ৪–৬ মিনিট অক্সিজেন ছাড়া স্থায়ী ক্ষতিগ্রস্ত হতে পারে। তাই দ্রুত অ্যাম্বুলেন্স ডাকা এবং CPR শুরু করা একসাথে জরুরি। তুমি একা থাকলে প্রথমে ডাক দিয়ে তারপর CPR শুরু করো।',
        ),
        ScenarioStep(
          question: 'CPR এর সঠিক পদ্ধতি কোনটি? (শিশুদের জন্য)',
          options: [
            GameOption('💆 বুকের মাঝখানে ৩০ বার compression + ২ বার শ্বাস দাও', true),
            GameOption('🫁 শুধু মুখে শ্বাস দাও', false),
            GameOption('🦶 পা ম্যাসাজ করো', false),
            GameOption('💧 পানি খাওয়াও', false),
          ],
          scientificExplain:
          '🧪 বৈজ্ঞানিক কারণ: বুকে compression দিলে হৃদপিণ্ড পাম্পের মতো কাজ করে — রক্ত মস্তিষ্ক ও গুরুত্বপূর্ণ অঙ্গে পৌঁছায়। ৩০ compression এর পর ২ বার শ্বাস (rescue breath) দিলে ফুসফুসে নতুন অক্সিজেন ঢোকে। এই ৩০:২ অনুপাত বৈজ্ঞানিকভাবে প্রমাণিত সবচেয়ে কার্যকর। (দ্রষ্টব্য: বাচ্চাদের জন্য বুকের গভীরতা ~৫ সেমি বা ১/৩ বুকের গভীরতা, গতি ১০০–১২০/মিনিট)',
        ),
      ],
    ),
    'earthquake_drop': Scenario(
      id: 'earthquake_drop',
      type: ScenarioType.disaster,
      bgColor: const Color(0xFFFFB74D),
      bgEmoji: '🏫',
      npcName: 'জামাল স্যার',
      npcImage: 'assets/images/mrjamal.png',
      title: 'ভূমিকম্পে সেফটি মিশন',
      sceneText: 'স্কুলে হঠাৎ ভূমিকম্প শুরু হয়েছে!',
      dialogs: [
        'মাটি কাঁপছে! আতঙ্কিত হয়ো না, ঠিকভাবে সুরক্ষা নাও।',
        'ড্রপ, কভার, হোল্ড অন মনে রেখো — এটাই বাঁচার উপায়!',
      ],
      steps: [
        ScenarioStep(
          question: 'ভূমিকম্পের প্রথম মুহূর্তে কী করবে?',
          options: [
            GameOption('🛡️ DROP: হাঁটু গেড়ে নিচু হও', true),
            GameOption('🏃 দৌড়ে সিঁড়ি দিয়ে বাইরে বের হও', false),
            GameOption('🪟 জানালার পাশে দাঁড়াও', false),
            GameOption('📱 ফোনে ছবি তোলো', false),
          ],
          scientificExplain:
          '🧪 বৈজ্ঞানিক কারণ: ভূমিকম্পে দাঁড়িয়ে থাকলে ভারসাম্য হারিয়ে পড়ে যেতে পারো এবং মাথায় আঘাত পাওয়ার ঝুঁকি থাকে। হাঁটু গেড়ে নিচু হলে তুমি স্থিতিশীল থাকবে এবং প্রয়োজনে নিরাপদ জায়গায় সরতে পারবে। দৌড়ানো বিপজ্জনক কারণ পথে কিছু পড়তে পারে।',
        ),
        ScenarioStep(
          question: 'এরপর তোমার মাথা ও ঘাড় রক্ষা করতে কী করবে?',
          options: [
            GameOption('🪑 COVER: টেবিল/ডেস্কের নিচে ঢুকে মাথা ঢেকে রাখো', true),
            GameOption('🚪 দরজার ফ্রেমে দাঁড়াও', false),
            GameOption('🪟 জানালার গ্লাস ধরো', false),
            GameOption('🧱 দেয়ালে ঠেস দিয়ে বসো', false),
          ],
          scientificExplain:
          '🧪 বৈজ্ঞানিক কারণ: টেবিল/ডেস্কের নিচে ঢুকলে উপর থেকে পড়া বস্তু (সিলিং প্লাস্টার, আলো, বই) সরাসরি মাথায় আঘাত করতে পারবে না — টেবিল আগে শক নেবে। দরজার ফ্রেম আগে নিরাপদ মনে করা হলেও আধুনিক বিল্ডিং-এ টেবিলের নিচে বেশি সুরক্ষিত। জানালা ভাঙলে কাচ ছিটকে আঘাত করতে পারে।',
        ),
        ScenarioStep(
          question: 'কম্পন চলাকালীন সময়ে কী করবে?',
          options: [
            GameOption('🤲 HOLD ON: টেবিল/আশ্রয় শক্ত করে ধরে থাকো, নড়লে সাথে নড়ো', true),
            GameOption('🏃 কম্পন থামার আগে দৌড়ে বের হও', false),
            GameOption('📞 ফোন করে কাউকে জানাও', false),
            GameOption('🪟 জানালা খুলে দেখো কী হচ্ছে', false),
          ],
          scientificExplain:
          '🧪 বৈজ্ঞানিক কারণ: ভূমিকম্পে মেঝে সরে গেলে টেবিলও সরবে — তাই টেবিল ধরে থাকলে তুমি সুরক্ষিত থাকবে। মাঝপথে দৌড়ালে পড়ে যাওয়া, কিছু মাথায় পড়া বা দেয়াল ধসের ঝুঁকি অনেক বেশি। কম্পন সম্পূর্ণ থামা পর্যন্ত আশ্রয়ে থাকাই সবচেয়ে নিরাপদ।',
        ),
      ],
    ),
    'fire_escape': Scenario(
      id: 'fire_escape',
      type: ScenarioType.disaster,
      bgColor: const Color(0xFFEF5350),
      bgEmoji: '🔥',
      npcName: 'কামাল',
      npcImage: 'assets/images/kamal.png',
      title: 'আগুন থেকে নিরাপদ বের হওয়া',
      sceneText: 'ফ্ল্যাটে আগুন লেগেছে এবং ধোঁয়া ভরে যাচ্ছে!',
      dialogs: [
        'আগুন দ্রুত ছড়ায়, আর ধোঁয়া শ্বাসকষ্ট করে।',
        'সঠিক উপায়ে বের হও, নইলে বিপদ!',
      ],
      steps: [
        ScenarioStep(
          question: 'ধোঁয়াভরা ঘরে তুমি কীভাবে চলবে?',
          options: [
            GameOption('🐊 নিচু হয়ে crawl (হামাগুড়ি দিয়ে) চলো', true),
            GameOption('🚶 সোজা হয়ে দাঁড়িয়ে হাঁটো', false),
            GameOption('🏃 দ্রুত দৌড়ে বের হও', false),
            GameOption('🪟 জানালা খুলে বাতাস ঢোকাও', false),
          ],
          scientificExplain:
          '🧪 বৈজ্ঞানিক কারণ: ধোঁয়া ও গরম গ্যাস হালকা হওয়ায় উপরে জমা হয়, আর নিচের দিকে তুলনামূলক পরিষ্কার বাতাস ও কম তাপমাত্রা থাকে। তাই মাটির কাছাকাছি crawl করলে তুমি বেশি অক্সিজেন পাবে এবং বিষাক্ত কার্বন মনোক্সাইড (CO) কম শ্বাসে নেবে। দাঁড়িয়ে থাকলে ধোঁয়া সরাসরি ফুসফুসে যাবে।',
        ),
        ScenarioStep(
          question: 'মুখ ও নাক সুরক্ষিত রাখতে কী করবে?',
          options: [
            GameOption('🧺 ভেজা কাপড় মুখে ও নাকে চেপে ধরো', true),
            GameOption('🫁 স্বাভাবিকভাবে শ্বাস নাও', false),
            GameOption('💨 গভীর শ্বাস নিয়ে দৌড়াও', false),
            GameOption('📢 চিৎকার করতে থাকো', false),
          ],
          scientificExplain:
          '🧪 বৈজ্ঞানিক কারণ: ভেজা কাপড় একটি সাধারণ ফিল্টার হিসেবে কাজ করে — এটি ধোঁয়ার কিছু কণা ও বিষাক্ত গ্যাস আটকায় এবং শ্বাসনালীকে গরম বাতাস থেকে রক্ষা করে। শুকনো কাপড়ের চেয়ে ভেজা কাপড় বেশি কার্যকর। গভীর শ্বাস নিলে বেশি বিষাক্ত গ্যাস ফুসফুসে ঢুকবে।',
        ),
        ScenarioStep(
          question: 'বিল্ডিং থেকে বের হতে কোন পথ ব্যবহার করবে?',
          options: [
            GameOption('🪜 সিঁড়ি ব্যবহার করো (লিফট নয়)', true),
            GameOption('🛗 লিফট ব্যবহার করো', false),
            GameOption('🪟 জানালা দিয়ে লাফ দাও', false),
            GameOption('🚪 দরজা খোলা রেখে দাঁড়াও', false),
          ],
          scientificExplain:
          '🧪 বৈজ্ঞানিক কারণ: আগুনে লিফটের বিদ্যুৎ বন্ধ হয়ে যেতে পারে এবং তুমি ভিতরে আটকে পড়বে। এছাড়া লিফট শ্যাফ্টে ধোঁয়া ও আগুন দ্রুত ছড়ায় (chimney effect)। সিঁড়িতে সাধারণত fire door থাকে যা ধোঁয়া আটকায়। জানালা দিয়ে লাফালে গুরুতর আঘাত বা মৃত্যু হতে পারে — শুধুমাত্র শেষ উপায় হিসেবে বিবেচনা করা যায়।',
        ),
      ],
    ),
  };

  void _loadScenario(String id) {
    _gameTimer?.cancel();
    _currentScenario = _scenarios[id]!;
    _dialogIndex = 0;
    _currentStepIndex = 0;
    _timeLeft = max(30, 60 - (_level * 5)); // Adaptive time
    _showIntro = true;
    _showStepResult = false;
    _showScenarioComplete = false;

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      setState(() {
        _showIntro = false;
      });
      _startTimer();
    });
  }

  void _startTimer() {
    _gameTimer?.cancel();
    final drainRate = 1.5 + (_level * 0.3); // Harder as level increases
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_showStepResult || _showScenarioComplete || _showGameOver) return;

      setState(() {
        _timeLeft--;
        _health = max(0, _health - drainRate);
      });

      if (_timeLeft <= 0 || _health <= 0) {
        _handleGameOver();
      }
    });
  }

  void _handleOptionTap(GameOption option) {
    if (_showStepResult || _showScenarioComplete || _showIntro || _showGameOver)
      return;

    _gameTimer?.cancel();

    final step = _currentScenario.steps[_currentStepIndex];

    if (option.isCorrect) {
      setState(() {
        _score += 30;
        _totalCorrectSteps += 1;
        _health = min(100, _health + 15);
        _lastStepCorrect = true;
        _currentExplanation = step.scientificExplain;
        _showStepResult = true;
      });
    } else {
      _shakeController.forward(from: 0);
      setState(() {
        _lives -= 1;
        _health = max(0, _health - 20);
        _lastStepCorrect = false;
        _currentExplanation = step.scientificExplain;
        _showStepResult = true;
      });
    }
  }

  void _goToNextStepOrScenario() {
    setState(() {
      _showStepResult = false;
    });

    if (!_lastStepCorrect && (_lives <= 0 || _health <= 0)) {
      _handleGameOver();
      return;
    }

    if (_currentStepIndex < _currentScenario.steps.length - 1) {
      setState(() {
        _currentStepIndex++;
      });
      _startTimer();
    } else {
      // Scenario complete
      setState(() {
        _earnedStars += 2;
        _score += 100;
        _showScenarioComplete = true;
      });

      Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;
        setState(() {
          _showScenarioComplete = false;
          _nextScenario();
        });
      });
    }
  }

  void _nextScenario() {
    _level++;
    final keys = _scenarios.keys.toList();
    final currentIndex = keys.indexOf(_currentScenario.id);
    final nextIndex = (currentIndex + 1) % keys.length;
    _currentScenarioKey = keys[nextIndex];
    _loadScenario(_currentScenarioKey);
  }

  void _handleGameOver() {
    _gameTimer?.cancel();
    setState(() {
      _showGameOver = true;
    });
  }

  void _restartGame() {
    setState(() {
      _score = 0;
      _lives = 3;
      _health = 100;
      _earnedStars = 0;
      _totalCorrectSteps = 0;
      _level = 1;
      _showGameOver = false;
    });
    _loadScenario('first_aid_bleeding');
  }

  // ===== UI BUILD =====

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _currentScenario.bgColor.withOpacity(0.85),
              Colors.black.withOpacity(0.95),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              _buildFloatingBackground(),
              Column(
                children: [
                  _buildHUD(),
                  Expanded(
                    child: Stack(
                      children: [
                        _buildNpcAndScene(),
                        if (_showIntro) _buildIntroOverlay(),
                        if (_showStepResult) _buildStepResultOverlay(),
                        if (_showScenarioComplete) _buildScenarioCompleteOverlay(),
                        if (_showGameOver) _buildGameOverOverlay(),
                        if (!_showIntro &&
                            !_showStepResult &&
                            !_showScenarioComplete &&
                            !_showGameOver)
                          _buildOptionPanel(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingBackground() {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _bgFloatController,
        builder: (context, child) {
          return Opacity(
            opacity: 0.08,
            child: CustomPaint(
              painter: EmojiBackgroundPainter(
                emoji: _currentScenario.bgEmoji,
                t: _bgFloatController.value,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHUD() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildScoreBadge(),
              Row(
                children: [
                  _buildMiniBadge('⭐', '$_earnedStars'),
                  const SizedBox(width: 8),
                  _buildMiniBadge('❤️', '$_lives'),
                  const SizedBox(width: 8),
                  _buildMiniBadge('⚡', 'L$_level'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildHealthAndTime(),
        ],
      ),
    );
  }

  Widget _buildScoreBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.amber.shade600,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.6),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          const Text('🏆', style: TextStyle(fontSize: 24)),
          const SizedBox(width: 6),
          Text(
            '$_score',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniBadge(String icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthAndTime() {
    final healthColor = _health > 60
        ? Colors.green
        : _health > 30
        ? Colors.orange
        : Colors.red;

    final timeColor = _timeLeft > 20 ? Colors.white : Colors.redAccent;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 20,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              width: (MediaQuery.of(context).size.width - 40) * (_health / 100),
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [healthColor, healthColor.withOpacity(0.6)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: healthColor.withOpacity(0.5),
                    blurRadius: 8,
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            color: timeColor,
            fontSize: _timeLeft <= 10 ? 16 : 14,
            fontWeight: _timeLeft <= 10 ? FontWeight.bold : FontWeight.normal,
          ),
          child: _timeLeft <= 10
              ? AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Opacity(
                opacity: 0.6 + (_pulseController.value * 0.4),
                child: Text('⏱️ সময়: $_timeLeft সেকেন্ড'),
              );
            },
          )
              : Text('⏱️ সময়: $_timeLeft সেকেন্ড'),
        ),
      ],
    );
  }

  Widget _buildNpcAndScene() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          AnimatedBuilder(
            animation: _breathingController,
            builder: (context, child) {
              final scale = 1 + (_breathingController.value * 0.05);
              return Transform.scale(
                scale: scale,
                child: Column(
                  children: [
                    Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            _currentScenario.bgColor.withOpacity(0.9),
                            _currentScenario.bgColor.withOpacity(0.3),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _currentScenario.bgColor.withOpacity(0.7),
                            blurRadius: 35,
                            spreadRadius: 3,
                          )
                        ],
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          _currentScenario.npcImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.person,
                                size: 70, color: Colors.white);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 9),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                          )
                        ],
                      ),
                      child: Text(
                        _currentScenario.npcName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: _currentScenario.bgColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white38, width: 2),
              ),
              child: Text(
                _currentScenario.sceneText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 100), // Space for option panel
        ],
      ),
    );
  }

  Widget _buildIntroOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.85),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24)),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _currentScenario.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _currentScenario.bgColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    _currentScenario.dialogs[
                    min(_dialogIndex, _currentScenario.dialogs.length - 1)],
                    style: const TextStyle(fontSize: 17, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_dialogIndex <
                            _currentScenario.dialogs.length - 1) {
                          _dialogIndex++;
                        } else {
                          _showIntro = false;
                          _startTimer();
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentScenario.bgColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(
                      _dialogIndex < _currentScenario.dialogs.length - 1
                          ? 'পরবর্তী'
                          : 'মিশন শুরু করো!',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionPanel() {
    final currentStep = _currentScenario.steps[_currentStepIndex];

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white30, width: 2),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ধাপ ${_currentStepIndex + 1}/${_currentScenario.steps.length}',
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  currentStep.question,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: currentStep.options.map((opt) {
                    return ElevatedButton(
                      onPressed: () => _handleOptionTap(opt),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        opt.label,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepResultOverlay() {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _lastStepCorrect ? _breathingController : _shakeController,
        builder: (context, child) {
          double dx = 0;
          if (!_lastStepCorrect) {
            dx = sin(_shakeController.value * 2 * pi * 4) * 12;
          }

          return Transform.translate(
            offset: Offset(dx, 0),
            child: Container(
              color: (_lastStepCorrect
                  ? Colors.green.withOpacity(0.85)
                  : Colors.red.withOpacity(0.85)),
              child: Center(
                child: SingleChildScrollView(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    elevation: 12,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _lastStepCorrect ? '✅ সঠিক কাজ!' : '❌ ঝুঁকিপূর্ণ কাজ!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: _lastStepCorrect
                                  ? Colors.green.shade700
                                  : Colors.red.shade700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _currentExplanation,
                            style: const TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: Colors.black87),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 18),
                          ElevatedButton.icon(
                            onPressed: _goToNextStepOrScenario,
                            icon: const Icon(Icons.arrow_forward),
                            label: Text(
                              _currentStepIndex <
                                  _currentScenario.steps.length - 1
                                  ? 'পরবর্তী ধাপ'
                                  : 'মিশন সম্পূর্ণ করো',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _currentScenario.bgColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScenarioCompleteOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.9),
        child: Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 900),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🎉', style: TextStyle(fontSize: 100)),
                    const SizedBox(height: 16),
                    const Text(
                      'মিশন সফল!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '+১০০ পয়েন্ট • ⭐⭐ সেফটি স্টার',
                      style: TextStyle(
                        color: Colors.amber.shade300,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'পরবর্তী মিশনে যাচ্ছ...',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGameOverOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.95),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              elevation: 15,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '🏁 মিশন শেষ!',
                      style:
                      TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text('মোট স্কোর: $_score',
                        style: const TextStyle(fontSize: 18)),
                    Text('সেফটি স্টার: $_earnedStars',
                        style: const TextStyle(fontSize: 18)),
                    Text('সঠিক ধাপ: $_totalCorrectSteps',
                        style: const TextStyle(fontSize: 18)),
                    Text('সর্বোচ্চ লেভেল: $_level',
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _restartGame,
                            icon: const Icon(Icons.refresh),
                            label: const Text('আবার শুরু'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.home),
                            label: const Text('হোমে ফিরো'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ===== MODEL CLASSES =====

enum ScenarioType { firstAid, disaster }

class Scenario {
  final String id;
  final ScenarioType type;
  final Color bgColor;
  final String bgEmoji;
  final String npcName;
  final String npcImage;
  final String title;
  final String sceneText;
  final List<String> dialogs;
  final List<ScenarioStep> steps;

  Scenario({
    required this.id,
    required this.type,
    required this.bgColor,
    required this.bgEmoji,
    required this.npcName,
    required this.npcImage,
    required this.title,
    required this.sceneText,
    required this.dialogs,
    required this.steps,
  });
}

class ScenarioStep {
  final String question;
  final List<GameOption> options;
  final String scientificExplain;

  ScenarioStep({
    required this.question,
    required this.options,
    required this.scientificExplain,
  });
}

class GameOption {
  final String label;
  final bool isCorrect;

  GameOption(this.label, this.isCorrect);
}

// ===== CUSTOM PAINTER FOR FLOATING EMOJI BG =====

class EmojiBackgroundPainter extends CustomPainter {
  final String emoji;
  final double t;
  final Random _rand = Random(42);

  EmojiBackgroundPainter({required this.emoji, required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    const int count = 20;

    for (int i = 0; i < count; i++) {
      final dx = (i * 79) % size.width;
      final baseDy = (i * 103) % size.height;
      final dy = baseDy + sin(t * 2 * pi + i * 0.5) * 12;

      final textPainter = TextPainter(
        text: TextSpan(
          text: emoji,
          style: TextStyle(fontSize: 28 + _rand.nextInt(8).toDouble()),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(canvas, Offset(dx.toDouble(), dy.toDouble()));
    }
  }

  @override
  bool shouldRepaint(covariant EmojiBackgroundPainter oldDelegate) {
    return oldDelegate.t != t || oldDelegate.emoji != emoji;
  }
}
