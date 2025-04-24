import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/theme/theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.thirdColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: AppTheme.fourthColor),
            child: Text('Menu', style: AppTheme.headingText),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Dashboard'),
            onTap: () {
              context.go('/home/product');
            },
          ),
          ExpansionTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Inventory'),
            children: [
              ListTile(
                title: const Text('Product'),
                onTap: () {
                  context.go('/home');
                },
              ),
              ListTile(
                title: const Text('Stock Opname'),
                onTap: () {
                  context.go('/home/category');
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.show_chart),
            title: const Text('Report'),
            children: [
              ListTile(
                title: const Text('Sales'),
                onTap: () {
                  context.go('/home/product');
                },
              ),
              ListTile(
                title: const Text('Stock'),
                onTap: () {
                  context.go('/home/category');
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.dataset),
            title: const Text('Database'),
            children: [
              ListTile(
                title: const Text('Customer'),
                onTap: () {
                  context.go('/home/product');
                },
              ),
              ListTile(
                title: const Text('Supplier'),
                onTap: () {
                  context.go('/home/category');
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.scale_sharp),
            title: const Text('Finance'),
            children: [
              ListTile(
                title: const Text('Tax'),
                onTap: () {
                  context.go('/finance/list-tax');
                },
              ),
              ListTile(
                title: const Text('Loan'),
                onTap: () {
                  context.go('/finance/list-loan');
                },
              ),
              ListTile(
                title: const Text('Fee'),
                onTap: () {
                  context.go('/finance/list-fee');
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.settings),
            title: const Text('Setting'),
            children: [
              ListTile(
                title: const Text('User'),
                onTap: () {
                  context.go('/setting/list-user');
                },
              ),
              ListTile(
                title: const Text('Role'),
                onTap: () {
                  context.go('/setting/list-role');
                },
              ),
              ListTile(
                title: const Text('Branch'),
                onTap: () {
                  context.go('/setting/branches');
                },
              ),
              ListTile(
                title: const Text('Discount'),
                onTap: () {
                  context.go('/setting/list-discount');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
