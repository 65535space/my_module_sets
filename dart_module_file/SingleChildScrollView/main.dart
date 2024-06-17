import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SingleChildScrollViewの仕様の確認',
      home: Column(children: [Header()]),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SingleChildScrollViewの仕様の確認"),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [HoraizontalList()],
      ),
    );
  }
}

class HoraizontalList extends StatefulWidget {
  const HoraizontalList({super.key});

  @override
  HoraizontalListState createState() => HoraizontalListState();
}

class HoraizontalListState extends State<HoraizontalList> {
  List<Widget> buttons = [];

  void addButton() {
    setState(() {
      buttons.add(
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(0, 255, 255, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            elevation: 0,
          ),
          child: Text("${buttons.length + 1}"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const IconButton(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              icon: Icon(Icons.star),
              iconSize: 25,
              onPressed: null,
            ),
            ...buttons,
            TextButton(
              onPressed: () {
                addButton();
              },
              child: const Row(
                children: [
                  Icon(Icons.add),
                  Text("新しいリスト"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
