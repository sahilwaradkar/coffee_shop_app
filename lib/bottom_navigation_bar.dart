import 'package:coffee_shop_project/src/constants/colors.dart';
import 'package:coffee_shop_project/src/features/home/home_screen.dart';
import 'package:coffee_shop_project/src/features/home/setting_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var currentIndex = 0;
  final List<Widget> screens = [
    HomeScreen(),
    SettingsScreen(),
  ];







  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: screens[currentIndex],
      bottomNavigationBar: BottomAppBar(
        height: size.width * 0.16,
        color: Colors.transparent,
        child: Container(
          // height: size.width * 0.167,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // buildNavBarItem(Icons.home_rounded, 0, size),
              buildNavBarItem(Icons.home_filled, 0, size),
              buildNavBarItem(Icons.settings, 1, size),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index, Size size) {
    return InkWell(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Icon(
        icon,
        size: size.width * 0.076,
        color: currentIndex == index ? secondaryColor : whiteColor,
      )
    );
  }

}
