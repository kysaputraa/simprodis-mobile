import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:simprodis_flutter/screens/beranda/beranda_screen.dart';
import 'package:simprodis_flutter/screens/buku_saku/buku_saku_screen.dart';
import 'package:simprodis_flutter/screens/home/home_screen.dart';
import 'package:simprodis_flutter/screens/kartu/kartu_screen.dart';
import 'package:simprodis_flutter/screens/userSetting/user_settings.dart';
import 'package:simprodis_flutter/widgets/DesignCardOne.dart';

class HelloConvexAppBar extends StatefulWidget {
  @override
  State<HelloConvexAppBar> createState() => _HelloConvexAppBarState();
}

class _HelloConvexAppBarState extends State<HelloConvexAppBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    BerandaScreen(),
    KartuScreen(),
    HomeScreen(),
    BukuSakuScreen(),
    const UserSettings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.titled,
        items: const [
          TabItem(icon: Icons.list, title: 'Menu'),
          TabItem(icon: Icons.credit_card, title: 'Kartu'),
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.menu_book, title: 'Buku Saku'),
          TabItem(icon: Icons.person, title: 'Akun'),
        ],
        initialActiveIndex: 2,
        onTap: (int i) => _onItemTapped(i),
      ),
    );
  }
}
