import 'package:flutter/material.dart';

class SubScreen extends StatelessWidget {
  const SubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KBOYのFlutter大学'),
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
