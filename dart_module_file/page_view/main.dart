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
          title: const Text('Dynamic PageView'),
        ),
        body: const DynamicPageView(),
      ),
    );
  }
}

class DynamicPageView extends StatefulWidget {
  const DynamicPageView({super.key});

  @override

  DynamicPageViewState createState() => DynamicPageViewState();
}

class DynamicPageViewState extends State<DynamicPageView> {
  final PageController _pageController = PageController();
  List<String> pages = ['Page 1', 'Page 2'];

  void addPage() {
    setState(() {
      pages.add('Page ${pages.length + 1}');
    });

    // Adding a short delay before navigating to the new page to ensure smooth transition
    Future.delayed(const Duration(milliseconds: 100), () {
      _pageController.animateToPage(
        pages.length - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: addPage,
          child: const Text('Add Page'),
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return Center(child: Text(pages[index]));
            },
          ),
        ),
      ],
    );
  }
}
