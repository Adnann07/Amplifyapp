import 'package:flutter/material.dart';
import 'class910.dart';
import 'class1011.dart';
import 'dart:math';
import 'robotics.dart';
import 'ielts.dart';
import 'brainsharper.dart';
import 'submit.dart';
import 'chatbot_screen.dart';
import 'gemini_api_service.dart';
import 'quiz_screen.dart';
import 'flashcard_screen.dart';
import 'ict.dart';
import 'dart:ui';
import 'practical_examples_page.dart';
import 'english.dart';
import 'dsa_practice_page.dart';
import 'hsc_exam_page.dart';
import 'mechanical_visualizations.dart';
import 'dsadekh.dart';
import 'sms_service.dart';
import 'subscription_service.dart';
import 'subscription_gate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ScrollController _scrollController;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // NEW: Handle card tap with subscription check
  void _handleCardTap(BuildContext context, String featureName, Widget page) {
    if (SubscriptionService.isSubscribed) {
      // Already subscribed - go directly to feature
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => page),
      );
    } else {
      // Not subscribed - show subscription dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => SubscriptionGate(
          featureName: featureName,
          child: page,
        ),
      ).then((_) {
        // After dialog closes, check if subscribed and navigate
        if (SubscriptionService.isSubscribed) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Amplify - Virtual Lab',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade800.withOpacity(0.8),
                    Colors.purple.shade700.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              SubscriptionService.isSubscribed
                  ? Icons.verified_user
                  : Icons.notifications_outlined,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    SubscriptionService.isSubscribed
                        ? '✅ Subscribed - All features unlocked!'
                        : '🔒 Tap any feature to subscribe',
                  ),
                  backgroundColor: SubscriptionService.isSubscribed
                      ? Colors.green
                      : Colors.orange,
                ),
              );
            },
            tooltip: 'Subscription Status',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          // Static Background
          RepaintBoundary(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade50,
                    Colors.purple.shade50,
                    Colors.teal.shade50,
                    Colors.pink.shade50,
                  ],
                ),
              ),
            ),
          ),

          // Particles
          ..._buildOptimizedParticles(),

          // Formulas
          _buildStaticFormula('E = mc²', 50, 20, 0.05, 55),
          _buildStaticFormula('F = ma', 150, -30, -0.05, 50),
          _buildStaticFormula('a² + b² = c²', -100, 50, 0.08, 50),
          _buildStaticFormula('∫ f(x) dx', -200, -40, -0.1, 45),

          // Main Content
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 120),

                    // Welcome Section
                    RepaintBoundary(child: _buildSimpleWelcome()),

                    const SizedBox(height: 40),

                    // ALL CARDS - NORMAL DISPLAY, SUBSCRIPTION ON TAP
                    _buildSimpleCard(
                      context,
                      'Practical Examples',
                      'Real-world Sensor Experiments',
                      Icons.build_circle_outlined,
                      [Colors.teal.shade600, Colors.teal.shade400],
                      const PracticalExamplesPage(),
                      'Use your phone sensors for Physics and Chemistry experiments.',
                    ),

                    const SizedBox(height: 20),

                    _buildSimpleCard(
                      context,
                      'DSA Visualizations',
                      'Learn fundamental Data Structures & Algorithms visually',
                      Icons.data_object,
                      [Colors.deepPurple.shade600, Colors.deepPurple.shade400],
                      const DSAVisualizationsPage(),
                      'Interactive, animated demos of sorting, trees, graphs, stacks, queues, and linked lists.',
                    ),

                    const SizedBox(height: 20),

                    _buildSimpleCard(
                      context,
                      'Class 10-11',
                      'Advanced Science & Higher Math',
                      Icons.science_outlined,
                      [Colors.blue.shade600, Colors.blue.shade400],
                      const Class1011Page(),
                      'Dive deeper into advanced topics including Biology, Higher Mathematics, and complex scientific principles.',
                    ),

                    const SizedBox(height: 20),

                    _buildSimpleCard(
                      context,
                      'Class 9-10',
                      'Foundational Science & Math',
                      Icons.school_outlined,
                      [Colors.green.shade600, Colors.green.shade400],
                      const Class910Page(),
                      'Explore basic concepts in Physics, Chemistry, and Mathematics with interactive experiments.',
                    ),

                    const SizedBox(height: 20),

                    _buildSimpleCard(
                      context,
                      'ICT Studio',
                      'Compiler and ICT practice',
                      Icons.code_outlined,
                      [Colors.indigo.shade600, Colors.indigo.shade400],
                      const IctPage(),
                      'Master programming concepts with our interactive compiler and exercises.',
                    ),

                    const SizedBox(height: 20),

                    _buildSimpleCard(
                      context,
                      'Academic Assistant',
                      'Your AI-powered assist',
                      Icons.auto_awesome_outlined,
                      [Colors.purple.shade600, Colors.purple.shade400],
                      const Submit(),
                      'Get personalized help with homework, research, and academic projects.',
                    ),

                    const SizedBox(height: 20),

                    _buildSimpleCard(
                      context,
                      'HSC mock test',
                      'Physics, Chemistry, Math, Biology',
                      Icons.quiz,
                      [Colors.deepPurple.shade600, Colors.deepPurple.shade400],
                      const HSCExamPage(),
                      'HSC mock mcq tests',
                    ),

                    const SizedBox(height: 20),

                    _buildSimpleCard(
                      context,
                      'DSA Practice',
                      'Master 35 Coding Problems',
                      Icons.code_rounded,
                      [Colors.deepPurple.shade600, Colors.indigo.shade500],
                      const DSAPracticePage(),
                      'Practice essential Data Structures & Algorithms with complete C++ solutions organized by topic.',
                    ),

                    const SizedBox(height: 20),

                    _buildSimpleCard(
                      context,
                      'IELTS Prep',
                      'IELTS practice sets',
                      Icons.translate_outlined,
                      [Colors.orange.shade600, Colors.orange.shade400],
                      const IELTSExamPage(),
                      'Master all four IELTS skills with comprehensive practice materials.',
                    ),

                    const SizedBox(height: 20),

                    _buildSimpleCard(
                      context,
                      'English Practice',
                      'Reading, Listening & Grammar',
                      Icons.book_outlined,
                      [Colors.deepPurple, Colors.indigo],
                      const EnglishExamPage(),
                      'Practice English with original passages, listening scripts, dialogues, and exam answers.',
                    ),

                    const SizedBox(height: 20),

                    _buildSimpleCard(
                      context,
                      'Mechanical Engg',
                      'Statics & Fluid Dynamics',
                      Icons.engineering,
                      [Colors.cyan.shade600, Colors.cyan.shade400],
                      const MechanicalVisualizationsPage(),
                      'Interactive animations of beams, trusses, flow, and free-body diagrams.',
                    ),

                    const SizedBox(height: 20),

                    _buildSimpleCard(
                      context,
                      'Gamify',
                      'Sharpen your brain while having fun',
                      Icons.psychology_outlined,
                      [Colors.pink.shade600, Colors.pink.shade400],
                      const BrainSharperPage(),
                      'Challenge yourself with engaging brain games and cognitive exercises.',
                    ),

                    const SizedBox(height: 20),

                    _buildSimpleCard(
                      context,
                      'IoT Lab',
                      'Foundational IoT practice',
                      Icons.memory_outlined,
                      [Colors.teal.shade600, Colors.teal.shade400],
                      const RoboticsPage(),
                      'Explore IoT and robotics equipments.',
                    ),

                    const SizedBox(height: 50),

                    // Features Grid
                    RepaintBoundary(child: _buildSimpleFeatures()),

                    const SizedBox(height: 40),

                    // Footer
                    RepaintBoundary(child: _buildSimpleFooter()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Particles
  List<Widget> _buildOptimizedParticles() {
    return List.generate(10, (index) {
      final size = 4.0;
      final opacity = 0.06;
      return Positioned(
        left: ((index * 97) % 400).toDouble(),
        top: ((index * 83) % 800).toDouble(),
        child: RepaintBoundary(
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: [
                Colors.blue,
                Colors.purple,
                Colors.teal,
              ][index % 3].withOpacity(opacity),
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    });
  }

  // Static Formula
  Widget _buildStaticFormula(
      String formula,
      double top,
      double left,
      double angle,
      double fontSize,
      ) {
    return Positioned(
      top: top,
      left: left,
      child: RepaintBoundary(
        child: Opacity(
          opacity: 0.05,
          child: Transform.rotate(
            angle: angle,
            child: Text(
              formula,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.blueGrey.shade700,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Welcome Section
  Widget _buildSimpleWelcome() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(35),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade400,
                        Colors.purple.shade400,
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.science,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 25),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      Colors.blue.shade900,
                      Colors.purple.shade700,
                    ],
                  ).createShader(bounds),
                  child: const Text(
                    'Welcome to Amplify',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Virtual Lab',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                    color: Colors.blue.shade900,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Experience interactive learning through virtual experiments and simulations',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade800,
                    height: 1.6,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Simple Card - NOW HANDLES SUBSCRIPTION ON TAP
  Widget _buildSimpleCard(
      BuildContext context,
      String title,
      String subtitle,
      IconData icon,
      List<Color> gradientColors,
      Widget page,
      String description,
      ) {
    return RepaintBoundary(
      child: InkWell(
        onTap: () => _handleCardTap(context, title, page),
        borderRadius: BorderRadius.circular(25),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: gradientColors[0].withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.95),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.85),
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white.withOpacity(0.8),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Features
  Widget _buildSimpleFeatures() {
    final features = [
      {
        'icon': Icons.view_in_ar_outlined,
        'title': '3D Models',
        'color': Colors.blue,
        'description': 'Interactive visualizations'
      },
      {
        'icon': Icons.touch_app_outlined,
        'title': 'Touch Controls',
        'color': Colors.green,
        'description': 'Intuitive interactions'
      },
      {
        'icon': Icons.insights_outlined,
        'title': 'Real-time Data',
        'color': Colors.orange,
        'description': 'Live graphs & charts'
      },
      {
        'icon': Icons.science_outlined,
        'title': 'Virtual Labs',
        'color': Colors.purple,
        'description': 'Safe experiments'
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            'Key Features',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Experience learning like never before',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 35),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.0,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              final feature = features[index];
              return RepaintBoundary(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(4, 4),
                        blurRadius: 8,
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4, -4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              (feature['color'] as Color).withOpacity(0.8),
                              (feature['color'] as Color).withOpacity(0.6),
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          feature['icon'] as IconData,
                          size: 36,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        feature['title'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          feature['description'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            height: 1.3,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Footer
  Widget _buildSimpleFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey.shade50,
            Colors.grey.shade100,
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.rocket_launch_outlined,
                  size: 24, color: Colors.blue.shade700),
              const SizedBox(width: 10),
              Text(
                'Amplify Virtual Lab',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            'Transforming Education Through Technology',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.code, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Text(
                'Built with Flutter • © 2025 Amplify',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
