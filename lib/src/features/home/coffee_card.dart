import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';


class CoffeeCard extends StatefulWidget {
  const CoffeeCard({
    Key? key,
  }) : super(key: key);

  @override
  _CoffeeCardState createState() => _CoffeeCardState();
}

class _CoffeeCardState extends State<CoffeeCard> {

  late List<DocumentSnapshot> _coffeeProducts = [];
  late List<DocumentSnapshot> _filteredProducts = [];
  late List<DocumentSnapshot> _filteredCoffee = [];
  TextEditingController _searchController = TextEditingController();

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final int _numPages = 5;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
    FirebaseFirestore.instance
        .collection("coffee_products")
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        _coffeeProducts = querySnapshot.docs;
        _filteredProducts = _coffeeProducts;
        _filteredCoffee = _filteredProducts;
      });
    });
  }

  void _filteredByType(String query){
    List<DocumentSnapshot> matchingCoffees = _coffeeProducts
        .where((product) => product['type'].toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _filteredProducts = matchingCoffees;
      // _filteredProducts = filteredList;

    });
  }

  void _filterByPrice(String query) {
    List<DocumentSnapshot> filteredList = [];

    switch (query) {
      case '0':
        filteredList = _filteredCoffee;
        break;
      case '1':
      // Price less than 100
        filteredList = _filteredCoffee
            .where((product) => product['price'] < 100)
            .toList();
        break;
      case '2':
      // Price between 100 and 200
        filteredList = _filteredCoffee
            .where((product) => product['price'] >= 100 && product['price'] <= 200)
            .toList();
        break;
      case '3':
      // Price between 200 and 300
        filteredList = _filteredCoffee
            .where((product) => product['price'] > 200 && product['price'] <= 300)
            .toList();
        break;
      case '4':
      // Price greater than 300
        filteredList = _filteredCoffee
            .where((product) => product['price'] > 300)
            .toList();
        break;
      default:
      // No filter or invalid option selected, show all products
        filteredList = _filteredCoffee;
        break;
    }

    setState(() {
      _filteredProducts = filteredList;
    });
  }


  void _filterProducts(String query) {
    List<DocumentSnapshot> filteredList = _coffeeProducts
        .where((product) => product['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
        _filteredProducts = filteredList;
    });
  }

  List<String> coffeeTypesString = [
    'All',
    'Espresso',
    'Cappuccino',
    'Latte',
    'Americano',
  ];

  List<Widget> _filterCoffeeType() {
    List<Widget> coffeeTypesIndicator = [];

    for (int i = 0; i < _numPages; i++) {
      coffeeTypesIndicator.add(i == _currentPage ? _filterType(true, coffeeTypesString[i]) : _filterType(false, coffeeTypesString[i]));
    }
    return coffeeTypesIndicator;
  }

  List<bool> itemIconStates = List.generate(200,(index) => false,);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          width: 350,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: primaryColor
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _searchController,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.sora(
                    color: whiteColor,
                  ),
                  cursorColor: whiteColor,
                  decoration: InputDecoration(
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Icon(
                        Icons.search,
                        color: secondaryColor,
                      ),
                    ),
                    hintText: "Search Coffee",
                    hintStyle: GoogleFonts.sora(
                      color: secondaryColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(15.0),
                  ),
                  onChanged: (value){
                    _filterProducts(value);
                    _pageController.animateToPage(0, duration: Duration(milliseconds: 1), curve: Curves.easeInOut);
                  },
                ),
              ),
              SizedBox(width: 10),
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.filter_alt,
                  color: secondaryColor,
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: '0',
                    child: Text('All'),
                  ),
                  const PopupMenuItem<String>(
                    value: '1',
                    child: Text('< Rs.100'),
                  ),
                  const PopupMenuItem<String>(
                    value: '2',
                    child: Text('Rs.100 - Rs.200'),
                  ),
                  const PopupMenuItem<String>(
                    value: '3',
                    child: Text('Rs.200 - Rs.300'),
                  ),
                  const PopupMenuItem<String>(
                    value: '4',
                    child: Text('> Rs.300'),
                  ),
                ],
                color: Colors.grey,
                onSelected: (String value) {
                  _filterByPrice(value);
                },
              ),
            ],
          ),

        ),
        SizedBox(
          height: 30,
        ),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _filterCoffeeType(),
          ),
        ),
        Expanded(
          child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: _numPages,
            itemBuilder: (context, index){
              return ListView.builder(
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: secondaryColor,
                    child: ListTile(
                      minLeadingWidth: 30,
                      leading: Image.network(_filteredProducts[index]['image'].toString()),
                      title: Text(
                        _filteredProducts[index]['name'],
                        style: GoogleFonts.sora(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text("Rs. ${_filteredProducts[index]['price']}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                itemIconStates[index] = !itemIconStates[index];
                              });
                              Future.delayed(Duration(seconds: 1), () {
                                setState(() {
                                  itemIconStates[index] = !itemIconStates[index];
                                });
                              });
                              },
                            child: itemIconStates[index] ? Icon(Icons.check, color: whiteColor) : Icon(Icons.add, color: whiteColor),
                            elevation: 0,
                            mini: true,
                            backgroundColor: primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                            ),
                            child: Text(
                              "Buy",
                              style: GoogleFonts.sora(
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            // child:
          ),
        ),
      ],
    );
  }
  Widget _filterType(bool isActive, String txt) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {

          if (txt == 'All') {
            _pageController.animateToPage(0, duration: Duration(milliseconds: 1), curve: Curves.easeInOut);
            setState(() {
              // _coffeeProducts = querySnapshot.docs;
              _filteredProducts = _coffeeProducts;
              _filteredCoffee = _filteredProducts;
            });
          }
          else{
            for(int i = 1; i < coffeeTypesString.length; i++){
              if(txt == coffeeTypesString[i]){
                _pageController.animateToPage(i, duration: Duration(milliseconds: 1), curve: Curves.easeInOut);
                setState(() {
                  _filteredByType(coffeeTypesString[i]);
                  _filteredCoffee = _filteredProducts;

                });
              }
            }
          }
          // if (txt == 'Espresso') {
          //   _pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          //   _filteredByType("espresso");
          // }
          // if (txt == 'Cappuccino') {
          //   _pageController.animateToPage(2, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          //   _filteredByType("cappuccino");
          // }
          // if (txt == 'Latte') {
          //   _pageController.animateToPage(3, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          //   _filteredByType("latte");
          // }
          // if (txt == 'Americano') {
          //   _pageController.animateToPage(4, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          //   _filteredByType("americano");
          // }

        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          decoration: BoxDecoration(
            color: isActive ? secondaryColor : primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            txt,
            style: GoogleFonts.sora(
              fontSize: 12,
              color: isActive ? primaryColor : secondaryColor,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

}
