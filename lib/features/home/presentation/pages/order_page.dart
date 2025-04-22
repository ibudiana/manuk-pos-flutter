import 'package:flutter/material.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Manuk POS"),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (_, i) => ListTile(title: Text('Item ${i + 1}')),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Chip(label: Text('Cash')),
              Chip(label: Text('Transfer')),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                        decoration: InputDecoration(labelText: 'Rp.'))),
                SizedBox(width: 12),
                ElevatedButton(onPressed: null, child: Text('Process')),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }
}
