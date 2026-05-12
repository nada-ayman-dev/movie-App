import 'package:flutter/material.dart';
import 'package:movie/features/home/presentation/pages/home_page.dart';
import 'package:movie/features/search/presentation/pages/search_page.dart';
import 'package:movie/features/explore/presentation/pages/explore_page.dart';
import 'package:movie/features/profile/presentation/pages/profile_page.dart';
import 'package:movie/shared/widgets/bottom_navigation_bar_widget.dart';

class AppShell extends StatefulWidget {
  const AppShell({Key? key}) : super(key: key);

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  // Pages list
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePage(),
      const SearchPage(),
      const ExplorePage(),
      const ProfilePage(),
    ];
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}
