// elementary_games_hub.dart
import 'package:flutter/material.dart';
import 'seedling_sums_game.dart';
import 'letter_lagoon_game.dart';
import 'wall_workshop_game.dart';
import 'sentence_shipyard_game.dart';
import 'fraction_furnace_game.dart';
import 'grammar_glacier_game.dart';
import 'decipher_dungeon_game.dart';
import 'synonym_antonym_game.dart';
import 'orbit_operations_game.dart';
import 'comet_command_game.dart';

class ElementaryGamesHub extends StatelessWidget {
  const ElementaryGamesHub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎮 Elementary Games'),
        backgroundColor: Colors.deepPurple.shade700,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade50, Colors.pink.shade50],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildGradeSection(
              context,
              'Grade 1: Explorer\'s Grove 🌳',
              [
                _GameInfo(
                  title: '🌰 Seedling Sums',
                  subtitle: 'Addition & Subtraction with nuts!',
                  page: const SeedlingSumsGame(),
                  color: Colors.green,
                ),
                _GameInfo(
                  title: '🎣 Letter Lagoon',
                  subtitle: 'Fish for the right letters!',
                  page: const LetterLagoonGame(),
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildGradeSection(
              context,
              'Grade 2: Builder\'s Bay 🏗️',
              [
                _GameInfo(
                  title: '🏰 Wall Workshop',
                  subtitle: 'Build walls with math!',
                  page: const WallWorkshopGame(),
                  color: Colors.brown,
                ),
                _GameInfo(
                  title: '⛵ Sentence Shipyard',
                  subtitle: 'Build perfect sentences!',
                  page: const SentenceShipyardGame(),
                  color: Colors.lightBlue,
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildGradeSection(
              context,
              'Grade 3: Inventor\'s Icepeak ❄️',
              [
                _GameInfo(
                  title: '🧪 Fraction Furnace',
                  subtitle: 'Mix fraction potions!',
                  page: const FractionFurnaceGame(),
                  color: Colors.purple,
                ),
                _GameInfo(
                  title: '❄️ Grammar Glacier',
                  subtitle: 'Collect word crystals!',
                  page: const GrammarGlacierGame(),
                  color: Colors.cyan,
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildGradeSection(
              context,
              'Grade 4: Detective\'s Desert 🏜️',
              [
                _GameInfo(
                  title: '🏛️ Decipher Dungeon',
                  subtitle: 'Unlock ancient doors!',
                  page: const DecipherDungeonGame(),
                  color: Colors.deepPurple,
                ),
                _GameInfo(
                  title: '🏜️ Word Oasis',
                  subtitle: 'Find synonyms & antonyms!',
                  page: const SynonymAntonymGame(),
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildGradeSection(
              context,
              'Grade 5: Astronaut Academy 🚀',
              [
                _GameInfo(
                  title: '🚀 Orbit Operations',
                  subtitle: 'Compare decimals in space!',
                  page: const OrbitOperationsGame(),
                  color: Colors.indigo,
                ),
                _GameInfo(
                  title: '☄️ Comet Command',
                  subtitle: 'Build complex sentences!',
                  page: const CometCommandGame(),
                  color: Colors.deepPurple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeSection(
      BuildContext context,
      String title,
      List<_GameInfo> games,
      ) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [games[0].color.shade700, games[0].color.shade500],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                const Icon(Icons.school, color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...games.map((game) => ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: game.color.shade100,
                shape: BoxShape.circle,
              ),
              child: Text(
                game.title.split(' ')[0],
                style: const TextStyle(fontSize: 24),
              ),
            ),
            title: Text(
              game.title.split(' ').skip(1).join(' '),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(game.subtitle),
            trailing: Icon(Icons.arrow_forward_ios, color: game.color),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => game.page),
            ),
          )),
        ],
      ),
    );
  }
}

class _GameInfo {
  final String title;
  final String subtitle;
  final Widget page;
  final MaterialColor color;

  _GameInfo({
    required this.title,
    required this.subtitle,
    required this.page,
    required this.color,
  });
}
