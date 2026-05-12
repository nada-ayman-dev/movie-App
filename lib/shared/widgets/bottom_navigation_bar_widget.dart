import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationBarWidget({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF282A28),
        border: Border(
          top: BorderSide(
            color: const Color(0xFFF6BD00).withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Home Tab
            _BottomNavItem(
              icon: 'assets/icons/home.svg',
              label: 'Home',
              isActive: currentIndex == 0,
              onTap: () => onTap(0),
            ),
            // Search Tab
            _BottomNavItem(
              icon: 'assets/icons/search.svg',
              label: 'Search',
              isActive: currentIndex == 1,
              onTap: () => onTap(1),
            ),
            // Explore Tab
            _BottomNavItem(
              icon: 'assets/icons/explore.svg',
              label: 'Explore',
              isActive: currentIndex == 2,
              onTap: () => onTap(2),
            ),
            // Profile Tab
            _BottomNavItem(
              icon: 'assets/icons/Profiel.svg',
              label: 'Profile',
              isActive: currentIndex == 3,
              onTap: () => onTap(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 28,
            height: 28,
            colorFilter: ColorFilter.mode(
              isActive ? const Color(0xFFF6BD00) : Colors.grey[600]!,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xFFF6BD00) : Colors.grey[600],
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
