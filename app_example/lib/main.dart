import 'package:flutter/material.dart';
import 'package:light_control_app/esp32lightdemo.dart';

import 'home/hardware_component_list_screen.dart';

void main() {
  runApp(const IoTHardwareApp());
}

class IoTHardwareApp extends StatelessWidget {
  const IoTHardwareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT Hardware Components',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF1565C0),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1565C0),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      home: HardwareListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
