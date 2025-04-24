import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/theme/theme.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});

  static final _routes = [
    '/home/dashboard',
    '/home/product',
    '/home/order',
    '/home/report',
    '/home/profile',
  ];

  @override
  Widget build(BuildContext context) {
    // jika currentIndex -1, pakai warna selected dan unselected yang sama biar "invisible"
    final isInactive = currentIndex == -1;

    return BottomNavigationBar(
      selectedItemColor:
          isInactive ? AppTheme.buttonBackground : AppTheme.secondaryColor,
      unselectedItemColor: AppTheme.buttonBackground,
      currentIndex: currentIndex >= 0 ? currentIndex : 0,
      onTap: (index) {
        if (index != currentIndex) {
          context.go(_routes[index]);
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Produk'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Order'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Laporan'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}
