import 'package:flutter/material.dart';

class ChemistryExperimentsPage extends StatelessWidget {
  const ChemistryExperimentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chemistry Experiments'),
        backgroundColor: Colors.blue[800],
      ),
      body: ListView(
        children: [
          _buildExperimentTile(
            context,
            'Sublimation: Observing the change of state (solid to vapor) for substances like camphor, naphthalene, or iodine',
            const SublimationSimulation(),
            Colors.orange,
          ),
          _buildExperimentTile(
            context,
            'Formation of sodium chloride crystals',
            const NaClCrystalsSimulation(),
            Colors.teal,
          ),
          _buildExperimentTile(
            context,
            'Acid-base titration',
            const TitrationSimulation(),
            Colors.purple,
          ),
          _buildExperimentTile(
            context,
            'Testing the effect of hydrochloric acid on blue litmus paper',
            const LitmusTestSimulation(),
            Colors.indigo,
          ),
          _buildExperimentTile(
            context,
            'Preparation and identification of gases (e.g., hydrogen, carbon dioxide)',
            const GasPreparationSimulation(),
            Colors.green,
          ),
          _buildExperimentTile(
            context,
            'Observing color changes and reactions with various chemicals',
            const ColorChangesSimulation(),
            Colors.deepOrange,
          ),
          _buildExperimentTile(
            context,
            'Microbial analysis of water samples',
            const MicrobialWaterSimulation(),
            Colors.brown,
          ),
        ],
      ),
    );
  }

  Widget _buildExperimentTile(BuildContext context, String title, Widget page, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(Icons.science, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        },
      ),
    );
  }
}

class SublimationSimulation extends StatefulWidget {
  const SublimationSimulation({super.key});

  @override
  State<SublimationSimulation> createState() => _SublimationSimulationState();
}

class _SublimationSimulationState extends State<SublimationSimulation> with SingleTickerProviderStateMixin {
  double temperature = 20.0;
  String substance = 'Camphor';
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double getSublimationTemp() {
    switch (substance) {
      case 'Camphor': return 179.0;
      case 'Naphthalene': return 80.0;
      case 'Iodine': return 113.0;
      default: return 100.0;
    }
  }

  String getState() {
    return temperature >= getSublimationTemp() ? 'Subliming to vapor' : 'Solid';
  }

