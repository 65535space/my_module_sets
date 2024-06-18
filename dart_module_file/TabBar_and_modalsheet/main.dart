import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'タブナビゲーションアプリ',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSwitched = false;
  bool _isModalShown = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        if (_tabController.index == 1 && !_isModalShown) {
          _isModalShown = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const Center(child: Text('モーダルシート'));
              },
            ).whenComplete(() {
              _isModalShown = false;
            });
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('タブナビゲーションアプリ'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '設定'),
            Tab(text: '生成'),
            Tab(text: '切り替え'),
          ],
          onTap: (index) {
            if (index == 2) {
              setState(() {
                _isSwitched = !_isSwitched;
                if (_isSwitched) {
                  _tabController.index = 2;
                } else {
                  _tabController.index = 1;
                }
              });
            } else if (index == 1 && !_isModalShown) {
              _isModalShown = true;
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return const Center(child: Text('モーダルシート'));
                },
              ).whenComplete(() {
                _isModalShown = false;
              });
            }
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(child: Text('1')),
          Center(child: Text('2')), // 生成タブに移動すると「2」と表示
          Center(child: Text('3')), // 切り替えタブに移動すると「3」と表示
        ],
      ),
    );
  }
}
