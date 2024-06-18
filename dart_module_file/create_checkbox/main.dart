import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TaskSetState(),
    );
  }
}

class TaskSetState extends StatefulWidget {
  const TaskSetState({super.key});

  @override
  TaskSetStateState createState() => TaskSetStateState();
}

class TaskSetStateState extends State<TaskSetState> {
  List<Widget> taskList = [];

  void addTask(String taskName) {
    setState(() {
      taskList.add(TaskWidget(taskName: taskName));
    });
    debugPrint('Adding task: $taskName'); // デバッグメッセージを追加
    debugPrint('Current tasks: ${taskList.length}'); // 現在のタスクリストの長さを表示
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                return taskList[index];
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTask('New Task');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskWidget extends StatefulWidget {
  final String taskName;

  const TaskWidget({super.key, required this.taskName});

  @override
  TaskWidgetState createState() => TaskWidgetState();
}

class TaskWidgetState extends State<TaskWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        },
      ),
      title: Text(widget.taskName),
    );
  }
}
