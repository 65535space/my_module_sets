import 'package:flutter/material.dart';

class ItemBox extends StatefulWidget {
  final bool isVisible;

  const ItemBox(this.isVisible, {super.key});

  @override
  State<ItemBox> createState() => _ItemBoxState();
}

class _ItemBoxState extends State<ItemBox> {
  late bool isVisible;

  @override
  void initState() {
    super.initState();
    isVisible = widget.isVisible; // 初期値を親widgetから取得
  }

  void reverseValue() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          Visibility(
            visible: isVisible,
            child: FloatingActionButton(
              onPressed: () {
                reverseValue();
              },
              child: const Icon(Icons.star),
            ),
          ),
          Visibility(
            visible: !isVisible,
            child: FloatingActionButton(
              onPressed: () {
                reverseValue();
              },
              child: const Icon(Icons.nordic_walking),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Text('KBOYのFlutter大学'),
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
