import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ESP32LightDemo extends StatefulWidget {
  const ESP32LightDemo({super.key});

  @override
  State<ESP32LightDemo> createState() => _ESP32LightDemoState();
}

class _ESP32LightDemoState extends State<ESP32LightDemo>
    with SingleTickerProviderStateMixin {
  bool isLightOn = false;
  bool isConnected = true; // Simulate connection status
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> handleLight(String cmd) async {
    try {
      final url = Uri.parse("http://192.168.4.1/$cmd");
      final response = await http.get(url).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        setState(() {
          isConnected = true;
        });
      }
    } catch (e) {
      setState(() {
        isConnected = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connection failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void toggleLight() {
    setState(() {
      isLightOn = !isLightOn;
    });

    if (isLightOn) {
      handleLight("led/on");
    } else {
      handleLight("led/off");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'ESP32 Light Control',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF1565C0),
          foregroundColor: Colors.white,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: const [
              Tab(icon: Icon(Icons.control_camera), text: 'Control'),
              Tab(icon: Icon(Icons.electrical_services), text: 'Circuit'),
              Tab(icon: Icon(Icons.code), text: 'Flutter Code'),
              Tab(icon: Icon(Icons.memory), text: 'ESP32 Code'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildControlTab(),
            _buildCircuitTab(),
            _buildFlutterCodeTab(),
            _buildESP32CodeTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildControlTab() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey[50]!, Colors.grey[100]!],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Connection Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: isConnected ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    isConnected ? 'Connected to ESP32' : 'Disconnected',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isConnected ? Colors.green[700] : Colors.red[700],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '192.168.4.1',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Light Control Card
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Light Bulb Animation
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: isLightOn
                            ? Colors.yellow.withOpacity(0.2)
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(60),
                        boxShadow: isLightOn
                            ? [
                                BoxShadow(
                                  color: Colors.yellow.withOpacity(0.4),
                                  spreadRadius: 10,
                                  blurRadius: 20,
                                ),
                              ]
                            : [],
                      ),
                      child: Icon(
                        Icons.lightbulb,
                        size: 60,
                        color: isLightOn
                            ? Colors.yellow[600]
                            : Colors.grey[400],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Status Text
                    Text(
                      isLightOn ? "LIGHT IS ON" : "LIGHT IS OFF",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isLightOn
                            ? Colors.orange[700]
                            : Colors.grey[600],
                        letterSpacing: 1.2,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Control Button
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      child: ElevatedButton(
                        onPressed: toggleLight,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isLightOn
                              ? Colors.red[400]
                              : Colors.green[400],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 5,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isLightOn ? Icons.power_off : Icons.power,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isLightOn ? 'TURN OFF LIGHT' : 'TURN ON LIGHT',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircuitTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Circuit Diagram',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Circuit diagram placeholder
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.electrical_services,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'ESP32 + LED Circuit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Circuit diagram would be displayed here',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Components List
          const Text(
            'Required Components',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildComponentCard(
            'ESP32 Development Board',
            'Microcontroller',
            Icons.memory,
          ),
          _buildComponentCard(
            'LED (Any Color)',
            'Output Device',
            Icons.lightbulb_outline,
          ),
          _buildComponentCard(
            '220Ω Resistor',
            'Current Limiting',
            Icons.electrical_services,
          ),
          _buildComponentCard('Breadboard', 'Prototyping', Icons.grid_on),
          _buildComponentCard('Jumper Wires', 'Connections', Icons.cable),

          const SizedBox(height: 24),

          // Connection Instructions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue[600]),
                    const SizedBox(width: 8),
                    Text(
                      'Connection Instructions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  '1. Connect LED positive leg to ESP32 GPIO 2 through 220Ω resistor',
                ),
                const Text('2. Connect LED negative leg to ESP32 GND'),
                const Text('3. Power ESP32 via USB or external supply'),
                const Text(
                  '4. Configure ESP32 as WiFi Access Point (192.168.4.1)',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentCard(String name, String description, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[600], size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlutterCodeTab() {
    const flutterCode = '''import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ESP32LightDemo extends StatefulWidget {
  const ESP32LightDemo({super.key});

  @override
  State<ESP32LightDemo> createState() => _ESP32LightDemoState();
}

class _ESP32LightDemoState extends State<ESP32LightDemo> {
  bool isLightOn = false;

  Future<void> handleLight(String cmd) async {
    try {
      final url = Uri.parse("http://192.168.4.1/\$cmd");
      final response = await http.get(url).timeout(Duration(seconds: 5));
      
      if (response.statusCode == 200) {
        print('Command sent successfully: \$cmd');
      }
    } catch (e) {
      print('Error: \$e');
    }
  }

  void toggleLight() {
    setState(() {
      isLightOn = !isLightOn;
    });

    if (isLightOn) {
      handleLight("led/on");
    } else {
      handleLight("led/off");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ESP32 Light Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLightOn ? "LIGHT IS ON" : "LIGHT IS OFF",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleLight,
              child: Text(
                isLightOn ? 'TURN OFF LIGHT' : 'TURN ON LIGHT',
              ),
            ),
          ],
        ),
      ),
    );
  }
}''';

    return _buildCodeTab('Flutter Code', flutterCode, 'dart');
  }

  Widget _buildESP32CodeTab() {
    const esp32Code = '''#include <WiFi.h>
#include <WebServer.h>

// WiFi credentials
const char* ssid = "ESP32-Light-Control";
const char* password = "12345678";

// LED pin
const int ledPin = 2;

// Create web server on port 80
WebServer server(80);

void setup() {
  Serial.begin(115200);
  
  // Initialize LED pin
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW);
  
  // Start WiFi Access Point
  WiFi.softAP(ssid, password);
  Serial.println("Access Point Started");
  Serial.print("IP address: ");
  Serial.println(WiFi.softAPIP());
  
  // Define routes
  server.on("/led/on", HTTP_GET, handleLedOn);
  server.on("/led/off", HTTP_GET, handleLedOff);
  server.on("/", HTTP_GET, handleRoot);
  
  // Start server
  server.begin();
  Serial.println("HTTP server started");
}

void loop() {
  server.handleClient();
}

void handleRoot() {
  String html = "<html><body>";
  html += "<h1>ESP32 Light Control</h1>";
  html += "<p><a href='/led/on'>Turn LED ON</a></p>";
  html += "<p><a href='/led/off'>Turn LED OFF</a></p>";
  html += "</body></html>";
  
  server.send(200, "text/html", html);
}

void handleLedOn() {
  digitalWrite(ledPin, HIGH);
  Serial.println("LED turned ON");
  server.send(200, "text/plain", "LED is ON");
}

void handleLedOff() {
  digitalWrite(ledPin, LOW);
  Serial.println("LED turned OFF");
  server.send(200, "text/plain", "LED is OFF");
}''';

    return _buildCodeTab('ESP32 Arduino Code', esp32Code, 'cpp');
  }

  Widget _buildCodeTab(String title, String code, String language) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: code));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Code copied to clipboard!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.copy, size: 16),
                label: const Text('Copy'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: SelectableText(
              code,
              style: const TextStyle(
                fontFamily: 'Courier',
                fontSize: 12,
                color: Color(0xFFD4D4D4),
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (language == 'dart') _buildFlutterInstructions(),
          if (language == 'cpp') _buildESP32Instructions(),
        ],
      ),
    );
  }

  Widget _buildFlutterInstructions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.green[600]),
              const SizedBox(width: 8),
              Text(
                'Flutter Setup Instructions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('1. Add http dependency to pubspec.yaml:'),
          const Text('   dependencies:'),
          const Text('     http: ^1.1.0'),
          const SizedBox(height: 8),
          const Text('2. Run: flutter pub get'),
          const Text('3. Ensure your device is connected to ESP32 WiFi'),
          const Text('4. Run the Flutter app'),
        ],
      ),
    );
  }

  Widget _buildESP32Instructions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.orange[600]),
              const SizedBox(width: 8),
              Text(
                'ESP32 Setup Instructions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('1. Install ESP32 board package in Arduino IDE'),
          const Text('2. Select ESP32 Dev Module as board'),
          const Text('3. Connect ESP32 to computer via USB'),
          const Text('4. Upload this code to ESP32'),
          const Text('5. Connect to "ESP32-Light-Control" WiFi network'),
          const Text('6. Password: 12345678'),
        ],
      ),
    );
  }
}
