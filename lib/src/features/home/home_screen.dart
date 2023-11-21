
import 'package:coffee_shop_project/src/features/home/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';
import 'coffee_card.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // String selectedCategory = 'All'; // Default filter value
  String _getGreeting() {
    var hour = DateTime.now().hour;

    if(hour < 4){
      return 'Good Evening!';
    }
    else if (hour < 12) {
      return 'Good morning!';
    } else if (hour < 17) {
      return 'Good afternoon!';
    } else {
      return 'Good evening!';
    }
  }
  String _greetingMessage() {
    var hour = DateTime.now().hour;

    if(hour < 4){
      return 'Hope you have a restful night!';
    }
    else if (hour < 12) {
      return 'Start your day with positivity!';
    } else if (hour < 17) {
      return 'Hope you are having a great day!';
    } else {
      return 'Relax and unwind!';
    }
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          leading: const Icon((Icons.menu),
            color: secondaryColor,
          ),
          title: Text(
            'Coffee Shop',
            style: GoogleFonts.sora(
              fontWeight: FontWeight.w700,
              color: secondaryColor,
              fontSize: 24,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()),);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset("assets/images/profile_pic.png",
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain
                  ),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Hi, " + _getGreeting(),
                  style: GoogleFonts.sora(
                    color: whiteColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  )
              ),
              Text(
                  _greetingMessage(),
                  style: GoogleFonts.sora(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  )
              ),
              SizedBox(
                height: 20,
              ),

              Expanded(
                child: CoffeeCard()

              )
            ],
          ),
        ),
      ),
    );
  }
}
