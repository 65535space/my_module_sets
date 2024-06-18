import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('To Do List'),
        ),
        body: const ToDoListScreen(),
      ),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // タブバー
        TabBar(
          controller: tabController,
          tabs: const [
            Tab(text: 'リスト1'),
            Tab(text: 'リスト2'),
            Tab(text: 'リスト3'),
          ],
        ),
        // タブビュー
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: const [
              Center(child: Text('リスト1の内容')),
              Center(child: Text('リスト2の内容')),
              Center(child: Text('リスト3の内容')),
            ],
          ),
        ),
      ],
    );
  }
}
