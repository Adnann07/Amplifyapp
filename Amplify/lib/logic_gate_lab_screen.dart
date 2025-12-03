import 'package:flutter/material.dart';

class LogicGateLabScreen extends StatefulWidget {
  const LogicGateLabScreen({super.key});

  @override
  _LogicGateLabScreenState createState() => _LogicGateLabScreenState();
}

class _LogicGateLabScreenState extends State<LogicGateLabScreen> {
  // State variables for switches
  bool switchA = false;
  bool switchB = false;

  // Selected Gate (Default to AND)
  String selectedGate = 'AND';
  final List<String> gates = ['AND', 'OR', 'NOT', 'NAND', 'NOR', 'XOR'];

  // Calculate Output based on selected gate
  bool get output {
    switch (selectedGate) {
      case 'AND': return switchA && switchB;
      case 'OR':  return switchA || switchB;
      case 'NOT': return !switchA; // NOT only uses Switch A
      case 'NAND': return !(switchA && switchB);
      case 'NOR': return !(switchA || switchB);
      case 'XOR': return switchA ^ switchB;
      default: return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Digital Logic Lab'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildGateSelector(),
            const SizedBox(height: 40),
            _buildCircuitDiagram(),
            const SizedBox(height: 40),
            _buildTruthTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildGateSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedGate,
          dropdownColor: Colors.blueGrey[800],
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          items: gates.map((String gate) {
            return DropdownMenuItem<String>(
              value: gate,
              child: Text('$gate GATE'),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedGate = newValue!;
              // Reset switches for NOT gate clarity
              if (selectedGate == 'NOT') switchB = false;
            });
          },
        ),
      ),
    );
  }

  // --- FIX: Wrapped Row in SingleChildScrollView to prevent overflow ---
  Widget _buildCircuitDiagram() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Inputs
          Column(
            children: [
              _buildSwitch('Input A', switchA, (val) => setState(() => switchA = val)),
              if (selectedGate != 'NOT') ...[
                const SizedBox(height: 30),
                _buildSwitch('Input B', switchB, (val) => setState(() => switchB = val)),
              ],
            ],
          ),

          // Wires to Gate
          SizedBox(
            width: 50,
            height: 100,
            child: CustomPaint(
              painter: CircuitWirePainter(isSingleInput: selectedGate == 'NOT'),
            ),
          ),

          // The Gate Icon
          _buildGateIcon(),

          // Wire to Output
          Container(height: 2, width: 40, color: Colors.yellow),

          // Output LED
          _buildLED(output),
        ],
      ),
    );
  }

  Widget _buildSwitch(String label, bool value, Function(bool) onChanged) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.cyanAccent,
          activeTrackColor: Colors.cyan.withOpacity(0.3),
        ),
        Text(value ? "1" : "0", style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildGateIcon() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blueGrey[700],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white24),
      ),
      child: Center(
        child: Text(
          selectedGate,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildLED(bool isOn) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: isOn ? Colors.greenAccent : Colors.red[900],
            shape: BoxShape.circle,
            boxShadow: isOn
                ? [
              BoxShadow(color: Colors.greenAccent.withOpacity(0.6), blurRadius: 20, spreadRadius: 5),
              const BoxShadow(color: Colors.white, blurRadius: 5, spreadRadius: 1),
            ]
                : [],
          ),
          child: Icon(
            Icons.lightbulb,
            color: isOn ? Colors.white : Colors.white24,
            size: 30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isOn ? "OUTPUT: 1" : "OUTPUT: 0",
          style: TextStyle(
            color: isOn ? Colors.greenAccent : Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTruthTable() {
    // Simplistic truth table for the selected gate
    return Card(
      color: Colors.blueGrey[800],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('$selectedGate Truth Table', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Table(
              border: TableBorder.all(color: Colors.white24),
              children: [
                const TableRow(children: [
                  Center(child: Text('A', style: TextStyle(color: Colors.cyanAccent))),
                  Center(child: Text('B', style: TextStyle(color: Colors.cyanAccent))),
                  Center(child: Text('Out', style: TextStyle(color: Colors.yellowAccent))),
                ]),
                ..._getTruthRows().map((row) {
                  bool isActive = (row[0] == (switchA ? 1 : 0)) &&
                      (selectedGate == 'NOT' ? true : row[1] == (switchB ? 1 : 0));

                  return TableRow(
                      decoration: BoxDecoration(color: isActive ? Colors.white10 : null),
                      children: [
                        Center(child: Text(row[0].toString(), style: const TextStyle(color: Colors.white))),
                        Center(child: Text(selectedGate == 'NOT' ? '-' : row[1].toString(), style: const TextStyle(color: Colors.white))),
                        Center(child: Text(row[2].toString(), style: const TextStyle(color: Colors.white))),
                      ]);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<List<int>> _getTruthRows() {
    // Returns [A, B, Out]
    switch (selectedGate) {
      case 'AND': return [[0,0,0], [0,1,0], [1,0,0], [1,1,1]];
      case 'OR':  return [[0,0,0], [0,1,1], [1,0,1], [1,1,1]];
      case 'NOT': return [[0,0,1], [1,0,0]]; // B is ignored
      case 'NAND':return [[0,0,1], [0,1,1], [1,0,1], [1,1,0]];
      case 'NOR': return [[0,0,1], [0,1,0], [1,0,0], [1,1,0]];
      case 'XOR': return [[0,0,0], [0,1,1], [1,0,1], [1,1,0]];
      default: return [];
    }
  }
}

// Simple painter to draw lines connecting switches to gate
class CircuitWirePainter extends CustomPainter {
  final bool isSingleInput;
  CircuitWirePainter({required this.isSingleInput});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    if (isSingleInput) {
      // Draw single line from center
      canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
    } else {
      // Draw two lines converging
      // Top wire
      canvas.drawLine(Offset(0, size.height * 0.25), Offset(size.width * 0.5, size.height * 0.25), paint);
      canvas.drawLine(Offset(size.width * 0.5, size.height * 0.25), Offset(size.width * 0.5, size.height * 0.45), paint);

      // Bottom wire
      canvas.drawLine(Offset(0, size.height * 0.75), Offset(size.width * 0.5, size.height * 0.75), paint);
      canvas.drawLine(Offset(size.width * 0.5, size.height * 0.75), Offset(size.width * 0.5, size.height * 0.55), paint);

      // Connector to gate
      canvas.drawLine(Offset(size.width * 0.5, size.height * 0.45), Offset(size.width, size.height * 0.45), paint);
      canvas.drawLine(Offset(size.width * 0.5, size.height * 0.55), Offset(size.width, size.height * 0.55), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
