// import '../../../../../coffee_shop_project/lib/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../bottom_navigation_bar.dart';
import '../../constants/colors.dart';
import '../on_boarding_screens/on_boarding_screens.dart';

// import '../../../../../coffee_shop_project/lib/src/constants/colors.dart';
// import '../home/home_screen.dart';
// import '../on_boarding_screens/on_boarding_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }
  _navigateToNextScreen() async{
    User? user = await FirebaseAuth.instance.currentUser;

    Future.delayed(const Duration(seconds: 3), () {
      if (user != null) {
      // User is logged in, navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => BottomNavBar()),
      );
    } else {
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnBoardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: 250,
                  height: 250,
                  // color: Colors.white, // Use Colors.white for white color
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(150), // Adjust the borderRadius according to your needs
                  ),
                ),
                Image.asset("assets/images/splash_logo.png",
                  width: 250,
                  height: 250,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text("Coffee Shop",
              style: GoogleFonts.sora(
                color: whiteColor,
                fontSize: 34,
                fontWeight: FontWeight.w700,
              ),

            )
          ],
        ),
      ),
    );
  }
}
