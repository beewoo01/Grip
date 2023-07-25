import 'package:flutter/material.dart';
import 'package:grip/home.dart';
import 'package:grip/category.dart';
import 'package:grip/community/community.dart';
import 'package:grip/myinfo.dart';
import 'package:grip/promotion/promotion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedIndex = 2;
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final List<String> images = [
    'https://picsum.photos/200/300',
    'https://picsum.photos/200',
    'https://picsum.photos/id/237/200/300',
    'https://picsum.photos/id/237/200/300',
    'https://picsum.photos/id/237/200/300',
  ];

  final colorCodes = [400, 100, 300, 200, 100];
  final categoryData = ['웨딩촬영', '바프퐐영', '모델', '공간대여'];

  final List<Widget> widgets = <Widget> [
    Category(),
    Promotion(),
    Home(),
    Community(),
    MyInfo()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.abc,
                color: Colors.black,
              ),
              label: '카테고리'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.abc,
                color: Colors.black,
              ),
              label: '프로모션'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.abc,
                color: Colors.black,
              ),
              label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.abc,
                color: Colors.black,
              ),
              label: '커뮤니티'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.abc,
                color: Colors.black,
              ),
              label: '내정보'),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        unselectedFontSize: 8,
        selectedFontSize: 8,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
      ),
    );
  }

  /*AppBar createToolbar() {
    return AppBar(
        title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('GRIP'),
        Row(
          children: [
            const Text(
              '000님',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          ],
        )
      ],
    ));
  }*/

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
