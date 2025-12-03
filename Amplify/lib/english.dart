import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class EnglishExamPage extends StatefulWidget {
  const EnglishExamPage({super.key});

  @override
  State<EnglishExamPage> createState() => _EnglishExamPageState();
}

class _EnglishExamPageState extends State<EnglishExamPage> {
  bool showAnswers = false;
  bool isPlayingListening = false;
  final FlutterTts flutterTts = FlutterTts();

  final List<String> listeningScripts = [
    // Listening Part 1
    """Good morning, everyone. Tomorrow we will have a short quiz on chapters one and two of your English book. The quiz will include a reading passage and five multiple-choice questions. Please bring a pencil, an eraser, and your dictionary. If you have any questions, you can ask me after class today.""",
    // Listening Part 2
    """Hello, this is Rina. I'm calling to tell you that our study group is meeting at 4 p.m. in the library instead of 3 p.m. at the café. Please bring your grammar notes so we can review for the test next week. If you cannot come, send me a message. See you soon.""",
    // Listening Part 3 (Weather)
    """Good afternoon. Here is the local weather report for today. This morning will be cool and cloudy, with a light wind from the north. In the afternoon, the temperature will rise, and there may be short showers in some areas. In the evening, the sky will clear again, but the air will feel cooler. If you are going out later, you may want to take a light jacket or an umbrella."""
  ];

