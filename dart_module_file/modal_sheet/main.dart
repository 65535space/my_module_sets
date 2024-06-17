import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return const ModalSheetContent();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Navigation Bar Example'),
      ),
      body: Center(
        child: Text('Selected Index: $_selectedIndex'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ModalSheetContent extends StatefulWidget {
  const ModalSheetContent({super.key});

  @override
  ModalSheetContentState createState() => ModalSheetContentState();
}

class ModalSheetContentState extends State<ModalSheetContent> {
  final TextEditingController _controller = TextEditingController(text: '0');

  void _incrementValue() {
    setState(() {
      int currentValue = int.parse(_controller.text);
      _controller.text = (currentValue + 10).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter a number',
            ),
          ),
          ElevatedButton(
            onPressed: _incrementValue,
            child: const Text('Add 10'),
          ),
        ],
      ),
    );
  }
}
