import 'package:flutter/material.dart';
import 'package:singapore_trainer_app/screens/Onboarding_screens/login_page.dart';

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
                    child: _buildPage(sportsData[index]['image']!, sportsData[index]['caption']!),
                  );
                },
              );
            },
          ),
          // Show buttons
          if (_currentPage != sportsData.length - 1) // Continue button for all pages except last
            Positioned(
              bottom: 20,
              left: 200,
              child: SizedBox(
                height: 40,
                width: 140,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to the next page
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  label: const Text(
                    'Next',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color(0xFF659F62), // Dark Green
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          // Show "Get Started" button only on the last page
          if (_currentPage == sportsData.length - 1)
            Positioned(
              bottom: 40,
              right: 20,
              child: SizedBox(
                height: 40,
                width: 325,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to the login page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  label: const Text('Get Started'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color(0xFF659F62), // Dark Green
                    foregroundColor: Colors.white,
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
            fontFamily: 'YourCustomFont',
            color: Color(0xFF659F62),
          ),
        ),
      ],
    );
  }
}