  Future<void> playListening(int index) async {
    setState(() {
      isPlayingListening = true;
    });
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.45);
    await flutterTts.speak(listeningScripts[index]);
    setState(() {
      isPlayingListening = false;
    });
  }

  @override
  void dispose() {
    flutterTts.stop();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('English Exam', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple[700],
        elevation: 4,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _examHeader(),

              _examSection(
                'Listening Section 1',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _audioButton(0, label: 'Play Listening Part 1'),
                    const SizedBox(height: 8),
                    _questionList([
                      '1. What will tomorrow’s quiz include?\n   A. Only grammar questions\n   B. A reading passage and five multiple‑choice questions\n   C. Only listening questions',
                      '2. What should students bring to the quiz?\n   A. Pencil and ruler\n   B. Pencil, eraser, and dictionary\n   C. Only a notebook',
                      '3. When can students ask questions about the quiz?\n   A. During the quiz\n   B. Before school tomorrow\n   C. After class today',
                    ])
                  ],
                ),
              ),

              _examSection(
                'Listening Section 2',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _audioButton(1, label: 'Play Listening Part 2'),
                    const SizedBox(height: 8),
                    _questionList([
                      '4. Fill in the note:\n   Time: ______\n   Place: ______\n   Purpose: ______\n   What to bring: ______',
                      '5. Write your own short phone message changing time, place, and purpose.',
                    ]),
                  ],
                ),
              ),

              _examSection(
                'Listening Section 3',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _audioButton(2, label: 'Play Listening Part 3 (Weather)'),
                    const SizedBox(height: 8),
                    _questionList([
                      '6. Choose the best summary:\n   (a) Hot and sunny all day\n   (b) Changing weather with clouds, some rain, then cooler evening\n   (c) Heavy rain all day',
                      '7. Draw a timeline of Morning / Afternoon / Evening and write the weather for each.',
                    ]),
                  ],
                ),
              ),

              _examSection(
                'Reading Passage 1: The Science Fair',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _passageCard(
                        """Maria wakes up early on Saturday because her school is hosting a science fair. She has prepared a small project about clean water using simple filters made from sand, stones, and cotton. At the fair, many parents and students walk around, asking questions about the projects. Maria feels nervous at first, but when a little boy says he now understands why clean water is important, she smiles and becomes more confident. At the end of the day, her teacher thanks her for working hard and helping others learn something new."""
                    ),
                    _questionList([
                      '8. Where is Maria going on Saturday, and why?',
                      '9. What materials did she use to make her project about clean water?',
                      '10. How does Maria feel at the beginning of the fair, and how does she feel later?',
                      '11. What does the little boy learn from Maria’s project?',
                      '12. Why does the teacher thank Maria at the end of the day?',
                      '13. "nervous": (a) very happy (b) worried or afraid (c) bored',
                      '14. "confident": (a) sure of yourself (b) very tired (c) angry',
                      '15. Write a short paragraph about a school event you enjoyed. Use at least five past simple verbs and underline them.',
                    ]),
                  ],
                ),
              ),

              _examSection(
                'Reading Passage 2: A Busy Monday',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _passageCard(
                        """On Monday morning, Hasan's alarm does not ring, so he wakes up late. He jumps out of bed, gets dressed quickly, and almost forgets his homework on the table. When he reaches the bus stop, the school bus has already left. Hasan decides to walk to school, even though it is far and the weather is very hot. When he finally arrives, his teacher is surprised but pleased that he still came to school. Hasan learns that being responsible means trying his best, even when the day starts badly."""
                    ),
                    _questionList([
                      '16. True or false:\n a) Hasan\'s alarm rings on time.\n b) Hasan forgets his homework completely.\n c) The teacher is angry when Hasan arrives.',
                      '17. How does Hasan get to school?',
                      '18. What does Hasan learn at the end?',
                      '19. Find five past simple verbs from the passage.',
                      '20. Change those five verbs into present simple form.',
                    ]),
                  ],
                ),
              ),

              _examSection(
                'Dialogue Practice',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _passageCard(
                        """A: Hi Sam, are you ready for the English test tomorrow?
B: Not really. I'm worried about the listening part.
A: Me too, but we can practise together. Let's read a short text and take turns asking questions.
B: That sounds good. Can we also review some vocabulary?
A: Of course. First, we read, then we ask and answer questions, and finally we check difficult words.
B: Great plan. Let's start now so we can feel more confident tomorrow."""
                    ),
                    _questionList([
                      '21. Practise the dialogue in pairs, then perform it without looking.',
                      '22. Change details and perform again (e.g., "English test" → "math exam", "listening part" → "speaking part").',
                      '23. Write three new questions that A and B could ask each other about their study habits.'
                    ])
                  ],
                ),
              ),

              _examSection(
                'Grammar & Mixed Skills',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _questionList([
                      '24. When do we use "since" and when do we use "for"?',
                      '25. Write five sentences with "since".',
                      '26. Write five sentences with "for".',
                      '27. Choose one passage and write a different ending in 4–6 sentences.',
                      '28. In pairs, create a new dialogue where two students plan a group project.',
                      '29. Write five sentences about your daily routine (present simple).',
                      '30. Write five sentences about what you are doing right now (present continuous).',
                    ])
                  ],
                ),
              ),

              _examSection(
                'English Rules Reference',
                child: _rulesCard(
                    """1. Basic word order: Subject + Verb + Object.
2. Present simple for routines/facts; present continuous for actions now.
3. Present simple: add '-s' or '-es' with he/she/it.
4. Questions: use 'do/does'.
5. Countable nouns: use 'many', uncountable: use 'much'.
6. Sentences start with capital, end with correct punctuation."""
                ),
              ),

              const SizedBox(height: 18),

              _showAnswerButton(),
              if (showAnswers) _answersCard(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _examHeader() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('English Exam', style: TextStyle(
            fontSize: 26, fontWeight: FontWeight.bold, color: Colors.deepPurple[800]
        )),
        const SizedBox(height: 6),
        Text('Time allowed: 60 minutes    |   Do not write the answers before "Show Answers" is pressed.',
            style: TextStyle(fontSize: 14, color: Colors.black87)),
      ],
    ),
  );

  Widget _audioButton(int index, {String label = "Play Audio"}) {
    return Row(
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          ),
          icon: const Icon(Icons.volume_up),
          label: Text(label),
          onPressed: isPlayingListening ? null : () => playListening(index),
        ),
        if (isPlayingListening)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text('Playing...', style: TextStyle(color: Colors.deepPurple)),
          )
      ],
    );
  }

  Widget _examSection(String title, {required Widget child}) => Padding(
    padding: const EdgeInsets.only(top: 24, bottom: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[700]
        )),
        const Divider(),
        child,
      ],
    ),
  );

  Widget _passageCard(String text) => Card(
    color: Colors.white,
    elevation: 2,
    margin: const EdgeInsets.symmetric(vertical: 12),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(text, style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.5)),
    ),
  );

  Widget _rulesCard(String text) => Card(
    color: Colors.indigo.shade50,
    elevation: 0,
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(text, style: const TextStyle(fontSize: 15, color: Colors.indigo)),
    ),
  );

  Widget _questionList(List<String> qs) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(qs.length, (i) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(qs[i], style: const TextStyle(fontSize: 16, color: Colors.black)),
    )),
  );

  Widget _showAnswerButton() => Center(
    child: ElevatedButton.icon(
      icon: Icon(showAnswers ? Icons.visibility_off : Icons.visibility),
      label: Text(showAnswers ? "Hide Answers" : "Show Answers"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
      ),
      onPressed: () {
        setState(() { showAnswers = !showAnswers; });
      },
    ),
  );

  Widget _answersCard() => Card(
    color: Colors.green[50],
    elevation: 1,
    margin: const EdgeInsets.symmetric(vertical: 18),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Answers', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
          const Divider(color: Colors.green),
          _answersText()
        ],
      ),
    ),
  );

  Widget _answersText() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("""Listening:
1. B
2. B
3. C

4. Time: 4 p.m.  Place: library  Purpose: study group for test  What to bring: grammar notes
6. (b) Changing weather with clouds, some rain, then cooler evening

Reading Passage 1:
8. She is going to school for a science fair.
9. Sand, stones, cotton.
10. Nervous at first, confident later.
11. He learns why clean water is important.
12. For helping others learn.
13. (b).  14. (a)
15. Open (requires past simple verbs).

Reading Passage 2:
16. False, False, False.
17. He walks.
18. To try his best even if day starts badly.
19. did not ring, woke, jumped, forgot, reached, decided, arrived, was, learned
20. does not ring, wakes, jumps, forgets, reaches, decides, arrives, is, learns

Dialogue:
21-23. Open/performance.

Grammar: "since": starting time. "for": time period.

English Rules: as in reference section.
""", style: const TextStyle(fontSize: 15, color: Colors.green)),
    ],
  );
}
