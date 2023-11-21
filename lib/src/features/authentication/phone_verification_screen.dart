import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../bottom_navigation_bar.dart';
import '../../constants/colors.dart';

// import '../../../../../coffee_shop_project/lib/src/constants/colors.dart';

class PhoneVerificationScreen extends StatefulWidget {
  @override
  _PhoneVerificationScreenState createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  String _verificationId = '';

  FirebaseAuth auth = FirebaseAuth.instance;
  bool _verificationCompleted = false;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3), // Adjust the duration as needed
      ),
    );
  }


  Future<void> _verifyPhoneNumber() async {
    showDialog(context: context, builder: (context){
      return Center(child: CircularProgressIndicator());
    },
    );
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: _phoneNumberController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          UserCredential userCredential =
          await auth.signInWithCredential(credential);
          setState(() {
            _verificationCompleted = true;
          });

        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
          _showSnackBar(e.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
        },
      );
    } catch (e) {
      print("Error: $e");
      _showSnackBar(e.toString());
    }

    Navigator.of(context).pop();
  }

  Future<void> _signInWithPhoneNumber(String otpCode) async {
    showDialog(context: context, builder: (context){
      return Center(child: CircularProgressIndicator());
    },
    );
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otpCode,
      );
      UserCredential userCredential =
      await auth.signInWithCredential(credential);
      Navigator.of(context).pop();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar()),);

    } catch (e) {
      print("Error: $e");
      _showSnackBar(e.toString());
      Navigator.of(context).pop();
    }
  }
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/auth_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(
                height: screenSize.width * 0.25,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.all(screenSize.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/splash_logo.png",
                        width: screenSize.width * 0.2,
                        height: screenSize.width * 0.2,
                      ),
                      SizedBox(
                        height: screenSize.width * 0.025,
                      ),
                      Text(
                        "COFFEE SHOP",
                        style: GoogleFonts.sora(
                          color: whiteColor,
                          fontSize: screenSize.width * 0.037,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Text("OTP Screen",
                  style: GoogleFonts.sora(
                    fontSize: 40,
                    color: whiteColor,
                    fontWeight: FontWeight.w700,
                  )
              ),
              SizedBox(
                height: screenSize.width * 0.05,
              ),
              Text(
                "Add country code before phone number",
                textAlign: TextAlign.center,
                style: GoogleFonts.sora(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenSize.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenSize.width * 0.50,
                      child: TextField(
                        controller: _phoneNumberController,
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
                          labelText: 'Phone Number',
                          hintText: '+919876543XXX',
                          hintStyle: GoogleFonts.spaceGrotesk(
                              color: Colors.grey
                          ),
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
                      width: screenSize.width * 0.05,
                    ),
                    SizedBox(
                      width: screenSize.width * 0.25,
                      height: screenSize.height * 0.07,
                      child: ElevatedButton(
                        onPressed: _verifyPhoneNumber,
                        child: Text('Send OTP',
                        style: TextStyle(
                          color: secondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: screenSize.width * 0.05,
                color: Colors.grey,
                thickness: 1.5,
              ),
              Container(
                margin: EdgeInsets.only(top: screenSize.width * 0.05),
                width: screenSize.width * 0.5,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _otpController,
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
                    labelText: 'OTP',
                    hintText: 'Enter Six digit OTP',
                    hintStyle: GoogleFonts.spaceGrotesk(
                        color: Colors.grey
                    ),
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
              SizedBox(height: screenSize.width * 0.05),
              ElevatedButton(
                onPressed: () {
                  _signInWithPhoneNumber(_otpController.text);
                },
                child: Text('Verify',
                  style: TextStyle(
                    color: secondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
