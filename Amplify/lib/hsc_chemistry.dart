import 'package:flutter/material.dart';

void main() {
  runApp(const ChemistryApp());
}

class ChemistryApp extends StatelessWidget {
  const ChemistryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HSC Chemistry Practicals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HscChemistryPage(),
    );
  }
}

class HscChemistryPage extends StatelessWidget {
  const HscChemistryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chemistry Practicals'),
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[50]!, Colors.white],
          ),
        ),
        child: ListView(
          children: [
            _buildSectionHeader('2.1 Cation Tests'),
            _buildExperimentTile(
              context,
              'Ammonium Ion (NH₄⁺) Test',
              const AmmoniumIonTestSimulation(),
              Colors.orange,
              Icons.cloud,
            ),
            _buildExperimentTile(
              context,
              'Ferrous Ion (Fe²⁺) Test',
              const FerrousIonTestSimulation(),
              Colors.green,
              Icons.color_lens,
            ),
            _buildExperimentTile(
              context,
              'Ferric Ion (Fe³⁺) Test',
              const FerricIonTestSimulation(),
              Colors.red,
              Icons.color_lens,
            ),
            _buildExperimentTile(
              context,
              'Copper(II) Ion (Cu²⁺) Test',
              const CopperIonTestSimulation(),
              Colors.blue,
              Icons.color_lens,
            ),
            _buildExperimentTile(
              context,
              'Zinc Ion (Zn²⁺) Test',
              const ZincIonTestSimulation(),
              Colors.grey,
              Icons.opacity,
            ),
            _buildExperimentTile(
              context,
              'Lead Ion (Pb²⁺) Test',
              const LeadIonTestSimulation(),
              Colors.yellow,
              Icons.auto_awesome,
            ),

            _buildSectionHeader('2.1 Anion Tests'),
            _buildExperimentTile(
              context,
              'Carbonate (CO₃²⁻) Test',
              const CarbonateTestSimulation(),
              Colors.teal,
              Icons.bubble_chart,
            ),
            _buildExperimentTile(
              context,
              'Sulfate (SO₄²⁻) Test',
              const SulfateTestSimulation(),
              Colors.purple,
              Icons.filter_center_focus,
            ),
            _buildExperimentTile(
              context,
              'Chloride (Cl⁻) Test',
              const ChlorideTestSimulation(),
              Colors.indigo,
              Icons.opacity,
            ),
            _buildExperimentTile(
              context,
              'Acetate (CH₃COO⁻) Test',
              const AcetateTestSimulation(),
              Colors.brown,
              Icons.waves,
            ),
            _buildExperimentTile(
              context,
              'Nitrate (NO₃⁻) Test - Brown Ring',
              const NitrateTestSimulation(),
              Colors.deepOrange,
              Icons.circle,
            ),

            _buildSectionHeader('2.2 Preparation of Solutions'),
            _buildExperimentTile(
              context,
              'Preparing 0.1M H₂SO₄',
              const StandardSolutionSimulation(),
              Colors.cyan,
              Icons.science,
            ),

            _buildSectionHeader('2.3 Titration Experiments'),
            _buildExperimentTile(
              context,
              'Acid-Base Titration (HCl vs NaOH)',
              const AcidBaseTitrationSimulation(),
              Colors.pink,
              Icons.linear_scale,
            ),
            _buildExperimentTile(
              context,
              'Redox Titration (KMnO₄ vs Oxalic Acid)',
              const RedoxTitrationSimulation(),
              Colors.deepPurple,
              Icons.linear_scale,
            ),

            _buildSectionHeader('2.4 Heat & Crystallization'),
            _buildExperimentTile(
              context,
              'Heat of Neutralization (HCl + NaOH)',
              const HeatNeutralizationSimulation(),
              Colors.amber,
              Icons.whatshot,
            ),
            _buildExperimentTile(
              context,
              'Preparation of Copper Sulfate Crystals',
              const CopperSulfateCrystalsSimulation(),
              Colors.blueAccent,
              Icons.diamond,
            ),
            _buildExperimentTile(
              context,
              'Preparation of Sodium Chloride Crystals',
              const SodiumChlorideCrystalsSimulation(),
              Colors.grey,
              Icons.diamond,
            ),

            _buildSectionHeader('2.5 Rate of Reaction'),
            _buildExperimentTile(
              context,
              'Rate of Reaction: Sodium Thiosulfate + HCl',
              const ThiosulfateRateSimulation(),
              Colors.lime,
              Icons.timelapse,
            ),
            _buildExperimentTile(
              context,
              'Decomposition of Hydrogen Peroxide',
              const PeroxideDecompositionSimulation(),
              Colors.lightGreen,
              Icons.speed,
            ),

            _buildSectionHeader('2.6 Organic Functional Groups'),
            _buildExperimentTile(
              context,
              'Alcohol Test with Sodium',
              const AlcoholTestSimulation(),
              Colors.orangeAccent,
              Icons.local_fire_department,
            ),
            _buildExperimentTile(
              context,
              'Aldehyde - Tollen\'s Test',
              const AldehydeTestSimulation(),
              Colors.grey,
              Icons.auto_awesome,
            ),
            _buildExperimentTile(
              context,
              'Ketone - Iodoform Test',
              const KetoneTestSimulation(),
              Colors.yellowAccent,
              Icons.emoji_objects,
            ),
            _buildExperimentTile(
              context,
              'Carboxylic Acid - NaHCO₃ Test',
              const CarboxylicAcidTestSimulation(),
              Colors.redAccent,
              Icons.bubble_chart,
            ),

            _buildSectionHeader('2.7 Advanced Techniques'),
            _buildExperimentTile(
              context,
              'Estimation of Sodium Carbonate',
              const SodiumCarbonateEstimationSimulation(),
              Colors.tealAccent,
              Icons.calculate,
            ),
            _buildExperimentTile(
              context,
              'Distillation and Purification',
              const DistillationSimulation(),
              Colors.blueGrey,
              Icons.thermostat,
            ),
            _buildExperimentTile(
              context,
              'Melting & Boiling Points',
              const MeltingBoilingSimulation(),
              Colors.deepOrangeAccent,
              Icons.thermostat_auto,
            ),

            _buildSectionHeader('2.8 Precipitation'),
            _buildExperimentTile(
              context,
              'Precipitation of Silver Chloride',
              const SilverChloridePrecipitationSimulation(),
              Colors.white,
              Icons.filter_alt,
            ),
            _buildExperimentTile(
              context,
              'Precipitation of Calcium Carbonate',
              const CalciumCarbonatePrecipitationSimulation(),
              Colors.lightBlue,
              Icons.filter_alt,
            ),

            _buildSectionHeader('2.9 Safety'),
            _buildExperimentTile(
              context,
              'Safety Protocol Demonstration',
              const SafetyProtocolSimulation(),
              Colors.red,
              Icons.security,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue[800],
        ),
      ),
    );
  }

  Widget _buildExperimentTile(BuildContext context, String title, Widget page, Color color, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.3), color.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blue),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        },
      ),
    );
  }
}

// Enhanced Ammonium Ion Test
class AmmoniumIonTestSimulation extends StatefulWidget {
  const AmmoniumIonTestSimulation({super.key});

  @override
  State<AmmoniumIonTestSimulation> createState() => _AmmoniumIonTestSimulationState();
}

