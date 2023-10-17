import 'package:book_app/screens/user/bottomNavBar/userHome.dart';
import 'package:flutter/material.dart';

import 'cart.dart';
import 'favourite.dart';
import 'account.dart';
import 'category.dart';


class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List pages = [
    UserHome(),
    Categories(),
    Cart(),
    Favourite(),
    Account()
  ];
  int curInd = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[curInd],
      bottomNavigationBar: BottomNavigationBar(backgroundColor: Colors.green,
        onTap: (int index) {
          setState(() {
            curInd = index;
          });
          pages[curInd];
        },
        currentIndex: curInd,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xFF181725),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(

            label: "Home",
            activeIcon: Icon(Icons.home,
            color: Colors.white,),
            icon: Icon(
              Icons.home_outlined
            )
          ),
          BottomNavigationBarItem(

              label: "Category",
              activeIcon: Icon(Icons.category,
                color: Colors.white,),
              icon: Icon(
                  Icons.category_outlined
              )
          ),

          BottomNavigationBarItem(
            label: "Cart",
            activeIcon: Icon(Icons.shopping_cart,
            color: Colors.white,),
            icon: Icon(
              Icons.shopping_cart_outlined
            ),
          ),
          BottomNavigationBarItem(
            label: "Favourite",
              activeIcon: Icon(Icons.favorite,
                color: Colors.white,),
            icon: Icon(
              Icons.favorite_outline
            )
          ),
          BottomNavigationBarItem(
            label: "Account",
            activeIcon: Icon(Icons.person,
            color: Colors.white,),
            icon: Icon(
              Icons.person_2_outlined
            )
          ),
        ],
      ),
    );
  }
}