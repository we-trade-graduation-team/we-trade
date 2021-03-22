
import 'package:flutter/material.dart';

class BuildBottomNavigationBar extends StatelessWidget {
  const BuildBottomNavigationBar({
    Key? key,
    required int selectedIndex,
  }) : _selectedIndex = selectedIndex, super(key: key);

  final int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: _selectedIndex,
    onTap: (value) {
      // setState(() {
      //   _selectedIndex = value;
      // });
    },
    items: [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
      const BottomNavigationBarItem(icon: Icon(Icons.add_circle_rounded), label: 'New Item'),
      const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
    ],
    );
  }
}
