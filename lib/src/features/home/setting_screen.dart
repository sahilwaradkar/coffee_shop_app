import 'package:coffee_shop_project/src/features/authentication/phone_verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';
import '../authentication/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3), // Adjust the duration as needed
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/auth_bg.png"),
              fit: BoxFit.fill
          )
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Settings Page",
                style: GoogleFonts.sora(
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 33,
                )),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () async{

              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PhoneVerificationScreen()),);
                _showSnackBar("You have been Logged out successfully");
                // Replace '/login' with your login screen route
              } catch (e) {
                print('Error signing out: $e');
                _showSnackBar('Error signing out: $e');
                // Handle error while signing out
                // You can show an error dialog or message to the user
              }
            },
              style: ElevatedButton.styleFrom(
                primary: secondaryColor,
                onPrimary: primaryColor,
                elevation: 2,
              ), child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Log Out",
                          style: GoogleFonts.sora(
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
