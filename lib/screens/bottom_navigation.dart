import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user/screens/home_page.dart';
import 'package:user/screens/order_page.dart';
import 'package:user/screens/profile_page.dart';

import 'cart_items.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CartPage(),
    OrderPage(),
    ViewProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Colors.green,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light

          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: new TextStyle(color: Colors.green)),
        ), // sets
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.cartArrowDown),
              title: Text('Cart'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.listUl),
              title: Text('Orders'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user),
              title: Text('Profile'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.white,
          unselectedLabelStyle: TextStyle(color: Colors.white),
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class ActivatedIcon extends StatelessWidget {
  final Widget icon;
  const ActivatedIcon({this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: Colors.white),
      child: icon,
    );
  }
}
