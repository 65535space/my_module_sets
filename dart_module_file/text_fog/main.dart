import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Positioned.fill Example'),
        ),
        body: Stack(
          children: [
            const Center(
              child: Text('Centered Text'),
            ),
            Positioned.fill(
              child: Container(
                color: Colors.red.withOpacity(0.9), // 半透明の赤色コンテナ
              ),
            ),
          ],
        ),
      ),
    );
  }
}