  Color getSubstanceColor() {
    switch (substance) {
      case 'Camphor': return Colors.white;
      case 'Naphthalene': return Colors.white;
      case 'Iodine': return Colors.purple;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSubliming = temperature >= getSublimationTemp();

    if (isSubliming) {
      _animationController.repeat(reverse: true);
    } else {
      _animationController.stop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sublimation Simulation'),
        backgroundColor: Colors.orange[800],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Heating apparatus
                  Container(
                    width: 200,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        // Bunsen burner flame
                        Positioned(
                          bottom: 0,
                          left: 85,
                          child: Container(
                            width: 30.0,
                            height: temperature / 4,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.yellow,
                                  Colors.orange,
                                  Colors.red,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        // Substance container
                        Positioned(
                          top: 30,
                          left: 60,
                          child: Container(
                            width: 80,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Stack(
                              children: [
                                // Solid substance
                                if (!isSubliming)
                                  Center(
                                    child: Container(
                                      width: 50.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                        color: getSubstanceColor(),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                // Vapor animation
                                if (isSubliming)
                                  AnimatedBuilder(
                                    animation: _animationController,
                                    builder: (context, child) {
                                      return Opacity(
                                        opacity: _animationController.value,
                                        child: Center(
                                          child: Container(
                                            width: 60.0 + _animationController.value * 20,
                                            height: 40.0 + _animationController.value * 20,
                                            decoration: BoxDecoration(
                                              color: getSubstanceColor().withOpacity(0.3),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$substance at ${temperature.toStringAsFixed(1)}°C',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    getState(),
                    style: TextStyle(
                      fontSize: 16,
                      color: isSubliming ? Colors.green : Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Sublimation Point: ${getSublimationTemp()}°C',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                DropdownButton<String>(
                  value: substance,
                  items: ['Camphor', 'Naphthalene', 'Iodine'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => substance = value!),
                ),
                const SizedBox(height: 20),
                Slider(
                  value: temperature,
                  min: 0.0,
                  max: 200.0,
                  divisions: 200,
                  label: '${temperature.toStringAsFixed(1)}°C',
                  onChanged: (value) => setState(() => temperature = value),
                ),
                Text(
                  'Temperature: ${temperature.toStringAsFixed(1)}°C',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NaClCrystalsSimulation extends StatefulWidget {
  const NaClCrystalsSimulation({super.key});

  @override
  State<NaClCrystalsSimulation> createState() => _NaClCrystalsSimulationState();
}

class _NaClCrystalsSimulationState extends State<NaClCrystalsSimulation> {
  double evaporationLevel = 0.0;

  @override
  Widget build(BuildContext context) {
    int crystalCount = (evaporationLevel / 10).floor();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formation of NaCl Crystals'),
        backgroundColor: Colors.teal[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Beaker
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Solution level
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: 200 * (1 - evaporationLevel / 100),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[50]!.withOpacity(0.7),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                            ),
                          ),
                        ),
                        // Crystals at bottom
                        if (crystalCount > 0)
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                crystalCount.clamp(0, 8),
                                    (index) => Container(
                                  width: 15.0,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    evaporationLevel >= 50 ? 'Crystals Formed!' : 'Solution Evaporating...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: evaporationLevel >= 50 ? Colors.green : Colors.blue,
                    ),
                  ),
                  Text(
                    'Evaporation: ${evaporationLevel.toStringAsFixed(1)}%',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Slider(
              value: evaporationLevel,
              min: 0.0,
              max: 100.0,
              divisions: 100,
              label: '${evaporationLevel.toStringAsFixed(1)}%',
              onChanged: (value) => setState(() => evaporationLevel = value),
            ),
          ),
        ],
      ),
    );
  }
}

class TitrationSimulation extends StatefulWidget {
  const TitrationSimulation({super.key});

  @override
  State<TitrationSimulation> createState() => _TitrationSimulationState();
}

class _TitrationSimulationState extends State<TitrationSimulation> {
  double volumeAdded = 0.0;
  double equivalencePoint = 25.0;

  String getPH() {
    if (volumeAdded < equivalencePoint - 2) return 'Acidic';
    if (volumeAdded > equivalencePoint + 2) return 'Basic';
    return 'Neutral';
  }

  Color getColor() {
    if (getPH() == 'Acidic') return Colors.red.withOpacity(0.7);
    if (getPH() == 'Neutral') return Colors.green.withOpacity(0.7);
    return Colors.blue.withOpacity(0.7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acid-Base Titration'),
        backgroundColor: Colors.purple[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Burette and flask setup
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Burette
                      Column(
                        children: [
                          Container(
                            width: 60.0,
                            height: 200.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Stack(
                              children: [
                                // Liquid in burette
                                Positioned(
                                  top: 0,
                                  left: 5,
                                  right: 5,
                                  height: (volumeAdded / 50) * 180,
                                  child: Container(
                                    color: Colors.blue[200],
                                  ),
                                ),
                                // Scale markings
                                for (int i = 0; i <= 50; i += 5)
                                  Positioned(
                                    top: (i / 50) * 180,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 1.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Text('${volumeAdded.toStringAsFixed(1)} mL'),
                        ],
                      ),
                      // Conical flask
                      Container(
                        width: 120.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          color: getColor(),
                          border: Border.all(color: Colors.grey),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(60),
                            bottomRight: Radius.circular(60),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            getPH(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // pH indicator
                  Container(
                    width: 300.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.orange,
                          Colors.yellow,
                          Colors.green,
                          Colors.blue,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: (volumeAdded / 50) * 300 - 10,
                          child: Container(
                            width: 20.0,
                            height: 40.0,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                '↓',
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('pH Scale'),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Slider(
                  value: volumeAdded,
                  min: 0.0,
                  max: 50.0,
                  divisions: 100,
                  label: '${volumeAdded.toStringAsFixed(1)} mL',
                  onChanged: (value) => setState(() => volumeAdded = value),
                ),
                Text(
                  'Status: ${getPH()} (Equivalence point at $equivalencePoint mL)',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LitmusTestSimulation extends StatefulWidget {
  const LitmusTestSimulation({super.key});

  @override
  State<LitmusTestSimulation> createState() => _LitmusTestSimulationState();
}

class _LitmusTestSimulationState extends State<LitmusTestSimulation> {
  bool appliedAcid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Litmus Test with HCl'),
        backgroundColor: Colors.indigo[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Dropper and litmus paper
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Litmus paper
                      Container(
                        width: 100.0,
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: appliedAcid ? Colors.red : Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            appliedAcid ? 'RED\n(ACIDIC)' : 'BLUE\n(BASIC)',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      // Dropper
                      if (!appliedAcid)
                        Positioned(
                          top: 50,
                          child: Column(
                            children: [
                              Container(
                                width: 40.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'HCl',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                              Container(
                                width: 10.0,
                                height: 30.0,
                                color: Colors.grey[400],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    appliedAcid
                        ? 'Hydrochloric acid turned blue litmus paper red!'
                        : 'Blue litmus paper ready for testing',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: SwitchListTile(
              title: const Text(
                'Apply Hydrochloric Acid',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              value: appliedAcid,
              onChanged: (value) => setState(() => appliedAcid = value),
            ),
          ),
        ],
      ),
    );
  }
}

class GasPreparationSimulation extends StatefulWidget {
  const GasPreparationSimulation({super.key});

  @override
  State<GasPreparationSimulation> createState() => _GasPreparationSimulationState();
}

class _GasPreparationSimulationState extends State<GasPreparationSimulation> with SingleTickerProviderStateMixin {
  String gas = 'Hydrogen';
  late AnimationController _bubbleController;

  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    super.dispose();
  }

  String getTestDescription() {
    return gas == 'Hydrogen'
        ? 'Pop Test: Hydrogen gas makes a popping sound when ignited'
        : 'Limewater Test: CO₂ turns limewater milky';
  }

  Color getGasColor() {
    return gas == 'Hydrogen' ? Colors.blue[100]! : Colors.grey[200]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gas Preparation and Identification'),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Gas generation apparatus
                  Container(
                    width: 300.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        // Flask with reaction
                        Positioned(
                          left: 50,
                          top: 50,
                          child: Container(
                            width: 80.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: getGasColor(),
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: AnimatedBuilder(
                              animation: _bubbleController,
                              builder: (context, child) {
                                return Stack(
                                  children: [
                                    // Bubbles
                                    for (int i = 0; i < 5; i++)
                                      Positioned(
                                        left: 20.0 + i * 10.0,
                                        bottom: 20.0 + (_bubbleController.value * 60),
                                        child: Container(
                                          width: 8.0 - i * 1.0, // Fixed: using double instead of int
                                          height: 8.0 - i * 1.0, // Fixed: using double instead of int
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.8),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        // Delivery tube
                        Positioned(
                          left: 130,
                          top: 80,
                          child: Container(
                            width: 100.0,
                            height: 4.0,
                            color: Colors.grey,
                          ),
                        ),
                        // Gas collection
                        Positioned(
                          right: 50,
                          top: 30,
                          child: Container(
                            width: 60.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              border: Border.all(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Gas: $gas',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.yellow[100],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.orange),
                    ),
                    child: Text(
                      getTestDescription(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Test visualization
                  if (gas == 'Hydrogen')
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '💥',
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    )
                  else
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          '🥛',
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: DropdownButton<String>(
              value: gas,
              items: ['Hydrogen', 'Carbon Dioxide'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 16)),
                );
              }).toList(),
              onChanged: (value) => setState(() => gas = value!),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorChangesSimulation extends StatefulWidget {
  const ColorChangesSimulation({super.key});

  @override
  State<ColorChangesSimulation> createState() => _ColorChangesSimulationState();
}

class _ColorChangesSimulationState extends State<ColorChangesSimulation> {
  String reaction = 'Copper sulfate + iron';

  Map<String, Map<String, dynamic>> reactions = {
    'Copper sulfate + iron': {
      'color': Colors.brown,
      'description': 'Iron displaces copper from copper sulfate solution',
      'before': Colors.blue,
      'equation': 'Fe + CuSO₄ → FeSO₄ + Cu',
    },
    'Potassium permanganate + oxalic acid': {
      'color': Colors.purple,
      'description': 'Oxalic acid reduces purple permanganate to colorless',
      'before': Colors.purple,
      'equation': '2KMnO₄ + 5H₂C₂O₄ → K₂O + 2MnO + 8CO₂ + 5H₂O',
    },
    'Phenolphthalein in base': {
      'color': Colors.pink,
      'description': 'Phenolphthalein turns pink in basic solution',
      'before': Colors.white,
      'equation': 'Colorless → Pink (in base)',
    },
  };

  @override
  Widget build(BuildContext context) {
    var currentReaction = reactions[reaction]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Changes in Reactions'),
        backgroundColor: Colors.deepOrange[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Reaction visualization
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Before reaction
                      Column(
                        children: [
                          const Text(
                            'Before',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: currentReaction['before'] as Color,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(child: Text('Reactants')),
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward, size: 40),
                      // After reaction
                      Column(
                        children: [
                          const Text(
                            'After',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: currentReaction['color'] as Color,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(child: Text('Products')),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Chemical equation
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Text(
                      currentReaction['equation'] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Description
                  Text(
                    currentReaction['description'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: DropdownButton<String>(
              value: reaction,
              items: reactions.keys.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 16)),
                );
              }).toList(),
              onChanged: (value) => setState(() => reaction = value!),
            ),
          ),
        ],
      ),
    );
  }
}

class MicrobialWaterSimulation extends StatefulWidget {
  const MicrobialWaterSimulation({super.key});

  @override
  State<MicrobialWaterSimulation> createState() => _MicrobialWaterSimulationState();
}

class _MicrobialWaterSimulationState extends State<MicrobialWaterSimulation> with SingleTickerProviderStateMixin {
  double contaminationLevel = 0.0;
  late AnimationController _microbeController;

  @override
  void initState() {
    super.initState();
    _microbeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _microbeController.dispose();
    super.dispose();
  }

  String getAnalysis() {
    if (contaminationLevel < 25) return 'Excellent - Low microbial content';
    if (contaminationLevel < 50) return 'Good - Moderate microbial content';
    if (contaminationLevel < 75) return 'Poor - High microbial content';
    return 'Dangerous - Very high microbial content';
  }

  Color getWaterColor() {
    if (contaminationLevel < 25) return Colors.blue.withOpacity(0.3);
    if (contaminationLevel < 50) return Colors.blue.withOpacity(0.5);
    if (contaminationLevel < 75) return Colors.orange.withOpacity(0.6);
    return Colors.brown.withOpacity(0.7);
  }

  @override
  Widget build(BuildContext context) {
    int microbeCount = (contaminationLevel / 10).floor();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Microbial Analysis of Water'),
        backgroundColor: Colors.brown[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Water sample with microbes
                  Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: getWaterColor(),
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: AnimatedBuilder(
                      animation: _microbeController,
                      builder: (context, child) {
                        return Stack(
                          children: List.generate(
                            microbeCount.clamp(0, 20),
                                (index) {
                              double x = 50.0 + 40.0 * _microbeController.value * (index % 3);
                              double y = 50.0 + 40.0 * _microbeController.value * (index % 2);
                              return Positioned(
                                left: x % 150,
                                top: y % 150,
                                child: Container(
                                  width: 8.0 + (index % 3) * 1.0, // Fixed: using double
                                  height: 8.0 + (index % 3) * 1.0, // Fixed: using double
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.8),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Analysis result
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _getAnalysisColor(),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text(
                          getAnalysis(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Contamination Level: ${contaminationLevel.toStringAsFixed(1)}%',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Safety indicator
                  Container(
                    width: 300.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.green,
                          Colors.yellow,
                          Colors.orange,
                          Colors.red,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: contaminationLevel * 3 - 10,
                          child: Container(
                            width: 20.0,
                            height: 30.0,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                '↑',
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Slider(
              value: contaminationLevel,
              min: 0.0,
              max: 100.0,
              divisions: 100,
              label: '${contaminationLevel.toStringAsFixed(1)}%',
              onChanged: (value) => setState(() => contaminationLevel = value),
            ),
          ),
        ],
      ),
    );
  }

  Color _getAnalysisColor() {
    if (contaminationLevel < 25) return Colors.green;
    if (contaminationLevel < 50) return Colors.blue;
    if (contaminationLevel < 75) return Colors.orange;
    return Colors.red;
  }
}