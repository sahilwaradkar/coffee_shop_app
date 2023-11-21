import 'package:coffee_shop_project/src/features/authentication/phone_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';
import 'on_boarding_page_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final int _numPages = 3;

  final List<Widget> onboardingPages = [
    OnboardingPage(
      title: 'Welcome to Coffee Shop',
      description: 'Experience premium coffee blends & cozy ambiance.',
      imagePath: 'assets/images/onboarding_page_1.png',
    ),
    OnboardingPage(
      title: 'Discover Unique Brews',
      description: 'Explore our expertly crafted coffee varieties.',
      imagePath: 'assets/images/onboarding_page_2.png',
    ),
    OnboardingPage(
      title: 'Get Started',
      description: 'Indulge in handcrafted, aromatic coffees today!',
      imagePath: 'assets/images/onboarding_page_3.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    List<Widget> _buildPageIndicator() {
      List<Widget> indicators = [];
      for (int i = 0; i < _numPages; i++) {
        indicators.add(i == _currentPage ? _indicator(true) : _indicator(false));
      }
      return indicators;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight * 0.88, // Adjusted height using MediaQuery
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingPages.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    onboardingPages[index],
                    SizedBox(height: screenHeight * 0.04), // Adjusted spacing using MediaQuery
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: _currentPage == onboardingPages.length - 1
          ? ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PhoneVerificationScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: secondaryColor,
          onPrimary: primaryColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4, // Adjusted width using MediaQuery
          height: screenHeight * 0.07, // Adjusted height using MediaQuery
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Get Started',
              style: GoogleFonts.sora(
                fontSize: 18,
                color: whiteColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      )
          : FloatingActionButton(
        onPressed: () {
          _pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        backgroundColor: secondaryColor,
        foregroundColor: whiteColor,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 8.0,
        width: 8.0,
        decoration: BoxDecoration(
          color: isActive ? secondaryColor : primaryColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
