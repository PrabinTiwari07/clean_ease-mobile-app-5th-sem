import 'package:flutter/material.dart';

import 'login_view.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _sections = [
    {
      "message": "Best for laundry service",
      "image": "assets/images/onboarding.png",
    },
    {
      "message": "Highly professional staff",
      "image": "assets/images/a.jpg",
    },
    {
      "message": "Affordable and efficient solutions",
      "image": "assets/images/laundryyyy.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen dimensions
    final Size screenSize = MediaQuery.of(context).size;
    final bool isTablet = screenSize.width >= 600 && screenSize.width < 1024;
    final bool isDesktop = screenSize.width >= 1024;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00CED1),
        title: const Text(
          "Welcome to CleanEase",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _sections.length,
            itemBuilder: (context, index) {
              final section = _sections[index];

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Responsive Image without the container
                    Image.asset(
                      section["image"]!,
                      height: isDesktop
                          ? 500
                          : isTablet
                              ? 400
                              : 300,
                      width: isDesktop
                          ? 500
                          : isTablet
                              ? 400
                              : 300,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),

                    // Responsive Message Text
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop
                            ? screenSize.width * 0.3
                            : isTablet
                                ? screenSize.width * 0.1
                                : 16.0,
                      ),
                      child: Text(
                        section["message"]!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isDesktop
                              ? 28
                              : isTablet
                                  ? 24
                                  : 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Skip Button
          Positioned(
            bottom: 20,
            left: 16,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginView(),
                  ),
                );
              },
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),

          // Next or Get Started Button
          Positioned(
            bottom: 20,
            right: 16,
            child: _currentPage == _sections.length - 1
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00CED1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Get Started"),
                  )
                : TextButton(
                    onPressed: () {
                      setState(() {
                        _pageController.jumpToPage(_currentPage + 1);
                      });
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
          ),

          // Page Indicator
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _sections.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 20 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? const Color(0xFF00CED1)
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
