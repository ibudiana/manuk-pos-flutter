import 'package:flutter/material.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Manuk POS"),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSection(),
            _buildSection(),
            _buildSection(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildSection() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children:
            List.generate(3, (i) => ListTile(title: Text('Item ${i + 1}'))),
      ),
    );
  }
}
