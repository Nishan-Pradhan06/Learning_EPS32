import 'package:flutter/material.dart';

import '../core/model/iot_component.dart';
import '../esp32lightdemo.dart';

class HardwareListScreen extends StatelessWidget {
  final void Function()? onTap;
  HardwareListScreen({super.key, this.onTap});

  final List<IoTComponent> iotComponents = [
    IoTComponent(
      name: 'LED Light',
      description: 'Light Emitting Diode for visual indication',
      icon: Icons.lightbulb_outline,
      category: 'Output Device',
      color: Color(0xFFFFB300),
      specifications: [
        'Voltage: 1.8V - 3.3V',
        'Current: 20mA max',
        'Colors: Red, Green, Blue, White',
        'Lifespan: 50,000+ hours',
      ],
      usage: 'Status indication, alerts, decorative lighting',
      onTap: (context) {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => ESP32LightDemo()));
      },
    ),

    IoTComponent(
      name: 'Ultrasonic Sensor (HC-SR04)',
      description: 'Distance measurement using ultrasonic waves',
      icon: Icons.radar,
      category: 'Distance Sensor',
      color: Color(0xFF26A69A),
      specifications: [
        'Range: 2cm - 400cm',
        'Accuracy: ±3mm',
        'Frequency: 40kHz',
        'Voltage: 5V DC',
      ],
      usage: 'Obstacle detection, distance measurement, parking sensors',
    ),
    IoTComponent(
      name: 'LDR (Light Dependent Resistor)',
      description: 'Photoresistor that changes resistance with light',
      icon: Icons.wb_sunny,
      category: 'Light Sensor',
      color: Color(0xFFFF7043),
      specifications: [
        'Dark resistance: 1MΩ',
        'Light resistance: 10-20kΩ',
        'Voltage: 3.3V - 5V',
        'Response time: 20-30ms',
      ],
      usage: 'Automatic lighting, light intensity monitoring',
    ),
    IoTComponent(
      name: 'DHT22 Temperature & Humidity',
      description: 'Digital temperature and humidity sensor',
      icon: Icons.thermostat,
      category: 'Environmental Sensor',
      color: Color(0xFF42A5F5),
      specifications: [
        'Temperature: -40°C to 80°C',
        'Humidity: 0-100% RH',
        'Accuracy: ±0.5°C, ±2% RH',
        'Voltage: 3.3V - 6V',
      ],
      usage: 'Weather monitoring, HVAC control, indoor climate',
    ),
    IoTComponent(
      name: 'PIR Motion Sensor',
      description: 'Passive Infrared motion detection sensor',
      icon: Icons.directions_run,
      category: 'Motion Sensor',
      color: Color(0xFFAB47BC),
      specifications: [
        'Detection range: 7 meters',
        'Detection angle: 110°',
        'Voltage: 4.5V - 20V',
        'Current: <50µA',
      ],
      usage: 'Security systems, automatic lighting, presence detection',
    ),
    IoTComponent(
      name: 'Servo Motor (SG90)',
      description: 'Precise angular position control motor',
      icon: Icons.settings,
      category: 'Actuator',
      color: Color(0xFF66BB6A),
      specifications: [
        'Rotation: 180° (90° each direction)',
        'Torque: 1.8kg/cm',
        'Speed: 0.1s/60°',
        'Voltage: 4.8V - 6V',
      ],
      usage: 'Robotic arms, camera pan/tilt, automated doors',
    ),
    IoTComponent(
      name: 'Buzzer',
      description: 'Audio output device for alerts and notifications',
      icon: Icons.volume_up,
      category: 'Output Device',
      color: Color(0xFFEF5350),
      specifications: [
        'Frequency: 2-4kHz',
        'Sound pressure: 85dB',
        'Voltage: 3V - 24V',
        'Current: 30mA',
      ],
      usage: 'Alarms, notifications, audio feedback',
    ),
    IoTComponent(
      name: 'Relay Module',
      description: 'Electrically operated switch for high power loads',
      icon: Icons.power,
      category: 'Switch',
      color: Color(0xFF8D6E63),
      specifications: [
        'Contact rating: 10A 250VAC',
        'Coil voltage: 5V DC',
        'Switching time: 10ms',
        'Isolation: 4000V',
      ],
      usage: 'Home automation, motor control, appliance switching',
    ),
    IoTComponent(
      name: 'Gas Sensor (MQ-2)',
      description: 'Detects LPG, smoke, alcohol, propane, hydrogen',
      icon: Icons.air,
      category: 'Gas Sensor',
      color: Color(0xFF9C27B0),
      specifications: [
        'Detection: LPG, Propane, Hydrogen',
        'Concentration: 300-10000ppm',
        'Voltage: 5V DC',
        'Preheat time: 20 seconds',
      ],
      usage: 'Gas leak detection, air quality monitoring, safety systems',
    ),
    IoTComponent(
      name: 'OLED Display (128x64)',
      description: 'Small monochrome display for data visualization',
      icon: Icons.monitor,
      category: 'Display',
      color: Color(0xFF607D8B),
      specifications: [
        'Resolution: 128x64 pixels',
        'Interface: I2C/SPI',
        'Voltage: 3.3V - 5V',
        'Viewing angle: 160°',
      ],
      usage: 'Data display, status monitoring, user interface',
    ),
    IoTComponent(
      name: 'Push Button',
      description: 'Momentary switch for user input',
      icon: Icons.radio_button_unchecked,
      category: 'Input Device',
      color: Color(0xFF795548),
      specifications: [
        'Contact rating: 50mA 12V DC',
        'Operating force: 2.55N',
        'Life cycle: 1,000,000 operations',
        'Material: Tactile plastic',
      ],
      usage: 'User input, mode selection, system control',
    ),
    IoTComponent(
      name: 'RGB LED Strip',
      description: 'Addressable multi-color LED strip',
      icon: Icons.color_lens,
      category: 'Output Device',
      color: Color(0xFFE91E63),
      specifications: [
        'LEDs per meter: 30/60/144',
        'Colors: 16.7 million',
        'Voltage: 5V DC',
        'Protocol: WS2812B',
      ],
      usage: 'Decorative lighting, mood lighting, displays',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'IoT Hardware Components',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.developer_board,
                  color: Theme.of(context).primaryColor,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ESP32 Compatible Components',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        '${iotComponents.length} components available',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: iotComponents.length,
              itemBuilder: (context, index) {
                final component = iotComponents[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: component.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        component.icon,
                        color: component.color,
                        size: 28,
                      ),
                    ),
                    title: Text(
                      component.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          component.description,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: component.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            component.category,
                            style: TextStyle(
                              color: component.color,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[400],
                      size: 16,
                    ),
                    onTap: component.onTap != null
                        ? () => component.onTap!(context)
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
