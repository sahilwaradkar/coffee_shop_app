// import 'package:coffee_shop/src/features/authentication/firebase_auth_services.dart';
// import '../../../../../coffee_shop_project/lib/bottom_navigation_bar.dart';
// import 'package:coffee_shop/src/features/authentication/login_screen.dart';
// import 'package:coffee_shop/src/features/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../bottom_navigation_bar.dart';
import '../../constants/colors.dart';
import 'login_screen.dart';

// import '../../../../../coffee_shop_project/lib/src/constants/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
                      "Sign Up",
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
                      "Let's create your account",
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
                      // onChanged: (value){
                      //     setState(() {
                      //       _email = value;
                      //     });
                      // },
                      // onChanged: (text) {
                      // setState(() {
                      // _enteredText = text;
                      // });
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
                  // onChanged: (value){
                  //   setState(() {
                  //     _password = value;
                  //   });
                  // },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your Password',
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
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _confirmPasswordController,
                  // onChanged: (value){
                  //   setState(() {
                  //     _confirmPassword = value;
                  //   });
                  // },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: whiteColor,
                        )
                    ),
                    labelText: 'Confirm Password',
                    hintText: 'Confirm your Password',
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
                height: 50,
              ),
              GestureDetector(
                onTap: () async {
                  String email = _emailController.text.trim();
                  String password = _passwordController.text.trim();
                  String confirmPassword = _confirmPasswordController.text.trim();

                  if(email == "" || password == "" || confirmPassword == "") {
                     _showSnackBar('Please fill complete details');
                  }else if (password == confirmPassword){
                    try {
                      UserCredential userCredential =
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      print('User signed up: ${userCredential.user?.email}');
                      _showSnackBar("Logged in as : ${userCredential.user?.email}");
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar()),);
                    } catch (e) {
                      print('Error during sign up: $e');
                      _showSnackBar("Error : $e");
                    }
                  }
                  else {
                    // Show error if passwords do not match
                    // You can show an error message to the user using a SnackBar or showDialog
                    print('Passwords do not match');
                    _showSnackBar('Passwords do not match');
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: secondaryColor,
                  ),
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.sora(
                      color: whiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Already have an account? ",
                      style: GoogleFonts.sora(
                        color: whiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()),);
                    },
                    child: Text("Log In",
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
                height: 65,
              ),
            ],
          ),
        ),
      ),


    );
  }
}
