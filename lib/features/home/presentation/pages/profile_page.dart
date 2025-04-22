import 'package:flutter/material.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Manuk POS"),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TextField(decoration: InputDecoration(labelText: 'Name')),
            SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: 'Informasi Akun')),
            SizedBox(height: 24),
            TextField(decoration: InputDecoration(labelText: 'Branch')),
            SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: 'Struk')),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }
}
