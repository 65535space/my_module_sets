import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(home: MagnetometerApp(),));
}

class MagnetometerApp extends StatefulWidget {
  const MagnetometerApp({super.key});

  @override
  MagnetometerAppState createState() => MagnetometerAppState();
}

class MagnetometerAppState extends State<MagnetometerApp> {
  double _x = 0;
  double _y = 0;
  double _z = 0;

  @override
  void initState() {
    super.initState();
    magnetometerEventStream().listen((MagnetometerEvent event) {
      setState(() {
        _x = event.x;
        _y = event.y;
        _z = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magnetometer'),
      ),
      body: Center(
        child: Text('X: $_x, Y: $_y, Z: $_z'),
      ),
    );
  }
}