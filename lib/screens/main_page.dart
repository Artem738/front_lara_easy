import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/pr.dart';
import 'screen_one.dart';
import 'screen_three.dart';
import 'screen_two.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    context.read<Pr>().getBookData();
  }

  List<Widget> _screens = [
    ScreenOne(),
    ScreenTwo(),
    ScreenThree(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Простое учебное приложение'),
      // ),
      body: Column(
        children: [
          CustomHeader(),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: _screens,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
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



class CustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Adjust the height as needed
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/books_header.jpg"), // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Blur background image
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          // Content centered in the header
          const Positioned.fill(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Welcome To Bookstore',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 5.0,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8), // Add some spacing between the texts
                  Text(
                    'Learning App For Testing Api',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 5.0,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


