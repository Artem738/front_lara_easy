import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/screen_one.dart';
import 'screens/screen_three.dart';
import 'screens/screen_two.dart';

import 'provider/pr.dart';


void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Pr>(
        create: (_) => Pr(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  List<Widget> _screens = [
    ScreenOne(),
    ScreenTwo(),
    ScreenThree(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Простое учебное приложение'),
      ),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Экран 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Экран 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Экран 3',
          ),
        ],
      ),
    );
  }
}
