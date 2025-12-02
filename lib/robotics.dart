import 'package:flutter/material.dart';

class RoboticsPage extends StatefulWidget {
  const RoboticsPage({super.key});

  @override
  State<RoboticsPage> createState() => _RoboticsPageState();
}

class _RoboticsPageState extends State<RoboticsPage> {
  int _selectedCategoryIndex = 0;
  String _searchQuery = '';
  bool _isDark = false;

  final List<ComponentCategory> _categories = [
    ComponentCategory(
      name: 'Basic Components',
      icon: Icons.electrical_services,
      color: Colors.red,
      components: [
        ComponentDetail(
          name: 'LED',
          imageUrl: 'https://raw.githubusercontent.com/OnionIoT/Onion-Docs/master/Omega2/Kit-Guides/img/led-photo.jpg',
          description: 'LED (Light Emitting Diode) is a semiconductor that emits light when current flows through it.',
          facts: [
            'Voltage drop: 2V typical',
            'Current: 20mA typical',
            'Colors: Red, Green, Blue, White, etc.',
            'Invented in 1962 by Nick Holonyak',
            'Example usage: Connect anode to Arduino pin 13 via 220Ω resistor, cathode to GND. Use digitalWrite(13, HIGH); to turn on.'
          ],
        ),
        ComponentDetail(
          name: 'Resistor',
          imageUrl: 'https://media.rs-online.com/image/upload/w_620,h_413,c_crop,c_pad,b_white,f_auto,q_auto/dpr_auto/v1482295262/F2141951-01.jpg',
          description: 'Resistors limit current flow in a circuit and are used to protect components or divide voltages.',
          facts: [
            'Resistance: 220Ω',
            'Tolerance: ±5%',
            'Power rating: 0.25W',
            'Color code for 220Ω: Red-Red-Brown-Gold',
            'Example usage: In series with LED to limit current.'
          ],
        ),
        ComponentDetail(
          name: 'Capacitor',
          imageUrl: 'https://www.build-electronic-circuits.com/wp-content/uploads/2013/05/electrolytic-capacitor.jpg',
          description: 'Capacitors store electrical energy in an electric field and are used for filtering, smoothing, and timing in circuits.',
          facts: [
            'Capacitance: 10uF',
            'Voltage rating: 16V',
            'Types: Electrolytic, Ceramic, etc.',
            'Polarized capacitors have positive and negative leads',
            'Example usage: In power supply for smoothing DC.'
          ],
        ),
        ComponentDetail(
          name: 'Transistor',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Electronic_component_transistors.jpg/1006px-Electronic_component_transistors.jpg',
          description: 'Transistors amplify or switch electronic signals and are fundamental in modern electronics.',
          facts: [
            'Type: NPN or PNP',
            'Common model: 2N2222',
            'Uses: Amplifiers, switches',
            'Beta (gain): 100-300 typical',
            'Example usage: As switch: Base to Arduino pin, collector to load, emitter to GND.'
          ],
        ),
        ComponentDetail(
          name: 'Breadboard',
          imageUrl: 'https://resources.altium.com/sites/default/files/blogs/Understanding%20the%20Nuances%20Between%20Breadboard%20Projects%20and%20Prototype%20Layouts-34411.jpg',
          description: 'Breadboards are used for prototyping electronic circuits without soldering.',
          facts: [
            'Rows: 30',
            'Columns: 5 per side',
            'Power rails included',
            'Hole spacing: 2.54mm',
            'Example usage: Build simple LED circuit with jumper wires.'
          ],
        ),
        ComponentDetail(
          name: 'Diode',
          imageUrl: 'https://www.matsusada.com/column/uploads/diode_eye-catching.jpg',
          description: 'A diode allows current to flow in one direction only, used for protection and rectification.',
          facts: [
            'Forward voltage: 0.7V for silicon',
            'Reverse breakdown voltage: Varies',
            'Types: Rectifier, Zener, Schottky',
            'Example usage: In series with coil to prevent back EMF.'
          ],
        ),
        ComponentDetail(
          name: 'Potentiometer',
          imageUrl: 'https://cdn.shopify.com/s/files/1/0075/5580/9346/files/pots_knob_big_large.JPG?v=1557956105',
          description: 'A variable resistor used to adjust resistance in a circuit, often for volume or brightness control.',
          facts: [
            'Resistance range: 10kΩ typical',
            'Types: Linear, Logarithmic',
            'Pins: 3 (ends and wiper)',
            'Example usage: Connect to analog pin for reading variable value.'
          ],
        ),
      ],
    ),
    ComponentCategory(
      name: 'Microcontrollers',
      icon: Icons.memory,
      color: Colors.blue,
      components: [
        ComponentDetail(
          name: 'Arduino Uno',
          imageUrl: 'https://m.media-amazon.com/images/I/71ok6q+8tEL._AC_UF894,1000_QL80_.jpg',
          description: 'Arduino Uno is a microcontroller board based on ATmega328P. It can read inputs and control outputs.',
          facts: [
            'Voltage: 5V',
            'Digital pins: 14',
            'Analog pins: 6',
            'Applications: Robotics, IoT, DIY projects',
            'Clock speed: 16MHz',
            'Example usage: Blink LED with built-in sketch.'
          ],
        ),
        ComponentDetail(
          name: 'Raspberry Pi 4',
          imageUrl: 'https://assets.raspberrypi.com/static/raspberry-pi-4-labelled-f5e5dcdf6a34223235f83261fa42d1e8.png',
          description: 'Raspberry Pi 4 is a small computer used for education, projects, and IoT.',
          facts: [
            'Processor: Quad-core ARM',
            'RAM: Up to 8GB',
            'Ports: USB, HDMI, Ethernet',
            'OS: Raspberry Pi OS',
            'Example usage: Run Python scripts for automation.'
          ],
        ),
        ComponentDetail(
          name: 'ESP32',
          imageUrl: 'https://predictabledesigns.com/wp-content/uploads/2024/01/ESP32-S3-Development-Board800.jpg',
          description: 'ESP32 is a low-cost microcontroller with Wi-Fi and Bluetooth capabilities.',
          facts: [
            'Dual-core',
            'Built-in Wi-Fi/BT',
            'GPIO pins: 34',
            'Low power modes',
            'Example usage: Connect to WiFi and send data to server.'
          ],
        ),
      ],
    ),
    ComponentCategory(
      name: 'Sensors',
      icon: Icons.sensors,
      color: Colors.green,
      components: [
        ComponentDetail(
          name: 'Ultrasonic Sensor',
          imageUrl: 'https://images.squarespace-cdn.com/content/v1/59b037304c0dbfb092fbe894/1557185784190-F6OMCM0Z53HPFUVYLL8J/front_main.JPG',
          description: 'Ultrasonic sensors measure distance by using ultrasonic waves and echo time measurement.',
          facts: [
            'Range: 2cm to 400cm',
            'Voltage: 5V',
            'Used in obstacle detection',
            'Accuracy: ±3mm',
            'Example usage: Trigger pin high for 10us, measure echo pulse width.'
          ],
        ),
        ComponentDetail(
          name: 'DHT22',
          imageUrl: 'https://files.readme.io/57b2f62-g01_a_alicdn_com_kf_HTB1mQiQJVXXXXX9apXXq6xXFXXXm_2016-New-3Pcs-Lot-DHT22-AM2302-Digital-Temperature-Humidity-Sensor-Temperature-and-humidity-Module-Replacement-SHT11_jpg.png',
          description: 'DHT22 is a digital temperature and humidity sensor.',
          facts: [
            'Temperature range: -40 to 80°C',
            'Humidity range: 0-100%',
            'Accuracy: ±0.5°C, ±2% RH',
            'Digital output',
            'Example usage: Use DHT library in Arduino to read values.'
          ],
        ),
        ComponentDetail(
          name: 'PIR Motion Sensor',
          imageUrl: 'https://cdn-learn.adafruit.com/assets/assets/000/013/829/medium800/proximity_PIRbackLabeled.jpg?1390935476',
          description: 'PIR sensors detect motion by measuring infrared radiation.',
          facts: [
            'Detection range: 7m',
            'Voltage: 5V',
            'Used in security systems',
            'Adjustable sensitivity and delay',
            'Example usage: Digital read on pin for motion detection.'
          ],
        ),
        ComponentDetail(
          name: 'IR Sensor',
          imageUrl: 'https://i.ebayimg.com/images/g/790AAMXQrhdTUkr8/s-l1200.jpg',
          description: 'Infrared sensor for detecting obstacles or line following.',
          facts: [
            'Range: 2-30cm',
            'Voltage: 5V',
            'Output: Digital or analog',
            'Example usage: In robot for line tracking.'
          ],
        ),
        ComponentDetail(
          name: 'LDR',
          imageUrl: 'https://i0.wp.com/kmindustrialcorp.com/wp-content/uploads/2024/07/LDR-Sensor.webp?ssl=1',
          description: 'Light Dependent Resistor changes resistance based on light intensity.',
          facts: [
            'Resistance: High in dark, low in light',
            'Used in light sensing circuits',
            'Example usage: Voltage divider with resistor, read analog value.'
          ],
        ),
      ],
    ),
    ComponentCategory(
      name: 'Motors & Actuators',
      icon: Icons.settings,
      color: Colors.orange,
      components: [
        ComponentDetail(
          name: 'DC Motor',
          imageUrl: 'https://www.automate.org/userAssets/mcaUploads/image/Benefits%20of%20DC%20Motors%20and%20Why%20They%E2%80%99re%20Great%20for%20Robotics.jpeg',
          description: 'A DC motor converts electrical energy into mechanical rotation.',
          facts: [
            'Voltage: 6-12V',
            'Applications: Robots, fans, toys',
            'Speed control with PWM',
            'Example usage: Use H-bridge like L298N to control direction.'
          ],
        ),
        ComponentDetail(
          name: 'Servo Motor SG90',
          imageUrl: 'https://europe1.discourse-cdn.com/arduino/original/4X/7/6/b/76b1f1add53fca530a1294c06fbdf0cc277be32b.jpeg',
          description: 'Servo motors provide precise angular control.',
          facts: [
            'Torque: 1.8 kg-cm',
            'Angle: 180 degrees',
            'Voltage: 4.8-6V',
            'Pulse width: 1-2ms',
            'Example usage: Use Servo library, attach to pin, write angle.'
          ],
        ),
        ComponentDetail(
          name: 'Stepper Motor NEMA 17',
          imageUrl: 'https://cdn-shop.adafruit.com/970x728/324-03.jpg',
          description: 'Stepper motors move in precise steps, ideal for positioning.',
          facts: [
            'Steps per rev: 200',
            'Torque: 45 N-cm',
            'Voltage: 12V',
            'Bipolar or unipolar',
            'Example usage: Use Stepper library or A4988 driver.'
          ],
        ),
        ComponentDetail(
          name: 'Solenoid',
          imageUrl: 'https://ecstudiosystems.com/discover/textbooks/basic-electronics/sensors-and-actuators/images/solenoid-action.jpg',
          description: 'Solenoid is an electromagnet that creates linear motion.',
          facts: [
            'Voltage: 12V typical',
            'Used in locks, valves',
            'Push or pull type',
            'Example usage: Control with transistor switch.'
          ],
        ),
      ],
    ),
    ComponentCategory(
      name: 'Displays',
      icon: Icons.monitor,
      color: Colors.purple,
      components: [
        ComponentDetail(
          name: 'LCD 16x2',
          imageUrl: 'https://cdn-shop.adafruit.com/970x728/181-08.jpg',
          description: 'Liquid Crystal Display for showing text in 16 columns and 2 rows.',
          facts: [
            'Voltage: 5V',
            'Backlight: Yes',
            'Interface: Parallel or I2C',
            'Example usage: Use LiquidCrystal library, print text.'
          ],
        ),
        ComponentDetail(
          name: 'OLED SSD1306',
          imageUrl: 'https://esphome.io/images/ssd1306-full.jpg',
          description: 'Organic LED display for graphics and text, high contrast.',
          facts: [
            'Resolution: 128x64',
            'Voltage: 3.3V',
            'Interface: I2C or SPI',
            'Example usage: Use Adafruit_SSD1306 library to draw.'
          ],
        ),
      ],
    ),
    ComponentCategory(
      name: 'Communication',
      icon: Icons.bluetooth,
      color: Colors.teal,
      components: [
        ComponentDetail(
          name: 'HC-05 Bluetooth',
          imageUrl: 'https://media.geeksforgeeks.org/wp-content/uploads/20200524231402/hc051.jpg',
          description: 'Bluetooth module for wireless serial communication.',
          facts: [
            'Range: 10m',
            'Voltage: 5V',
            'Baud rate: 9600 default',
            'Example usage: Pair with phone, send/receive data via Serial.'
          ],
        ),
      ],
    ),
    ComponentCategory(
      name: 'Power Supplies',
      icon: Icons.battery_charging_full,
      color: Colors.yellow.shade800,
      components: [
        ComponentDetail(
          name: '9V Battery',
          imageUrl: 'https://webobjects2.cdw.com/is/image/CDW/5499085?\$product-main\$',
          description: 'Portable power source for small projects.',
          facts: [
            'Voltage: 9V',
            'Capacity: 500mAh typical',
            'Type: Alkaline or rechargeable',
            'Example usage: Power Arduino via Vin pin.'
          ],
        ),
        ComponentDetail(
          name: 'LM7805 Voltage Regulator',
          imageUrl: 'https://www.circuits-diy.com/wp-content/uploads/2021/08/7805-regulator-circuit.jpg',
          description: 'Linear regulator to provide stable 5V output.',
          facts: [
            'Input: 7-35V',
            'Output: 5V, 1A',
            'Needs heat sink for high current',
            'Example usage: Regulate 9V to 5V for microcontroller.'
          ],
        ),
      ],
    ),
  ];

