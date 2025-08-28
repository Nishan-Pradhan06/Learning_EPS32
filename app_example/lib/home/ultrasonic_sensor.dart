import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UltrasonicPage extends StatefulWidget {
  @override
  _UltrasonicPageState createState() => _UltrasonicPageState();
}

class _UltrasonicPageState extends State<UltrasonicPage> {
  bool enabled = false;
  int? distance;
  Timer? timer;

  Future<void> toggleSensor(bool on) async {
    final url = on
        ? Uri.parse("http://192.168.4.1/ultrasonic/enable")
        : Uri.parse("http://192.168.4.1/ultrasonic/disable");
    final response = await http.get(url);
    log(response.body);
    final data = jsonDecode(response.body);
    log(data.toString());

    setState(() {
      enabled = data['status'] == 'enabled';
      distance = data['distance'];
    });

    if (enabled) {
      timer = Timer.periodic(Duration(seconds: 1), (_) => fetchDistance());
    } else {
      timer?.cancel();
    }
  }

  Future<void> fetchDistance() async {
    final response = await http.get(
      Uri.parse("http://192.168.4.1/ultrasonic/enable"),
    );
    final data = jsonDecode(response.body);
    log(data.toString());
    if (mounted) {
      setState(() {
        distance = data['distance'];
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ultrasonic Sensor")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SwitchListTile(
            title: Text("Enable Ultrasonic Sensor"),
            value: enabled,
            onChanged: toggleSensor,
          ),
          if (enabled && distance != null)
            Text(
              "Distance: $distance cm",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
