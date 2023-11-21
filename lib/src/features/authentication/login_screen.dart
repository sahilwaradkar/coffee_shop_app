// import '../../../../../coffee_shop_project/lib/bottom_navigation_bar.dart';
// import '../../../../../coffee_shop_project/lib/src/constants/colors.dart';
// import 'package:coffee_shop/src/features/authentication/signup_screen.dart';
import 'package:coffee_shop_project/src/features/authentication/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../bottom_navigation_bar.dart';
import '../../constants/colors.dart';

// import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/auth_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/splash_logo.png",
                        width: 70,
                        height: 70,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("COFFEE SHOP",
                          style: GoogleFonts.sora(
                            color: whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                      "Log In",
                      style: GoogleFonts.sora(
                        fontSize: 40,
                        color: whiteColor,
                        fontWeight: FontWeight.w700,
                      )
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "We’ve already met!",
                      style: GoogleFonts.sora(
                        color: whiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )
                  )
                ],
              ),
              SizedBox(
                height: 55,
              ),
              Container(
                margin: const EdgeInsets.only(top: 0, left: 20, right: 20),
                child: TextField(
                  controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Address',
                      hintText: 'Enter your Email Address',
                      labelStyle: GoogleFonts.spaceGrotesk(
                        color: whiteColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: whiteColor,
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: whiteColor,
                        ),
                      ),
                    ),
                    style: GoogleFonts.spaceGrotesk(
                      color: whiteColor,
                    )

                ),
              ),
              //Textfield for Password

              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: whiteColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: whiteColor,
                          )
                      ),
                      labelText: 'Password',
                      hintText: 'Enter your Password',
                      labelStyle: GoogleFonts.spaceGrotesk(
                        color: whiteColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: whiteColor,
                        ),
                      ),
                    ),
                    style: GoogleFonts.spaceGrotesk(
                      color: whiteColor,
                    ),
                  ),
              ),
              SizedBox(
                height: 100,
              ),
              GestureDetector(
                // onTap: (){
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()),);
                // },
                onTap: () async {
                  String email = _emailController.text.trim();
                  String password = _passwordController.text.trim();

                  if(email == "" || password == "") {
                    _showSnackBar('Please fill complete details');
                  }else{
                    try {
                      UserCredential userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      print('User logged in as : ${userCredential.user?.email}');
                      _showSnackBar("Logged in as : ${userCredential.user?.email}");
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar()),);
                    } catch (e) {
                      print('Error during log in : $e');
                      _showSnackBar("Error : $e");
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                    width: 150,
                    height: 50,
                    decoration:     BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: secondaryColor
                    ),
                  child: Text(
                      "Log In",
                      style: GoogleFonts.sora(
                        color: whiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )
                  )
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Don’t have an account? ",
                      style: GoogleFonts.sora(
                        color: whiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen()),);
                    },
                    child: Text("Sign Up",
                        style: GoogleFonts.sora(
                          color: secondaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        )
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),


    );
  }
}