  late List<ComponentDetail> _allComponents;

  @override
  void initState() {
    super.initState();
    _allComponents = _categories.expand((cat) => cat.components).toList();
  }

  @override
  Widget build(BuildContext context) {
    final category = _categories[_selectedCategoryIndex];
    final isDark = _isDark;
    final backgroundColors = isDark
        ? [Colors.black, Colors.grey.shade900]
        : [Colors.blue.shade100, Colors.white];
    final textColor = isDark ? Colors.white : Colors.black;
    final cardColor = isDark ? Colors.grey.shade800 : Colors.white;

    final displayedComponents = _searchQuery.isEmpty
        ? category.components
        : _allComponents
        .where((comp) => comp.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Robotics & Electronics', style: TextStyle(color: textColor)),
        backgroundColor: isDark ? Colors.black : Colors.blue.shade800,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.brightness_7 : Icons.brightness_4, color: textColor),
            onPressed: () => setState(() => _isDark = !_isDark),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: backgroundColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            _buildCategorySelector(isDark, textColor),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search components...',
                  hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
                  prefixIcon: Icon(Icons.search, color: textColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: textColor),
                  ),
                  filled: true,
                  fillColor: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                ),
                style: TextStyle(color: textColor),
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: displayedComponents.length,
                itemBuilder: (context, index) {
                  final component = displayedComponents[index];
                  return _buildComponentCard(component, isDark, textColor, cardColor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector(bool isDark, Color textColor) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final selected = index == _selectedCategoryIndex;
          return GestureDetector(
            onTap: () => setState(() {
              _selectedCategoryIndex = index;
              _searchQuery = ''; // Reset search when changing category
            }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selected ? cat.color : (isDark ? Colors.grey.shade700 : Colors.grey.shade200),
                borderRadius: BorderRadius.circular(12),
                boxShadow: selected
                    ? [BoxShadow(color: cat.color.withOpacity(0.5), blurRadius: 5)]
                    : null,
              ),
              child: Row(
                children: [
                  Icon(cat.icon, color: selected ? Colors.white : textColor),
                  const SizedBox(width: 6),
                  Text(
                    cat.name,
                    style: TextStyle(
                      color: selected ? Colors.white : textColor,
                      fontWeight: FontWeight.w600,
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

  Widget _buildComponentCard(ComponentDetail component, bool isDark, Color textColor, Color cardColor) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: cardColor,
      child: ExpansionTile(
        leading: Image.network(
          component.imageUrl,
          width: 50,
          height: 50,
          errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 50, color: textColor),
        ),
        title: Text(
          component.name,
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
        childrenPadding: const EdgeInsets.all(16),
        children: [
          Text(component.description, style: TextStyle(color: textColor)),
          const SizedBox(height: 10),
          Text('Facts:', style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
          ...component.facts.map(
                (f) => ListTile(
              leading: Icon(Icons.check_circle_outline, color: Colors.green),
              title: Text(f, style: TextStyle(color: textColor)),
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}

// Supporting Classes
class ComponentCategory {
  final String name;
  final IconData icon;
  final Color color;
  final List<ComponentDetail> components;

  ComponentCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.components,
  });
}

class ComponentDetail {
  final String name;
  final String imageUrl;
  final String description;
  final List<String> facts;

  ComponentDetail({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.facts,
  });
}