import 'package:flutter/material.dart';
import 'package:project_restaurant/src/views/main/bag/bag_screen.dart';
import 'package:project_restaurant/src/views/main/favorites/favorites_screen.dart';
import 'package:project_restaurant/src/views/main/home/home_screen.dart';
import 'package:project_restaurant/src/views/main/profile/profile_screen.dart';
import 'package:project_restaurant/src/views/main/shop/shop_screen.dart';

class MainScreen extends StatefulWidget {
  //route 
  static const String route = 'main'; 

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //values 
  List<Widget> subScreens = const [
    HomeScreen(),
    ShopScreen(), 
    BagScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];
  int currentIndex = 0 ; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15) , topRight: Radius.circular(15))
        ),
        child: BottomNavigationBar(
          showUnselectedLabels: true ,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,        
          iconSize: 30,
          currentIndex: currentIndex ,
          onTap: (value){
            setState(() {
              currentIndex = value; 
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home ) , label: 'Home'), 
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart) , label: 'Shop'), 
            BottomNavigationBarItem(icon: Icon(Icons.shopify_sharp) , label: 'Bag'), 
            BottomNavigationBarItem(icon: Icon(Icons.favorite) , label: 'Favorites'), 
            BottomNavigationBarItem(icon: Icon(Icons.person) , label: 'Profile'), 
          ],
        ),
      ),
      body: subScreens[currentIndex],
    );
  }
}