import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class EnglishForTodayPage extends StatefulWidget {
  const EnglishForTodayPage({super.key});

  @override
  State<EnglishForTodayPage> createState() => _EnglishForTodayPageState();
}

class _EnglishForTodayPageState extends State<EnglishForTodayPage> {
  final FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  int currentLesson = 0;

  final List<Map<String, String>> lessons = [
    {
      'title': 'Lesson 1: "Mr. Moti"',
      'author': 'by Rahad Abir',
      'unit': 'Unit One: Sense of Self',
      'text': """Unit One: Sense of Self
Lesson 1: "Mr. Moti" by Rahad Abir

Ameen is seventeen when the war breaks out. One Monday, after supper, he announces he will go to war. Sonabhan shrieks in surprise. You want to leave me alone?

It won't take long, Ma, he assures her. I'll be back soon after the training.

That night Sonabhan cannot sleep.

After sun-up, she opens the duck coop. The flock streams out, stretches and quacks around her for their morning meal. She takes longer than usual. She mixes water with rice husks in an earthen bowl and puts it down. They gobble it up in five minutes and head for the pond.

Ameen has let out the chickens by then. He lifts his 12-week-old cockerel, Moti, and sits on the veranda. During his breakfast he doesn't strike up any conversation. Having noticed Sonabhan's puffy eyes, he knows not to mention last night's subject. He casts his glance to the side, down at the cockerel eating rice in silence.

Today is heat bar, market day. Sonabhan has arranged the things Ameen will take to the bazaar to sell. Two dozen eggs, a sheaf of areca nuts, a bottle gourd. The bazaar is about a mile away.

Ameen wears his short-sleeved floral shirt over his lungi. He whistles as he looks into the cloudy mirror to comb his hair. Placing the rattan basket on his head before setting off, he hollers: I'm off, Ma.

Sonabhan watches him go along the bank of the little river. For the first time it occurs to her that Ameen has grown up. He has reached the height of his dead father, has his long neck and straight shoulders.

In that moment, Sonabhan realizes it's not the war, it's the fighting that Ameen is fascinated with. Like his dead father, he is crazy about bullfighting, cockfighting and boat racing. The same stubbornness flows in his blood. Once he decides on something, nothing can stop him.

Her little son! Now a man. Even up to his fifteenth birthday barely a day passed without neighbours appearing with a slew of complaints. Sometimes one or two turned up from other villages. They peeked into the house and asked, Does Ameen live here?

Sonabhan would sigh. What did he do?

Your son stole my date juice! Emptied the juice pots hanging on the date trees! Sonabhan would sigh again. Then ask the visitor to pardon him. She hated saying that she'd raised her son alone. If she could spare them, she would bring half a dozen eggs and hand them to the visitor: Please take these for your children.

At night, Sonabhan climbs out of her bed, clutches the hurricane lamp and tiptoes into Ameen's room. She stands by his bed, looks at her sleeping son. He snores like his father. He has her light skin and button nose. She touches his cheek. His broad forehead. She suppresses a desire to lie beside him. Like the old days, when she slept cuddling her baby.

A warning comes from old Chowkidar's young wife. Watch your rooster, she threatens. I don't want him in my house again.

If someone touches my boy, Sonabhan responds, they'll see the consequences. She grounds Moti for an entire day. It makes him sad. His forlorn captivity crucifies her. She sets him loose the following morning.

Some boys come and ask Sonabhan to lend them Moti for cockfighting at a fair. They are happy to pay.

Never, she tells them. He is my son.

Monday dawns without Moti's crowing. His cold body is resting on its right side. Lying against the basket. Eyes closed. His kingly head down.

With Moti's basket in her lap, Sonabhan is motionless.

She puts Moti to rest beside her husband's grave. She sighs, plods across the empty yard, steps onto an empty veranda, crawls into an empty home and sits on the edge of an empty bed.

Another morning breaks…. Noon and afternoon come and go…. The birds in the coops quack and crow…. No one lets them out. For the first time, Sonabhan's doors do not open.

Note: The excerpts of "Mr. Moti" are selected from the complete story included in When the Mango Tree Blossomed: Fifty Short Stories from Bangladesh edited by Niaz Zaman."""
    },
    {
      'title': 'Lesson 2: "Girl"',
      'author': 'by Jamaica Kincaid',
      'unit': 'Pages 10-11',
      'text': """Lesson 2: "Girl" by Jamaica Kincaid
Text (Pages 10–11):

Wash the white clothes on Monday and put them on the stone heap; wash the color clothes on Tuesday and put them on the clothesline to dry; don't walk bare-head in the hot sun; cook pumpkin fritters in very hot sweet oil; soak your little cloths right after you take them off; when buying cotton to make yourself a nice blouse, be sure that it doesn't have gum in it, because that way it won't hold up well after a wash; soak salt fish overnight before you cook it; is it true that you sing benna in Sunday school?; always eat your food in such a way that it won't turn someone else's stomach; on Sundays try to walk like a lady and not like the slut you are so bent on becoming; don't sing benna in Sunday school; you mustn't speak to wharf-rat boys, not even to give directions; don't eat fruits on the street—flies will follow you; but I don't sing benna on Sundays at all and never in Sunday school; this is how to sew on a button; this is how to make a buttonhole for the button you have just sewed on; this is how to hem a dress when you see the hem coming down and so to prevent yourself from looking like the slut I know you are so bent on becoming; this is how you iron your father's khaki shirt so that it doesn't have a crease; this is how you iron your father's khaki pants so that they don't have a crease; this is how you grow okra—far from the house, because okra tree harbors red ants; when you are growing dasheen, make sure it gets plenty of water or else it makes your throat itch when you are eating it; this is how you sweep a corner; this is how you sweep a whole house; this is how you sweep a yard; this is how you smile to someone you don't like too much; this is how you smile to someone you don't like at all; this is how you smile to someone you like completely; this is how you set a table for tea; this is how you set a table for dinner; this is how you set a table for dinner with an important guest; this is how you set a table for lunch; this is how you set a table for breakfast; this is how to behave in the presence of men who don't know you very well, and this way they won't recognize immediately the slut I have warned you against becoming; be sure to wash every day, even if it is with your own spit; don't squat down to play marbles—you are not a boy, you know; don't pick people's flowers—you might catch something; don't throw stones at blackbirds, because it might not be a blackbird at all; this is how to make a bread pudding; this is how to make doukona; this is how to make pepper pot; this is how to make a good medicine for a cold; this is how to catch a fish; this is how to throw back a fish you don't like, and that way something bad won't fall on you; this is how to bully a man; this is how a man bullies you; this is how to love a man, and if this doesn't work there are other ways, and if they don't work don't feel too bad about giving up; this is how to spit up in the air if you feel like it, and this is how to move quick so that it doesn't fall on you; this is how to make ends meet; always squeeze bread to make sure it's fresh; but what if the baker won't let me feel the bread?; you mean to say that after all you are really going to be the kind of woman who the baker won't let near the bread?"""
    },
    {
      'title': 'Lesson 3: Change in Pastime',
      'author': 'BBC News Article',
      'unit': 'Unit Three: Pastimes, Page 37',
      'text': """Unit Three: Pastimes
Lesson 3: Change in Pastime
Text (Page 37):

Childhood outdoor pastimes 'in decline'

Traditional childhood pastimes of climbing trees and playing conkers are in decline, according to a survey by the RSPB (Royal Society for the Protection of Birds). It's a charitable organisation registered in England and Wales.

The survey shows that people under 34 recall far fewer such childhood outdoor experiences than people over 55, according to a survey by RSPB.

People were asked which of the twelve childhood outdoor experiences they could remember. The answer included making dens, daisy chains, climbing trees, playing conkers and feeding birds. Four out of five boys climbed trees and the same number of girls made daisy chains. But the survey showed the numbers declining among the newer generations.

Some 15% more of those aged over 55 had these outdoor experiences in their childhood, compared with those between 15-34 years old. Some 92% of the public agreed that experiences of nature were still important to children, and 82% agreed that schools should play a role in providing them to all children.

The survey has highlighted the positive impact of contact with nature on a child's education, health, wellbeing and social skills. At the same time, there has been a decline in these opportunities, with negative consequences for children, families and society—a condition now known as nature deficit disorder.

Mike Clarke, chief executive of the RSPB, will meet parliament members to urge the government to join other organisations in providing children with first-hand experiences of the natural environment. . . "We believe this guidance should include the many positive impacts to children of having contact with nature and learning outside the classroom."

[Adapted from BBC news 6 September 2010]"""
    },
    {
      'title': 'Lesson 5: Pastimes Vary',
      'author': 'Survey Analysis',
      'unit': 'Pages 41-43',
      'text': """Lesson 5: Pastimes Vary
Text (Pages 41-43):

Young people's changing attitude to pastimes

There is change in people's preferences for pastimes. A recent survey shows that during the last twenty years, teenagers have gone through significant changes in choosing their pastimes. The survey results are presented through a graph which shows that there is a steady rise in young people's tendency to watch TV. In 1990, 41% of teenagers liked watching TV which increased to 48% in the next ten years and it further increased to 52% in the next decade. Unfortunately, the picture is grim in terms of young people's attraction to field games and sports. While 50% of youngsters opted for games and sports in the 1990s, the figure was 12% less after a decade at 38%. Unfortunately the falling tendency persisted through the next ten years and by 2010 it came down to 25%. Though the young people have dissociated themselves noticeably from games and sports, there is a sharp and steady rise in their association with online or computer assisted programmes. In 1990 when the users of online or computer for pastimes were only 9%, in 2000 the number nearly doubled and reached 14%, and with a rapid increase in the next ten years it shot up to 23%.

The survey also explains the reasons for this change. It says that television has become a part of everyday life even to the underprivileged section of society. This has resulted in larger number of young people opting for watching TV as one of the most favourite pastimes. The increasing urbanization has reduced the number of open fields. Therefore, there is a fall in selecting games and sports as favourite pastimes, though it's not a good news for the country. And the reason for selecting the computer assisted or online programmes is that computer technology is getting cheaper, easier and more popular every day. Indeed, our young generations are stepping into the e-world."""
    },
    {
      'title': 'Lesson 3: Our Food and Shelter',
      'author': 'Ms Choudhury\'s Class Discussion',
      'unit': 'Unit Five: Problems Around Us, Pages 57-59',
      'text': """Unit Five: Problems Around Us
Lesson 3: Our Food and Shelter
Text (Pages 57-59):

The class comes up with different problems. One group leader says, "The scarcity of food will be a serious problem in the years ahead. It is true that our agriculturists have developed new varieties of rice and its per acre production has definitely increased. But the rate of increase in food production cannot keep pace with the rate of population growth. This is because our land is fixed, i.e. we cannot increase it, while our population is increasing rapidly."

Another group leader comes up with the housing problem in the country, which he says adds much to the food problem. He says, "Families are growing larger in size and at the same time breaking into smaller families. Each smaller family needs a separate house to live in. Also, the arable fields are being divided by these smaller families among themselves. Mills and factories are being set up, which occupy a considerable portion of our land. So while we need more land to grow more food to feed more mouths, our land is shrinking day by day.

"No way," another student argues. "Trees are being cut, hills are being cleared and water bodies are being filled up --- all to meet the needs of too many people."

"Thank you students," Ms Choudhury says. "You're quite right. Let me tell you about this village where I was born and brought up. Things were not like this in the past. I remember as a child, the village was so beautiful! The green paddy fields and yellow mustard fields seemed to be unending. They used to wave and dance in the breeze. There used to be a wood in the northern side of the village. There was a tall tamarind tree in the middle of the wood. Also there was a big banyan tree which looked like a huge green umbrella, with its aerial roots hanging down. I often used to go there with my friends. We would often have picnic there. While the boys would climb the tamarind tree and pick some tamarinds, I and my best friend Rima used to swing from the hanging roots. But now, look, the wood is gone. The beauty of the crop fields is spoiled by the unplanned houses built here and there."""""
    },
    {
      'title': 'Lesson 5: Let\'s Become Skilled Workforce',
      'author': 'Ms Choudhury\'s Class',
      'unit': 'Pages 61-63',
      'text': """Lesson 5: Let's become skilled workforce
Text (Pages 61-63):

"Today there are many jobs where you need English. This is because the world has become smaller. Vast distances are shortened by speedy transports. We can talk to a person thousands of kilometers away on the phone or the Internet. So we can communicate with the whole world easily. English has made this communication easier.

There are many countries in the world with many languages, but to communicate with them, you cannot use all the languages. So you need a common language that you can use with more or less all the people in the world. English is that common language. You can talk to a Chinese toy maker, a French artist, an Arab ambassador or a Korean builder in one language—English.

English, for us in Bangladesh, is all the more important. As we have seen earlier, we are too many people in a small country. So if you learn English, you have the best opportunity to find a good job, both within and outside the country. And that is good news for millions of our unemployed youths."

"But Miss, we learn English for 12 or 14 years, yet we do not find good jobs," says Rumi. She then tells the class about what happened to her brother. "Could you please tell us why?" Rumi asks.

"This is a very important question, Rumi. We should learn how to use English both orally and in writing for doing things as needed in our work, such as communicating with others at personal, social, national and international levels. But unfortunately, at the moment we are learning English mainly for our exams," continues Ms Choudhury. "Remember, English can greatly help you become skilled workers."

"But where and how can we learn such kind of English, Miss?" asks Ratan. Ms Choudhury says, "We can learn English both in and outside the classroom. Besides your textbooks, the radio, television, newspapers, magazines, computers and other supplementary materials will greatly help you. During our classroom activities, we'll see how we can learn English."""""
    },
  ];

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  Future<void> _initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);

    flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });
  }

  Future<void> _playAudio() async {
    await flutterTts.speak(lessons[currentLesson]['text']!);
    setState(() {
      isPlaying = true;
    });
  }

  Future<void> _pauseAudio() async {
    await flutterTts.stop();
    setState(() {
      isPlaying = false;
    });
  }

  Future<void> _stopAudio() async {
    await flutterTts.stop();
    setState(() {
      isPlaying = false;
    });
  }

  void _changeLesson(int index) {
    _stopAudio();
    setState(() {
      currentLesson = index;
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
        title: const Text('English for Today', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.amber.shade700,
        elevation: 4,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Lesson selector
            _buildLessonSelector(),

            // Content area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBookHeader(),
                    const SizedBox(height: 24),
                    _buildStoryCard(),
                  ],
                ),
              ),
            ),

            // Audio controls
            _buildAudioControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonSelector() {
    return Container(
      height: 100,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final isSelected = currentLesson == index;
          return GestureDetector(
            onTap: () => _changeLesson(index),
            child: Container(
              width: 140,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isSelected
                      ? [Colors.amber.shade600, Colors.amber.shade400]
                      : [Colors.grey.shade300, Colors.grey.shade200],
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu_book,
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                    size: 28,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Lesson ${index + 1}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBookHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade600, Colors.amber.shade400],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.menu_book, size: 32, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lessons[currentLesson]['unit']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lessons[currentLesson]['title']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.white, thickness: 1),
          const SizedBox(height: 8),
          Text(
            lessons[currentLesson]['author']!,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryCard() {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          lessons[currentLesson]['text']!,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            height: 1.8,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  Widget _buildAudioControls() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildControlButton(
            icon: Icons.stop,
            label: 'Stop',
            color: Colors.red,
            onPressed: isPlaying ? _stopAudio : null,
          ),
          _buildControlButton(
            icon: isPlaying ? Icons.pause : Icons.play_arrow,
            label: isPlaying ? 'Pause' : 'Play',
            color: Colors.green,
            onPressed: isPlaying ? _pauseAudio : _playAudio,
            isPrimary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback? onPressed,
    bool isPrimary = false,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed == null ? Colors.grey.shade300 : color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: isPrimary ? 40 : 28,
          vertical: isPrimary ? 16 : 12,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: onPressed == null ? 0 : 4,
      ),
      icon: Icon(icon, size: isPrimary ? 28 : 24),
      label: Text(
        label,
        style: TextStyle(
          fontSize: isPrimary ? 18 : 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