class _AmmoniumIonTestSimulationState extends State<AmmoniumIonTestSimulation>
    with SingleTickerProviderStateMixin {
  bool addedNaOH = false;
  bool warmed = false;
  late AnimationController _animationController;
  late Animation<double> _bubbleAnimation;
  late Animation<Color?> _solutionColorAnimation;
  late Animation<Color?> _litmusColorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _bubbleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _solutionColorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.blue[50],
    ).animate(_animationController);

    _litmusColorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.blue,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (warmed && addedNaOH) {
      _animationController.repeat(reverse: true);
    } else {
      _animationController.stop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ammonium Ion (NH₄⁺) Test'),
        backgroundColor: Colors.orange[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 120,
                              height: 200,
                              decoration: BoxDecoration(
                                color: _solutionColorAnimation.value,
                                border: Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [
                                    _solutionColorAnimation.value ?? Colors.transparent,
                                    _solutionColorAnimation.value?.withOpacity(0.7) ?? Colors.transparent,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            if (warmed && addedNaOH)
                              ...List.generate(5, (index) {
                                return Positioned(
                                  bottom: 30 + index * 15,
                                  left: 40 + index * 8,
                                  child: Transform.translate(
                                    offset: Offset(0, -100 * _bubbleAnimation.value),
                                    child: Opacity(
                                      opacity: 1.0 - (index * 0.2),
                                      child: Container(
                                        width: 8 + index * 2,
                                        height: 8 + index * 2,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 30),

                    AnimatedBuilder(
                      animation: _litmusColorAnimation,
                      builder: (context, child) {
                        return Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _litmusColorAnimation.value,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Litmus',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            (warmed && addedNaOH)
                                ? '✅ Ammonia gas evolves, turns litmus blue'
                                : '⬇️ Add dilute NaOH and warm gently',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'NH₄Cl + NaOH → NH₃↑ + NaCl + H₂O',
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: Colors.blueGrey,
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
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildControlSwitch(
                    'Add NaOH Solution',
                    addedNaOH,
                        (value) => setState(() => addedNaOH = value),
                    Colors.orange,
                  ),
                  const SizedBox(height: 10),
                  _buildControlSwitch(
                    'Warm Gently',
                    warmed,
                    addedNaOH ? (value) => setState(() => warmed = value) : null,
                    Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Ferrous Ion Test
class FerrousIonTestSimulation extends StatefulWidget {
  const FerrousIonTestSimulation({super.key});

  @override
  State<FerrousIonTestSimulation> createState() => _FerrousIonTestSimulationState();
}

class _FerrousIonTestSimulationState extends State<FerrousIonTestSimulation>
    with SingleTickerProviderStateMixin {
  bool addedNaOH = false;
  bool oxidized = false;
  late AnimationController _colorController;
  late Animation<Color?> _precipitateColor;

  @override
  void initState() {
    super.initState();
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _precipitateColor = ColorTween(
      begin: Colors.transparent,
      end: Colors.green,
    ).animate(_colorController);
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (addedNaOH && !oxidized) {
      _colorController.forward();
    } else if (oxidized) {
      _colorController.animateTo(1.0, duration: const Duration(seconds: 1));
    } else {
      _colorController.reverse();
    }

    Color currentColor = oxidized ? Colors.brown : _precipitateColor.value ?? Colors.transparent;
    String description = addedNaOH
        ? (oxidized ? 'Brown ppt of Fe(OH)₃ upon oxidation' : 'Green ppt of Fe(OH)₂')
        : 'Add NaOH';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ferrous Ion (Fe²⁺) Test'),
        backgroundColor: Colors.green[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [Colors.transparent, currentColor.withOpacity(0.1)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        if (addedNaOH)
                          Positioned(
                            bottom: 20,
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: 80,
                              height: oxidized ? 60 : 40,
                              decoration: BoxDecoration(
                                color: currentColor.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: currentColor.withOpacity(0.5),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'FeSO₄ + 2NaOH → Fe(OH)₂ + Na₂SO₄\n4Fe(OH)₂ + O₂ + 2H₂O → 4Fe(OH)₃',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildControlSwitch(
                    'Add NaOH Solution',
                    addedNaOH,
                        (value) => setState(() => addedNaOH = value),
                    Colors.green,
                  ),
                  const SizedBox(height: 10),
                  _buildControlSwitch(
                    'Expose to Air (Oxidize)',
                    oxidized,
                    addedNaOH ? (value) => setState(() => oxidized = value) : null,
                    Colors.brown,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Ferric Ion Test
class FerricIonTestSimulation extends StatefulWidget {
  const FerricIonTestSimulation({super.key});

  @override
  State<FerricIonTestSimulation> createState() => _FerricIonTestSimulationState();
}

class _FerricIonTestSimulationState extends State<FerricIonTestSimulation>
    with SingleTickerProviderStateMixin {
  bool addedNH4OH = false;
  late AnimationController _colorController;
  late Animation<Color?> _precipitateColor;

  @override
  void initState() {
    super.initState();
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _precipitateColor = ColorTween(
      begin: Colors.transparent,
      end: Colors.brown[800],
    ).animate(_colorController);
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (addedNH4OH) {
      _colorController.forward();
    } else {
      _colorController.reverse();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ferric Ion (Fe³⁺) Test'),
        backgroundColor: Colors.red[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _colorController,
                      builder: (context, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 120,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              child: Container(
                                width: 80,
                                height: 40 + (_colorController.value * 20),
                                decoration: BoxDecoration(
                                  color: _precipitateColor.value?.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _precipitateColor.value?.withOpacity(0.5) ?? Colors.transparent,
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            addedNH4OH ? '✅ Reddish-brown ppt of Fe(OH)₃' : '⬇️ Add NH₄OH',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'FeCl₃ + 3NH₄OH → Fe(OH)₃ + 3NH₄Cl',
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: _buildControlSwitch(
                'Add NH₄OH Solution',
                addedNH4OH,
                    (value) => setState(() => addedNH4OH = value),
                Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Copper Ion Test
class CopperIonTestSimulation extends StatefulWidget {
  const CopperIonTestSimulation({super.key});

  @override
  State<CopperIonTestSimulation> createState() => _CopperIonTestSimulationState();
}

class _CopperIonTestSimulationState extends State<CopperIonTestSimulation>
    with SingleTickerProviderStateMixin {
  bool addedNaOH = false;
  bool addedExcessNH3 = false;
  late AnimationController _colorController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _colorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.blue[300],
    ).animate(_colorController);
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Colors.transparent;
    String description = 'Add NaOH';

    if (addedNaOH) {
      color = addedExcessNH3 ? Colors.blue[900]! : _colorAnimation.value ?? Colors.blue[300]!;
      description = addedExcessNH3 ? 'Deep blue solution [Cu(NH₃)₄]²⁺' : 'Blue ppt of Cu(OH)₂';

      if (addedExcessNH3) {
        _colorController.forward();
      } else {
        _colorController.animateTo(0.5);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Copper(II) Ion (Cu²⁺) Test'),
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      width: 120,
                      height: 200,
                      decoration: BoxDecoration(
                        color: color.withOpacity(addedExcessNH3 ? 0.9 : 0.7),
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: addedNaOH && !addedExcessNH3
                          ? Center(
                        child: Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )
                          : null,
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'CuSO₄ + 2NaOH → Cu(OH)₂ + Na₂SO₄\nCu(OH)₂ + 4NH₃ → [Cu(NH₃)₄]²⁺ + 2H₂O',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildControlSwitch(
                    'Add NaOH Solution',
                    addedNaOH,
                        (value) => setState(() => addedNaOH = value),
                    Colors.blue,
                  ),
                  const SizedBox(height: 10),
                  _buildControlSwitch(
                    'Add Excess NH₃',
                    addedExcessNH3,
                    addedNaOH ? (value) => setState(() => addedExcessNH3 = value) : null,
                    Colors.blue[900]!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Zinc Ion Test
class ZincIonTestSimulation extends StatefulWidget {
  const ZincIonTestSimulation({super.key});

  @override
  State<ZincIonTestSimulation> createState() => _ZincIonTestSimulationState();
}

class _ZincIonTestSimulationState extends State<ZincIonTestSimulation>
    with SingleTickerProviderStateMixin {
  bool addedNaOH = false;
  bool addedExcessNaOH = false;
  late AnimationController _pptController;
  late Animation<double> _pptHeight;

  @override
  void initState() {
    super.initState();
    _pptController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _pptHeight = Tween<double>(begin: 0, end: 40).animate(_pptController);
  }

  @override
  void dispose() {
    _pptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (addedNaOH && !addedExcessNaOH) {
      _pptController.forward();
    } else {
      _pptController.reverse();
    }

    String description = 'Add NaOH';
    if (addedNaOH) {
      description = addedExcessNaOH ? 'Ppt dissolves to form Na₂[ZnO₂]' : 'White ppt of Zn(OH)₂';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Zinc Ion (Zn²⁺) Test'),
        backgroundColor: Colors.grey[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        if (addedNaOH && !addedExcessNaOH)
                          Positioned(
                            bottom: 20,
                            child: AnimatedBuilder(
                              animation: _pptHeight,
                              builder: (context, child) {
                                return Container(
                                  width: 80,
                                  height: _pptHeight.value,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'ZnSO₄ + 2NaOH → Zn(OH)₂ + Na₂SO₄\nZn(OH)₂ + 2NaOH → Na₂[ZnO₂] + 2H₂O',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildControlSwitch(
                    'Add NaOH Solution',
                    addedNaOH,
                        (value) => setState(() => addedNaOH = value),
                    Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  _buildControlSwitch(
                    'Add Excess NaOH',
                    addedExcessNaOH,
                    addedNaOH ? (value) => setState(() => addedExcessNaOH = value) : null,
                    Colors.grey[600]!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Lead Ion Test
class LeadIonTestSimulation extends StatefulWidget {
  const LeadIonTestSimulation({super.key});

  @override
  State<LeadIonTestSimulation> createState() => _LeadIonTestSimulationState();
}

class _LeadIonTestSimulationState extends State<LeadIonTestSimulation>
    with SingleTickerProviderStateMixin {
  bool addedKI = false;
  bool heatedAndCooled = false;
  late AnimationController _crystalController;
  late Animation<double> _crystalAnimation;

  @override
  void initState() {
    super.initState();
    _crystalController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _crystalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color pptColor = addedKI ? Colors.yellow : Colors.transparent;
    String description = addedKI ? (heatedAndCooled ? 'Yellow crystals on cooling' : 'Yellow ppt of PbI₂') : 'Add KI';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lead Ion (Pb²⁺) Test'),
        backgroundColor: Colors.yellow[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.yellow[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        if (addedKI)
                          Positioned(
                            bottom: 20,
                            child: Container(
                              width: 80,
                              height: 40,
                              decoration: BoxDecoration(
                                color: pptColor.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: pptColor.withOpacity(0.5),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: heatedAndCooled
                                  ? AnimatedBuilder(
                                animation: _crystalController,
                                builder: (context, child) {
                                  return Center(
                                    child: Icon(
                                      Icons.diamond,
                                      color: Colors.orange[800],
                                      size: 24 + _crystalController.value * 8,
                                    ),
                                  );
                                },
                              )
                                  : null,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Pb(NO₃)₂ + 2KI → PbI₂ + 2KNO₃',
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildControlSwitch(
                    'Add KI Solution',
                    addedKI,
                        (value) => setState(() => addedKI = value),
                    Colors.yellow,
                  ),
                  const SizedBox(height: 10),
                  _buildControlSwitch(
                    'Heat and Cool',
                    heatedAndCooled,
                    addedKI ? (value) => setState(() => heatedAndCooled = value) : null,
                    Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Carbonate Test
class CarbonateTestSimulation extends StatefulWidget {
  const CarbonateTestSimulation({super.key});

  @override
  State<CarbonateTestSimulation> createState() => _CarbonateTestSimulationState();
}

class _CarbonateTestSimulationState extends State<CarbonateTestSimulation>
    with SingleTickerProviderStateMixin {
  bool addedHCl = false;
  late AnimationController _bubbleController;
  late Animation<double> _bubbleAnimation;
  late Animation<Color?> _limewaterColor;

  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _bubbleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _bubbleController, curve: Curves.easeInOut),
    );

    _limewaterColor = ColorTween(
      begin: Colors.transparent,
      end: Colors.white,
    ).animate(_bubbleController);
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (addedHCl) {
      _bubbleController.repeat(reverse: true);
    } else {
      _bubbleController.stop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carbonate (CO₃²⁻) Test'),
        backgroundColor: Colors.teal[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Reaction vessel
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            if (addedHCl)
                              ...List.generate(3, (index) {
                                return Positioned(
                                  bottom: 20 + index * 15,
                                  left: 30 + index * 10,
                                  child: AnimatedBuilder(
                                    animation: _bubbleAnimation,
                                    builder: (context, child) {
                                      return Transform.translate(
                                        offset: Offset(0, -80 * _bubbleAnimation.value),
                                        child: Container(
                                          width: 10 + index * 3,
                                          height: 10 + index * 3,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }),
                          ],
                        ),

                        // Limewater
                        AnimatedBuilder(
                          animation: _limewaterColor,
                          builder: (context, child) {
                            return Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: _limewaterColor.value,
                                border: Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: const Center(
                                child: Text(
                                  'Limewater',
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            addedHCl ? '✅ Effervescence; CO₂ turns limewater milky' : '⬇️ Add HCl',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Na₂CO₃ + 2HCl → 2NaCl + CO₂↑ + H₂O',
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: _buildControlSwitch(
                'Add HCl',
                addedHCl,
                    (value) => setState(() => addedHCl = value),
                Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Sulfate Test
class SulfateTestSimulation extends StatefulWidget {
  const SulfateTestSimulation({super.key});

  @override
  State<SulfateTestSimulation> createState() => _SulfateTestSimulationState();
}

class _SulfateTestSimulationState extends State<SulfateTestSimulation>
    with SingleTickerProviderStateMixin {
  bool addedBaCl2 = false;
  bool checkedInsoluble = false;
  late AnimationController _pptController;
  late Animation<double> _pptHeight;

  @override
  void initState() {
    super.initState();
    _pptController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _pptHeight = Tween<double>(begin: 0, end: 50).animate(_pptController);
  }

  @override
  void dispose() {
    _pptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (addedBaCl2) {
      _pptController.forward();
    } else {
      _pptController.reverse();
    }

    String description = addedBaCl2 ? (checkedInsoluble ? 'White ppt insoluble in HCl' : 'White ppt of BaSO₄') : 'Add BaCl₂';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sulfate (SO₄²⁻) Test'),
        backgroundColor: Colors.purple[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        if (addedBaCl2)
                          Positioned(
                            bottom: 20,
                            child: AnimatedBuilder(
                              animation: _pptHeight,
                              builder: (context, child) {
                                return Container(
                                  width: 80,
                                  height: _pptHeight.value,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'BaCl₂ + Na₂SO₄ → BaSO₄ + 2NaCl',
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildControlSwitch(
                    'Add BaCl₂ Solution',
                    addedBaCl2,
                        (value) => setState(() => addedBaCl2 = value),
                    Colors.purple,
                  ),
                  const SizedBox(height: 10),
                  _buildControlSwitch(
                    'Check Insolubility in HCl',
                    checkedInsoluble,
                    addedBaCl2 ? (value) => setState(() => checkedInsoluble = value) : null,
                    Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Chloride Test
class ChlorideTestSimulation extends StatefulWidget {
  const ChlorideTestSimulation({super.key});

  @override
  State<ChlorideTestSimulation> createState() => _ChlorideTestSimulationState();
}

class _ChlorideTestSimulationState extends State<ChlorideTestSimulation>
    with SingleTickerProviderStateMixin {
  bool addedAgNO3 = false;
  bool addedNH3 = false;
  late AnimationController _pptController;
  late Animation<double> _pptHeight;

  @override
  void initState() {
    super.initState();
    _pptController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _pptHeight = Tween<double>(begin: 0, end: 40).animate(_pptController);
  }

  @override
  void dispose() {
    _pptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (addedAgNO3 && !addedNH3) {
      _pptController.forward();
    } else {
      _pptController.reverse();
    }

    String description = 'Add AgNO₃';
    if (addedAgNO3) {
      description = addedNH3 ? 'Ppt dissolves in NH₃' : 'White ppt of AgCl';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chloride (Cl⁻) Test'),
        backgroundColor: Colors.indigo[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        if (addedAgNO3 && !addedNH3)
                          Positioned(
                            bottom: 20,
                            child: AnimatedBuilder(
                              animation: _pptHeight,
                              builder: (context, child) {
                                return Container(
                                  width: 80,
                                  height: _pptHeight.value,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'AgNO₃ + NaCl → AgCl + NaNO₃\nAgCl + 2NH₃ → [Ag(NH₃)₂]⁺ + Cl⁻',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildControlSwitch(
                    'Add AgNO₃ Solution',
                    addedAgNO3,
                        (value) => setState(() => addedAgNO3 = value),
                    Colors.indigo,
                  ),
                  const SizedBox(height: 10),
                  _buildControlSwitch(
                    'Add NH₃ Solution',
                    addedNH3,
                    addedAgNO3 ? (value) => setState(() => addedNH3 = value) : null,
                    Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Acetate Test
class AcetateTestSimulation extends StatefulWidget {
  const AcetateTestSimulation({super.key});

  @override
  State<AcetateTestSimulation> createState() => _AcetateTestSimulationState();
}

class _AcetateTestSimulationState extends State<AcetateTestSimulation>
    with SingleTickerProviderStateMixin {
  bool addedH2SO4 = false;
  late AnimationController _vaporController;
  late Animation<double> _vaporAnimation;

  @override
  void initState() {
    super.initState();
    _vaporController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _vaporAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _vaporController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _vaporController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (addedH2SO4) {
      _vaporController.repeat(reverse: true);
    } else {
      _vaporController.stop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acetate (CH₃COO⁻) Test'),
        backgroundColor: Colors.brown[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.brown[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        if (addedH2SO4)
                          AnimatedBuilder(
                            animation: _vaporAnimation,
                            builder: (context, child) {
                              return Positioned(
                                bottom: 100 * _vaporAnimation.value,
                                child: Icon(
                                  Icons.cloud,
                                  color: Colors.grey[400],
                                  size: 40 + _vaporAnimation.value * 20,
                                ),
                              );
                            },
                          ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            addedH2SO4 ? '✅ Vinegar smell (CH₃COOH)' : '⬇️ Add conc. H₂SO₄',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'CH₃COONa + H₂SO₄ → CH₃COOH + NaHSO₄',
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: _buildControlSwitch(
                'Add conc. H₂SO₄',
                addedH2SO4,
                    (value) => setState(() => addedH2SO4 = value),
                Colors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Nitrate Test
class NitrateTestSimulation extends StatefulWidget {
  const NitrateTestSimulation({super.key});

  @override
  State<NitrateTestSimulation> createState() => _NitrateTestSimulationState();
}

class _NitrateTestSimulationState extends State<NitrateTestSimulation>
    with SingleTickerProviderStateMixin {
  bool addedFeSO4 = false;
  bool addedH2SO4 = false;
  late AnimationController _ringController;
  late Animation<Color?> _ringColor;

  @override
  void initState() {
    super.initState();
    _ringController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _ringColor = ColorTween(
      begin: Colors.transparent,
      end: Colors.brown,
    ).animate(_ringController);
  }

  @override
  void dispose() {
    _ringController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (addedH2SO4) {
      _ringController.forward();
    } else {
      _ringController.reverse();
    }

    String description = 'Add FeSO₄';
    if (addedFeSO4) {
      description = addedH2SO4 ? 'Brown ring [Fe(NO)]²⁺' : 'Add H₂SO₄ carefully';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nitrate (NO₃⁻) Test - Brown Ring'),
        backgroundColor: Colors.deepOrange[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        AnimatedBuilder(
                          animation: _ringColor,
                          builder: (context, child) {
                            return Positioned(
                              bottom: 50,
                              left: 10,
                              right: 10,
                              child: Container(
                                height: 15,
                                decoration: BoxDecoration(
                                  color: _ringColor.value,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _ringColor.value?.withOpacity(0.5) ?? Colors.transparent,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'NO₃⁻ + Fe²⁺ + H₂SO₄ → [Fe(NO)]²⁺ + ...',
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildControlSwitch(
                    'Add FeSO₄ Solution',
                    addedFeSO4,
                        (value) => setState(() => addedFeSO4 = value),
                    Colors.green,
                  ),
                  const SizedBox(height: 10),
                  _buildControlSwitch(
                    'Add H₂SO₄ Carefully',
                    addedH2SO4,
                    addedFeSO4 ? (value) => setState(() => addedH2SO4 = value) : null,
                    Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Standard Solution Preparation
class StandardSolutionSimulation extends StatefulWidget {
  const StandardSolutionSimulation({super.key});

  @override
  State<StandardSolutionSimulation> createState() => _StandardSolutionSimulationState();
}

class _StandardSolutionSimulationState extends State<StandardSolutionSimulation> {
  double volumeAcid = 0.0;
  double volumeWater = 0.0;

  @override
  Widget build(BuildContext context) {
    bool isDiluted = volumeAcid > 0 && volumeWater > 0;
    String description = isDiluted ? '0.1M H₂SO₄ prepared' : 'Add conc. acid to water';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preparing 0.1M H₂SO₄'),
        backgroundColor: Colors.cyan[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.cyan[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Volumetric flask
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width: 100,
                          height: (volumeAcid + volumeWater) / 100 * 150,
                          decoration: BoxDecoration(
                            color: Colors.blue[100]!.withOpacity(0.7),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${(volumeAcid + volumeWater).toStringAsFixed(1)} mL',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Procedure: Add measured conc. acid to water in volumetric flask, make up to mark.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Control Volumes',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Slider(
                    value: volumeAcid,
                    min: 0,
                    max: 10,
                    divisions: 20,
                    label: 'Acid: ${volumeAcid.toStringAsFixed(1)} mL',
                    onChanged: (value) => setState(() => volumeAcid = value),
                    activeColor: Colors.red,
                  ),
                  Slider(
                    value: volumeWater,
                    min: 0,
                    max: 90,
                    divisions: 90,
                    label: 'Water: ${volumeWater.toStringAsFixed(1)} mL',
                    onChanged: (value) => setState(() => volumeWater = value),
                    activeColor: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Enhanced Acid-Base Titration
class AcidBaseTitrationSimulation extends StatefulWidget {
  const AcidBaseTitrationSimulation({super.key});

  @override
  State<AcidBaseTitrationSimulation> createState() => _AcidBaseTitrationSimulationState();
}

class _AcidBaseTitrationSimulationState extends State<AcidBaseTitrationSimulation>
    with SingleTickerProviderStateMixin {
  double volumeHCl = 0.0;
  double equivalence = 25.0;
  late AnimationController _colorController;
  late Animation<Color?> _flaskColor;

  @override
  void initState() {
    super.initState();
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _flaskColor = ColorTween(
      begin: Colors.pink,
      end: Colors.transparent,
    ).animate(_colorController);
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  Color getColor() {
    double ratio = volumeHCl / equivalence;
    _colorController.animateTo(ratio.clamp(0.0, 1.0));

    if (volumeHCl < equivalence) {
      return Colors.pink.withOpacity(0.7 - (ratio * 0.5));
    }
    return _flaskColor.value ?? Colors.transparent;
  }

  String getStatus() {
    if (volumeHCl < equivalence - 2) return '🟣 Basic (Pink)';
    if (volumeHCl > equivalence + 2) return '⚪ Acidic (Colorless)';
    return '🎯 End Point (Neutral)';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acid-Base Titration (HCl vs NaOH)'),
        backgroundColor: Colors.pink[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pink[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 60,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 2),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: EdgeInsets.only(top: (50 - volumeHCl) / 50 * 180),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[200],
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(4),
                                        bottomRight: Radius.circular(4),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${volumeHCl.toStringAsFixed(1)} mL HCl',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            Container(
                              width: 120,
                              height: 150,
                              decoration: BoxDecoration(
                                color: getColor(),
                                border: Border.all(color: Colors.grey, width: 2),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(60),
                                  bottomRight: Radius.circular(60),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: getColor().withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text('NaOH + Phenolphthalein', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            getStatus(),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'HCl + NaOH → NaCl + H₂O',
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                          const SizedBox(height: 10),
                          LinearProgressIndicator(
                            value: volumeHCl / 50,
                            backgroundColor: Colors.grey[200],
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Progress: ${(volumeHCl / 50 * 100).toStringAsFixed(1)}%',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Adjust HCl Volume',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Slider(
                    value: volumeHCl,
                    min: 0,
                    max: 50,
                    divisions: 100,
                    label: '${volumeHCl.toStringAsFixed(1)} mL',
                    onChanged: (value) => setState(() => volumeHCl = value),
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey[300],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0 mL', style: TextStyle(color: Colors.grey[600])),
                      Text('Equivalence: $equivalence mL', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('50 mL', style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Enhanced Redox Titration
class RedoxTitrationSimulation extends StatefulWidget {
  const RedoxTitrationSimulation({super.key});

  @override
  State<RedoxTitrationSimulation> createState() => _RedoxTitrationSimulationState();
}

class _RedoxTitrationSimulationState extends State<RedoxTitrationSimulation>
    with SingleTickerProviderStateMixin {
  double volumeKMnO4 = 0.0;
  double equivalence = 20.0;
  late AnimationController _colorController;
  late Animation<Color?> _flaskColor;

  @override
  void initState() {
    super.initState();
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _flaskColor = ColorTween(
      begin: Colors.transparent,
      end: Colors.pink[100]!,
    ).animate(_colorController);
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  Color getColor() {
    double ratio = volumeKMnO4 / equivalence;
    _colorController.animateTo(ratio.clamp(0.0, 1.0));

    if (volumeKMnO4 < equivalence) {
      return Colors.transparent;
    }
    return _flaskColor.value ?? Colors.pink[100]!;
  }

  String getStatus() {
    if (volumeKMnO4 < equivalence - 1) return '⚪ Colorless';
    if (volumeKMnO4 > equivalence + 1) return '🟣 Permanent light pink';
    return '🎯 End Point';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redox Titration (KMnO₄ vs Oxalic Acid)'),
        backgroundColor: Colors.deepPurple[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 60,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 2),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: EdgeInsets.only(top: (50 - volumeKMnO4) / 50 * 180),
                                    decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(4),
                                        bottomRight: Radius.circular(4),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${volumeKMnO4.toStringAsFixed(1)} mL KMnO₄',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            Container(
                              width: 120,
                              height: 150,
                              decoration: BoxDecoration(
                                color: getColor(),
                                border: Border.all(color: Colors.grey, width: 2),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(60),
                                  bottomRight: Radius.circular(60),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: getColor().withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text('Oxalic Acid', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            getStatus(),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '2KMnO₄ + 5H₂C₂O₄ + 3H₂SO₄ → K₂SO₄ + 2MnSO₄ + 10CO₂ + 8H₂O',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                          const SizedBox(height: 10),
                          LinearProgressIndicator(
                            value: volumeKMnO4 / 50,
                            backgroundColor: Colors.grey[200],
                            color: Colors.purple,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Adjust KMnO₄ Volume',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Slider(
                    value: volumeKMnO4,
                    min: 0,
                    max: 50,
                    divisions: 100,
                    label: '${volumeKMnO4.toStringAsFixed(1)} mL',
                    onChanged: (value) => setState(() => volumeKMnO4 = value),
                    activeColor: Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Enhanced Heat of Neutralization
class HeatNeutralizationSimulation extends StatefulWidget {
  const HeatNeutralizationSimulation({super.key});

  @override
  State<HeatNeutralizationSimulation> createState() => _HeatNeutralizationSimulationState();
}

class _HeatNeutralizationSimulationState extends State<HeatNeutralizationSimulation>
    with SingleTickerProviderStateMixin {
  bool mixed = false;
  late AnimationController _heatController;
  late Animation<double> _temperatureAnimation;
  late Animation<Color?> _calorimeterColor;

  @override
  void initState() {
    super.initState();
    _heatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _temperatureAnimation = Tween<double>(begin: 25, end: 30).animate(_heatController);
    _calorimeterColor = ColorTween(
      begin: Colors.transparent,
      end: Colors.red[100],
    ).animate(_heatController);
  }

  @override
  void dispose() {
    _heatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (mixed) {
      _heatController.forward();
    } else {
      _heatController.reverse();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Heat of Neutralization (HCl + NaOH)'),
        backgroundColor: Colors.amber[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.amber[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _heatController,
                      builder: (context, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 150,
                              height: 200,
                              decoration: BoxDecoration(
                                color: _calorimeterColor.value,
                                border: Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: _calorimeterColor.value?.withOpacity(0.3) ?? Colors.transparent,
                                    blurRadius: 8,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.thermostat, size: 40, color: Colors.red),
                                    const SizedBox(height: 10),
                                    Text(
                                      '${_temperatureAnimation.value.toStringAsFixed(1)}°C',
                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (mixed)
                              ...List.generate(3, (index) {
                                return Positioned(
                                  top: 30 + index * 20,
                                  right: 20 + index * 10,
                                  child: Icon(
                                    Icons.whatshot,
                                    color: Colors.red,
                                    size: 15 + _heatController.value * 10,
                                  ),
                                );
                              }),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            mixed ? '✅ Heat released in neutralization' : '⬇️ Mix acid and base',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'H⁺ + OH⁻ → H₂O + heat (ΔH = -57.3 kJ/mol)',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: _buildControlSwitch(
                'Mix HCl and NaOH',
                mixed,
                    (value) => setState(() => mixed = value),
                Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Copper Sulfate Crystals
class CopperSulfateCrystalsSimulation extends StatefulWidget {
  const CopperSulfateCrystalsSimulation({super.key});

  @override
  State<CopperSulfateCrystalsSimulation> createState() => _CopperSulfateCrystalsSimulationState();
}

class _CopperSulfateCrystalsSimulationState extends State<CopperSulfateCrystalsSimulation>
    with SingleTickerProviderStateMixin {
  double evaporation = 0.0;
  late AnimationController _crystalController;
  late Animation<double> _crystalAnimation;

  @override
  void initState() {
    super.initState();
    _crystalController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _crystalAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _crystalController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _crystalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int crystalCount = (evaporation / 20).floor();
    bool crystalsFormed = evaporation > 80;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preparation of Copper Sulfate Crystals'),
        backgroundColor: Colors.blueAccent[700],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.blue[50]!.withOpacity(0.3),
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),

                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width: 180 * (1 - evaporation / 100),
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.5 - (evaporation / 200)),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),

                        if (crystalsFormed)
                          ...List.generate(crystalCount.clamp(1, 8), (index) {
                            return Positioned(
                              left: 20 + index * 20,
                              bottom: 10,
                              child: AnimatedBuilder(
                                animation: _crystalAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _crystalAnimation.value,
                                    child: Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                        color: Colors.blue[700],
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blue.withOpacity(0.5),
                                            blurRadius: 4,
                                            offset: const Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                      ],
                    ),

                    const SizedBox(height: 40),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            crystalsFormed
                                ? '✅ Beautiful blue CuSO₄·5H₂O crystals formed!'
                                : '💧 Evaporating solution...',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          LinearProgressIndicator(
                            value: evaporation / 100,
                            backgroundColor: Colors.grey[200],
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'CuO + H₂SO₄ → CuSO₄ + H₂O',
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Control Evaporation',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Slider(
                    value: evaporation,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: '${evaporation.toStringAsFixed(1)}%',
                    onChanged: (value) => setState(() => evaporation = value),
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey[300],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Enhanced Sodium Chloride Crystals
class SodiumChlorideCrystalsSimulation extends StatefulWidget {
  const SodiumChlorideCrystalsSimulation({super.key});

  @override
  State<SodiumChlorideCrystalsSimulation> createState() => _SodiumChlorideCrystalsSimulationState();
}

class _SodiumChlorideCrystalsSimulationState extends State<SodiumChlorideCrystalsSimulation>
    with SingleTickerProviderStateMixin {
  double evaporation = 0.0;
  late AnimationController _crystalController;
  late Animation<double> _crystalAnimation;

  @override
  void initState() {
    super.initState();
    _crystalController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _crystalAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _crystalController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _crystalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int crystalCount = (evaporation / 20).floor();
    bool crystalsFormed = evaporation > 80;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preparation of Sodium Chloride Crystals'),
        backgroundColor: Colors.grey[700],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey[50]!.withOpacity(0.3),
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),

                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width: 180 * (1 - evaporation / 100),
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3 - (evaporation / 300)),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),

                        if (crystalsFormed)
                          ...List.generate(crystalCount.clamp(1, 8), (index) {
                            return Positioned(
                              left: 20 + index * 20,
                              bottom: 10,
                              child: AnimatedBuilder(
                                animation: _crystalAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _crystalAnimation.value,
                                    child: Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.grey),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 4,
                                            offset: const Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                      ],
                    ),

                    const SizedBox(height: 40),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            crystalsFormed
                                ? '✅ NaCl crystals formed!'
                                : '💧 Evaporating solution...',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          LinearProgressIndicator(
                            value: evaporation / 100,
                            backgroundColor: Colors.grey[200],
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'NaOH + HCl → NaCl + H₂O',
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Control Evaporation',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Slider(
                    value: evaporation,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: '${evaporation.toStringAsFixed(1)}%',
                    onChanged: (value) => setState(() => evaporation = value),
                    activeColor: Colors.grey,
                    inactiveColor: Colors.grey[300],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Enhanced Thiosulfate Rate Experiment
class ThiosulfateRateSimulation extends StatefulWidget {
  const ThiosulfateRateSimulation({super.key});

  @override
  State<ThiosulfateRateSimulation> createState() => _ThiosulfateRateSimulationState();
}

class _ThiosulfateRateSimulationState extends State<ThiosulfateRateSimulation>
    with TickerProviderStateMixin {
  bool started = false;
  late AnimationController _reactionController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _reactionController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
      setState(() {});
    });

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_reactionController);
  }

  @override
  void dispose() {
    _reactionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (started) {
      _reactionController.forward();
    } else {
      _reactionController.reset();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate of Reaction: Na₂S₂O₃ + HCl'),
        backgroundColor: Colors.lime[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lime[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Text(
                          'X',
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.yellow.withOpacity(_opacityAnimation.value),
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            started
                                ? (_opacityAnimation.value >= 1.0
                                ? '✅ Cross disappeared (Sulfur precipitate)'
                                : '⏳ Reaction proceeding...')
                                : '⬇️ Mix chemicals to start',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          LinearProgressIndicator(
                            value: _opacityAnimation.value,
                            backgroundColor: Colors.grey[200],
                            color: Colors.yellow,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Na₂S₂O₃ + 2HCl → 2NaCl + SO₂ + S↓ + H₂O',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: _buildControlSwitch(
                'Start Reaction',
                started,
                    (value) => setState(() => started = value),
                Colors.lime,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Peroxide Decomposition
class PeroxideDecompositionSimulation extends StatefulWidget {
  const PeroxideDecompositionSimulation({super.key});

  @override
  State<PeroxideDecompositionSimulation> createState() => _PeroxideDecompositionSimulationState();
}

class _PeroxideDecompositionSimulationState extends State<PeroxideDecompositionSimulation>
    with SingleTickerProviderStateMixin {
  bool addedMnO2 = false;
  late AnimationController _bubbleController;
  late Animation<double> _bubbleAnimation;

  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _bubbleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _bubbleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (addedMnO2) {
      _bubbleController.repeat(reverse: true);
    } else {
      _bubbleController.stop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Decomposition of Hydrogen Peroxide'),
        backgroundColor: Colors.lightGreen[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        if (addedMnO2)
                          ...List.generate(5, (index) {
                            return Positioned(
                              bottom: 20 + index * 15,
                              left: 40 + index * 5,
                              child: AnimatedBuilder(
                                animation: _bubbleAnimation,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(0, -120 * _bubbleAnimation.value),
                                    child: Container(
                                      width: 8 + index * 2,
                                      height: 8 + index * 2,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                        if (addedMnO2)
                          Positioned(
                            bottom: 10,
                            child: Container(
                              width: 60,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'MnO₂',
                                  style: TextStyle(color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            addedMnO2 ? '✅ O₂ gas produced rapidly' : '⬇️ Add MnO₂ catalyst',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '2H₂O₂ → 2H₂O + O₂ (MnO₂ catalyst)',
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: _buildControlSwitch(
                'Add MnO₂ Catalyst',
                addedMnO2,
                    (value) => setState(() => addedMnO2 = value),
                Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Alcohol Test
class AlcoholTestSimulation extends StatefulWidget {
  const AlcoholTestSimulation({super.key});

  @override
  State<AlcoholTestSimulation> createState() => _AlcoholTestSimulationState();
}

class _AlcoholTestSimulationState extends State<AlcoholTestSimulation>
    with SingleTickerProviderStateMixin {
  bool addedSodium = false;
  late AnimationController _bubbleController;
  late Animation<double> _bubbleAnimation;

  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _bubbleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _bubbleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (addedSodium) {
      _bubbleController.repeat(reverse: true);
    } else {
      _bubbleController.stop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alcohol Test with Sodium'),
        backgroundColor: Colors.orangeAccent[700],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        if (addedSodium)
                          ...List.generate(4, (index) {
                            return Positioned(
                              bottom: 30 + index * 15,
                              left: 45 + index * 8,
                              child: AnimatedBuilder(
                                animation: _bubbleAnimation,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(0, -80 * _bubbleAnimation.value),
                                    child: Container(
                                      width: 6 + index * 2,
                                      height: 6 + index * 2,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                        if (addedSodium)
                          Positioned(
                            bottom: 10,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            addedSodium ? '✅ H₂ gas evolves' : '⬇️ Add sodium metal',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '2R–OH + 2Na → 2R–ONa + H₂↑',
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: _buildControlSwitch(
                'Add Sodium Metal',
                addedSodium,
                    (value) => setState(() => addedSodium = value),
                Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Aldehyde Test
class AldehydeTestSimulation extends StatefulWidget {
  const AldehydeTestSimulation({super.key});

  @override
  State<AldehydeTestSimulation> createState() => _AldehydeTestSimulationState();
}

class _AldehydeTestSimulationState extends State<AldehydeTestSimulation>
    with SingleTickerProviderStateMixin {
  bool addedTollens = false;
  bool warmed = false;
  late AnimationController _mirrorController;
  late Animation<Color?> _mirrorColor;

  @override
  void initState() {
    super.initState();
    _mirrorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _mirrorColor = ColorTween(
      begin: Colors.transparent,
      end: Colors.grey,
    ).animate(_mirrorController);
  }

  @override
  void dispose() {
    _mirrorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (warmed && addedTollens) {
      _mirrorController.forward();
    } else {
      _mirrorController.reverse();
    }

    String description = addedTollens ? (warmed ? 'Silver mirror formed' : 'Warm gently') : 'Add Tollen\'s reagent';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aldehyde - Tollen\'s Test'),
        backgroundColor: Colors.grey[700],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _mirrorController,
                      builder: (context, child) {
                        return Container(
                          width: 120,
                          height: 200,
                          decoration: BoxDecoration(
                            color: _mirrorColor.value,
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: _mirrorColor.value?.withOpacity(0.5) ?? Colors.transparent,
                                blurRadius: 8,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: warmed && addedTollens
                              ? const Icon(Icons.auto_awesome, size: 40, color: Colors.white)
                              : null,
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'R–CHO + 2Ag⁺ + H₂O → R–COOH + 2Ag',
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildControlSwitch(
                    'Add Tollen\'s Reagent',
                    addedTollens,
                        (value) => setState(() => addedTollens = value),
                    Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  _buildControlSwitch(
                    'Warm Gently',
                    warmed,
                    addedTollens ? (value) => setState(() => warmed = value) : null,
                    Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Ketone Test
class KetoneTestSimulation extends StatefulWidget {
  const KetoneTestSimulation({super.key});

  @override
  State<KetoneTestSimulation> createState() => _KetoneTestSimulationState();
}

class _KetoneTestSimulationState extends State<KetoneTestSimulation>
    with SingleTickerProviderStateMixin {
  bool addedIodineNaOH = false;
  bool warmed = false;
  late AnimationController _pptController;
  late Animation<Color?> _pptColor;

  @override
  void initState() {
    super.initState();
    _pptController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _pptColor = ColorTween(
      begin: Colors.transparent,
      end: Colors.yellow,
    ).animate(_pptController);
  }

  @override
  void dispose() {
    _pptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (warmed && addedIodineNaOH) {
      _pptController.forward();
    } else {
      _pptController.reverse();
    }

    String description = addedIodineNaOH ? (warmed ? 'Yellow iodoform ppt' : 'Warm gently') : 'Add I₂ + NaOH';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ketone - Iodoform Test'),
        backgroundColor: Colors.yellowAccent[700],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.yellow[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          child: AnimatedBuilder(
                            animation: _pptController,
                            builder: (context, child) {
                              return Container(
                                width: 80,
                                height: 30 + (_pptController.value * 20),
                                decoration: BoxDecoration(
                                  color: _pptColor.value?.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _pptColor.value?.withOpacity(0.5) ?? Colors.transparent,
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'CH₃CO–R + 3I₂ + 4NaOH → CHI₃ + RCOONa + 3NaI + 3H₂O',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildControlSwitch(
                    'Add I₂ + NaOH',
                    addedIodineNaOH,
                        (value) => setState(() => addedIodineNaOH = value),
                    Colors.yellow,
                  ),
                  const SizedBox(height: 10),
                  _buildControlSwitch(
                    'Warm Gently',
                    warmed,
                    addedIodineNaOH ? (value) => setState(() => warmed = value) : null,
                    Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Carboxylic Acid Test
class CarboxylicAcidTestSimulation extends StatefulWidget {
  const CarboxylicAcidTestSimulation({super.key});

  @override
  State<CarboxylicAcidTestSimulation> createState() => _CarboxylicAcidTestSimulationState();
}

class _CarboxylicAcidTestSimulationState extends State<CarboxylicAcidTestSimulation>
    with SingleTickerProviderStateMixin {
  bool addedNaHCO3 = false;
  late AnimationController _bubbleController;
  late Animation<double> _bubbleAnimation;

  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _bubbleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _bubbleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (addedNaHCO3) {
      _bubbleController.repeat(reverse: true);
    } else {
      _bubbleController.stop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carboxylic Acid - NaHCO₃ Test'),
        backgroundColor: Colors.redAccent[700],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        if (addedNaHCO3)
                          ...List.generate(5, (index) {
                            return Positioned(
                              bottom: 20 + index * 15,
                              left: 35 + index * 8,
                              child: AnimatedBuilder(
                                animation: _bubbleAnimation,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(0, -100 * _bubbleAnimation.value),
                                    child: Container(
                                      width: 8 + index * 2,
                                      height: 8 + index * 2,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            addedNaHCO3 ? '✅ Brisk effervescence of CO₂' : '⬇️ Add NaHCO₃',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'RCOOH + NaHCO₃ → RCOONa + CO₂↑ + H₂O',
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: _buildControlSwitch(
                'Add NaHCO₃',
                addedNaHCO3,
                    (value) => setState(() => addedNaHCO3 = value),
                Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Sodium Carbonate Estimation
class SodiumCarbonateEstimationSimulation extends StatefulWidget {
  const SodiumCarbonateEstimationSimulation({super.key});

  @override
  State<SodiumCarbonateEstimationSimulation> createState() => _SodiumCarbonateEstimationSimulationState();
}

class _SodiumCarbonateEstimationSimulationState extends State<SodiumCarbonateEstimationSimulation>
    with SingleTickerProviderStateMixin {
  double volumeHCl = 0.0;
  double equivalence = 25.0;
  late AnimationController _colorController;
  late Animation<Color?> _flaskColor;

  @override
  void initState() {
    super.initState();
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _flaskColor = ColorTween(
      begin: Colors.orange,
      end: Colors.red,
    ).animate(_colorController);
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  Color getColor() {
    double ratio = volumeHCl / equivalence;
    _colorController.animateTo(ratio.clamp(0.0, 1.0));

    if (volumeHCl < equivalence) {
      return Colors.orange.withOpacity(0.7 - (ratio * 0.3));
    }
    return _flaskColor.value ?? Colors.red;
  }

  String getStatus() {
    if (volumeHCl < equivalence - 2) return '🟠 Orange (Basic)';
    if (volumeHCl > equivalence + 2) return '🔴 Red (Acidic)';
    return '🎯 End Point';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estimation of Sodium Carbonate'),
        backgroundColor: Colors.tealAccent[700],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 60,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 2),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: EdgeInsets.only(top: (50 - volumeHCl) / 50 * 180),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[200],
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(4),
                                        bottomRight: Radius.circular(4),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${volumeHCl.toStringAsFixed(1)} mL HCl',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            Container(
                              width: 120,
                              height: 150,
                              decoration: BoxDecoration(
                                color: getColor().withOpacity(0.7),
                                border: Border.all(color: Colors.grey, width: 2),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(60),
                                  bottomRight: Radius.circular(60),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: getColor().withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text('Na₂CO₃ + Methyl Orange', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            getStatus(),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Na₂CO₃ + 2HCl → 2NaCl + CO₂ + H₂O',
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                          const SizedBox(height: 10),
                          LinearProgressIndicator(
                            value: volumeHCl / 50,
                            backgroundColor: Colors.grey[200],
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Adjust HCl Volume',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Slider(
                    value: volumeHCl,
                    min: 0,
                    max: 50,
                    divisions: 100,
                    label: '${volumeHCl.toStringAsFixed(1)} mL',
                    onChanged: (value) => setState(() => volumeHCl = value),
                    activeColor: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Enhanced Distillation Simulation
class DistillationSimulation extends StatefulWidget {
  const DistillationSimulation({super.key});

  @override
  State<DistillationSimulation> createState() => _DistillationSimulationState();
}

class _DistillationSimulationState extends State<DistillationSimulation>
    with SingleTickerProviderStateMixin {
  double temperature = 20.0;
  late AnimationController _distillController;
  late Animation<double> _distillAnimation;

  @override
  void initState() {
    super.initState();
    _distillController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _distillAnimation = Tween<double>(begin: 0, end: 1).animate(_distillController);
  }

  @override
  void dispose() {
    _distillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool distilling = temperature > 78.0; // Ethanol boiling point
    if (distilling) {
      _distillController.repeat(reverse: true);
    } else {
      _distillController.stop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Distillation and Purification'),
        backgroundColor: Colors.blueGrey[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        // Distillation setup
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: Column(
                            children: [
                              // Flask
                              Container(
                                width: 80,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.orange[100],
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(40),
                                    bottomRight: Radius.circular(40),
                                  ),
                                ),
                              ),
                              // Condenser
                              Container(
                                width: 20,
                                height: 80,
                                color: Colors.grey[300],
                              ),
                              // Receiving flask
                              Container(
                                width: 60,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: distilling ? Colors.blue[100] : Colors.transparent,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                        ),

                        if (distilling)
                          AnimatedBuilder(
                            animation: _distillAnimation,
                            builder: (context, child) {
                              return Positioned(
                                right: 80,
                                top: 80 + _distillAnimation.value * 60,
                                child: Icon(
                                  Icons.water_drop,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                              );
                            },
                          ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            distilling ? '✅ Distillate collecting' : '🔥 Heat to boiling point',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Temperature: ${temperature.toStringAsFixed(1)}°C',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Procedure: Heat sample; collect distillate at boiling point.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Control Temperature',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Slider(
                    value: temperature,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: '${temperature.toStringAsFixed(1)}°C',
                    onChanged: (value) => setState(() => temperature = value),
                    activeColor: Colors.red,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0°C', style: TextStyle(color: Colors.grey[600])),
                      Text('78°C (Ethanol BP)', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('100°C', style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Enhanced Melting & Boiling Points
class MeltingBoilingSimulation extends StatefulWidget {
  const MeltingBoilingSimulation({super.key});

  @override
  State<MeltingBoilingSimulation> createState() => _MeltingBoilingSimulationState();
}

class _MeltingBoilingSimulationState extends State<MeltingBoilingSimulation>
    with SingleTickerProviderStateMixin {
  double temperature = 20.0;
  late AnimationController _stateController;
  late Animation<double> _particleAnimation;

  @override
  void initState() {
    super.initState();
    _stateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _particleAnimation = Tween<double>(begin: 0, end: 1).animate(_stateController);
  }

  @override
  void dispose() {
    _stateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String state = 'Solid';
    Color stateColor = Colors.white;
    if (temperature < 0) {
      state = 'Solid ❄️';
      stateColor = Colors.blue[50]!;
    } else if (temperature < 100) {
      state = 'Liquid 💧';
      stateColor = Colors.blue[100]!;
    } else {
      state = 'Gas 💨';
      stateColor = Colors.grey[100]!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Melting & Boiling Points'),
        backgroundColor: Colors.deepOrangeAccent[700],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: stateColor,
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: stateColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            if (temperature >= 100)
                              AnimatedBuilder(
                                animation: _particleAnimation,
                                builder: (context, child) {
                                  return Icon(
                                    Icons.arrow_upward,
                                    size: 30,
                                    color: Colors.grey.withOpacity(_particleAnimation.value),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Temperature: ${temperature.toStringAsFixed(1)}°C',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Procedure: Heat sample and note temperature at phase changes.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildPhaseIndicator('Melting', '0°C', temperature >= 0),
                              _buildPhaseIndicator('Boiling', '100°C', temperature >= 100),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Control Temperature',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Slider(
                    value: temperature,
                    min: -50,
                    max: 150,
                    divisions: 200,
                    label: '${temperature.toStringAsFixed(1)}°C',
                    onChanged: (value) => setState(() => temperature = value),
                    activeColor: Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhaseIndicator(String phase, String temp, bool reached) {
    return Column(
      children: [
        Text(
          phase,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: reached ? Colors.green : Colors.grey,
          ),
        ),
        Text(
          temp,
          style: TextStyle(
            color: reached ? Colors.green : Colors.grey,
          ),
        ),
        Icon(
          reached ? Icons.check_circle : Icons.radio_button_unchecked,
          color: reached ? Colors.green : Colors.grey,
        ),
      ],
    );
  }
}

// Enhanced Silver Chloride Precipitation
class SilverChloridePrecipitationSimulation extends StatefulWidget {
  const SilverChloridePrecipitationSimulation({super.key});

  @override
  State<SilverChloridePrecipitationSimulation> createState() => _SilverChloridePrecipitationSimulationState();
}

class _SilverChloridePrecipitationSimulationState extends State<SilverChloridePrecipitationSimulation>
    with SingleTickerProviderStateMixin {
  bool addedNaCl = false;
  late AnimationController _pptController;
  late Animation<double> _pptHeight;

  @override
  void initState() {
    super.initState();
    _pptController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _pptHeight = Tween<double>(begin: 0, end: 50).animate(_pptController);
  }

  @override
  void dispose() {
    _pptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (addedNaCl) {
      _pptController.forward();
    } else {
      _pptController.reverse();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Precipitation of Silver Chloride'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        if (addedNaCl)
                          Positioned(
                            bottom: 20,
                            child: AnimatedBuilder(
                              animation: _pptHeight,
                              builder: (context, child) {
                                return Container(
                                  width: 80,
                                  height: _pptHeight.value,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            addedNaCl ? '✅ White ppt of AgCl' : '⬇️ Add NaCl',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'AgNO₃ + NaCl → AgCl + NaNO₃',
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: _buildControlSwitch(
                'Add NaCl Solution',
                addedNaCl,
                    (value) => setState(() => addedNaCl = value),
                Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Calcium Carbonate Precipitation
class CalciumCarbonatePrecipitationSimulation extends StatefulWidget {
  const CalciumCarbonatePrecipitationSimulation({super.key});

  @override
  State<CalciumCarbonatePrecipitationSimulation> createState() => _CalciumCarbonatePrecipitationSimulationState();
}

class _CalciumCarbonatePrecipitationSimulationState extends State<CalciumCarbonatePrecipitationSimulation>
    with SingleTickerProviderStateMixin {
  bool addedNa2CO3 = false;
  late AnimationController _pptController;
  late Animation<double> _pptHeight;

  @override
  void initState() {
    super.initState();
    _pptController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _pptHeight = Tween<double>(begin: 0, end: 50).animate(_pptController);
  }

  @override
  void dispose() {
    _pptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (addedNa2CO3) {
      _pptController.forward();
    } else {
      _pptController.reverse();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Precipitation of Calcium Carbonate'),
        backgroundColor: Colors.lightBlue[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        if (addedNa2CO3)
                          Positioned(
                            bottom: 20,
                            child: AnimatedBuilder(
                              animation: _pptHeight,
                              builder: (context, child) {
                                return Container(
                                  width: 80,
                                  height: _pptHeight.value,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            addedNa2CO3 ? '✅ White ppt of CaCO₃' : '⬇️ Add Na₂CO₃',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'CaCl₂ + Na₂CO₃ → CaCO₃ + 2NaCl',
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: _buildControlSwitch(
                'Add Na₂CO₃ Solution',
                addedNa2CO3,
                    (value) => setState(() => addedNa2CO3 = value),
                Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlSwitch(String title, bool value, Function(bool)? onChanged, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ],
    );
  }
}

// Enhanced Safety Protocol
class SafetyProtocolSimulation extends StatelessWidget {
  const SafetyProtocolSimulation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safety Protocol Demonstration'),
        backgroundColor: Colors.red[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red[50]!, Colors.white],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            _buildSafetyCard(
              Icons.warning,
              'Acid Dilution Safety',
              'Always add acid to water, never water to acid. This prevents violent reactions and splashing.',
              Colors.orange,
            ),
            _buildSafetyCard(
              Icons.clean_hands,
              'Personal Protection',
              'Wear lab coat, safety goggles, and gloves. Tie back long hair and avoid loose clothing.',
              Colors.blue,
            ),
            _buildSafetyCard(
              Icons.handshake,
              'Glassware Handling',
              'Inspect glassware for cracks. Handle with care to avoid breakage and injuries.',
              Colors.green,
            ),
            _buildSafetyCard(
              Icons.cleaning_services,
              'Spill Management',
              'Neutralize acid spills with sodium bicarbonate. Clean immediately and dispose properly.',
              Colors.purple,
            ),
            _buildSafetyCard(
              Icons.fire_extinguisher,
              'Fire Safety',
              'Know location of fire extinguishers and emergency exits. Never use water on chemical fires.',
              Colors.red,
            ),
            _buildSafetyCard(
              Icons.air,
              'Fume Management',
              'Work in well-ventilated areas or fume hoods when handling volatile substances.',
              Colors.teal,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Text(
                    'Remember: Safety First!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'No chemical reactions in this section. Focus on developing safe laboratory practices and understanding emergency procedures.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyCard(IconData icon, String title, String description, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
      ),
    );
  }
}