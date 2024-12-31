import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Views/login_view.dart';

class SportsPageView extends StatefulWidget {
  @override
  _SportsPageViewState createState() => _SportsPageViewState();
}

class _SportsPageViewState extends State<SportsPageView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> sportsData = [
    {'image': 'assets/images/Singapore Trainers-2.png', 'caption': 'Stay Strong, Stay Motivated!'},
    {'image': 'assets/images/Singapore Trainers-2.png', 'caption': 'Push Harder, Achieve More!'},
    {'image': 'assets/images/Singapore Trainers-2.png', 'caption': 'Train Like a Champion!'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // PageView builder with transform transition
          PageView.builder(
            controller: _pageController,
            itemCount: sportsData.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double pageOffset = 0.0;
                  if (_pageController.position.haveDimensions) {
                    pageOffset = index - _pageController.page!;
                  }

                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateY(pageOffset * 0.2)
                      ..scale(1 - (pageOffset.abs() * 0.1)),
                    child: _buildPage(
                      sportsData[index]['image']!,
                      sportsData[index]['caption']!,
                    ),
                  );
                },
              );
            },
          ),

          // Dots Indicator
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2,
            left: MediaQuery.of(context).size.width * 0.44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                sportsData.length,
                    (index) => buildDot(index: index),
              ),
            ),
          ),

          // Navigation buttons
          // Navigation buttons
          // Navigation buttons
          if (_currentPage != sportsData.length - 1)
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage > 0) {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      }
                    },
                    child: Text(
                      "Previous",
                      style: TextStyle(fontSize: 18, color: Color(0xFF659F62)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFCDEAC0), // Light Green
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF659F62),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // "Get Started" button on the last page
          if (_currentPage == sportsData.length - 1)
            Positioned(
              bottom: 40,
              left: 15,


              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 320.w,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      "Get Started",
                      style: TextStyle(fontSize: 18, color: Color(0xFF659F62)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFCDEAC0), // Light Green
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPage(String imagePath, String caption) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: 300,
          height: 300,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 20),
        Text(
          caption,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF659F62), // Dark Green
          ),
        ),
      ],
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: _currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: _currentPage == index ? Color(0xFF659F62) : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
