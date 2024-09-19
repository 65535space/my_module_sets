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
        backgroundColor: const Color(0xFFE0ECF9), // 背景の色
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40), // 上部の余白
              const Text(
                '○×クイズ',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                '正解すると取得経験値アップ！',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 40), // タイトルと本文の間のスペース
              const Text(
                '環状交差点で左折、右折、直進、転回する時は、あらかじめできるだけ道路の左端に寄り、環状交差点の側端に沿って十分速度を落として通行しなければならない。',
                style: TextStyle(fontSize: 18),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[100], // ボタンの色
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(24),
                    ),
                    onPressed: () {
                      // ○ボタンの処理
                    },
                    child: const Text(
                      '○',
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[100], // ボタンの色
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(24),
                    ),
                    onPressed: () {
                      // ×ボタンの処理
                    },
                    child: const Text(
                      '×',
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // ボタンとスキップの間の余白
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // スキップボタンの処理
                  },
                  child: const Text('スキップ'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
