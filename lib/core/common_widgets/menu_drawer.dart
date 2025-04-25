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
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppTheme.fourthColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child:
                      Icon(Icons.store, size: 30, color: AppTheme.fourthColor),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Manuk POS',
                        style:
                            AppTheme.headingText.copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Versi 1.0.0',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
              // Product Route
              ListTile(
                leading: const Icon(Icons.shopping_bag),
                contentPadding: const EdgeInsets.only(left: 32.0),
                title: const Text('Product'),
                onTap: () {
                  context.go('/inventory/product/list-product');
                },
              ),

              // Product Category as a child route under Product
              ExpansionTile(
                title: Padding(
                  padding: const EdgeInsets.only(
                      left: 18.0), // Adjust the left padding here
                  child: Row(
                    children: [
                      const Icon(Icons.category,
                          size: 20), // Add your icon here
                      const SizedBox(
                          width: 8), // Space between the icon and the text
                      const Text('Product Category'),
                    ],
                  ),
                ),
                childrenPadding: const EdgeInsets.only(
                    left: 64.0), // Indent the children here
                children: [
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text('List Categories'),
                    onTap: () {
                      context.go('/inventory/product/category/list-category');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add Category'),
                    onTap: () {
                      context.go('/inventory/product/category/add-category');
                    },
                  ),
                ],
              ),

              // Stock Opname Route
              ListTile(
                leading: const Icon(Icons.fact_check),
                contentPadding: const EdgeInsets.only(left: 32.0),
                title: const Text('Stock Opname'),
                onTap: () {
                  context.go('/home/product');
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.show_chart),
            title: const Text('Report'),
            children: [
              ListTile(
                leading: const Icon(Icons.track_changes),
                contentPadding: const EdgeInsets.only(left: 32.0),
                title: const Text(
                  'Transaction Report',
                ),
                onTap: () {
                  context.go('/transaction/list-transaction');
                },
              ),
              ListTile(
                leading: const Icon(Icons.storage),
                contentPadding: const EdgeInsets.only(left: 32.0),
                title: const Text('Stock'),
                onTap: () {
                  context.go('/home');
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.dataset),
            title: const Text('Database'),
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                contentPadding: const EdgeInsets.only(left: 32.0),
                title: const Text('Customer'),
                onTap: () {
                  context.go('/databases/customer/list-customer');
                },
              ),
              ListTile(
                leading: const Icon(Icons.local_shipping),
                contentPadding: const EdgeInsets.only(left: 32.0),
                title: const Text('Supplier'),
                onTap: () {
                  context.go('/databases/supplier/list-supplier');
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.scale_sharp),
            title: const Text('Finance'),
            children: [
              ListTile(
                leading: const Icon(Icons.receipt_long),
                contentPadding: const EdgeInsets.only(left: 32.0),
                title: const Text('Tax'),
                onTap: () {
                  context.go('/finance/list-tax');
                },
              ),
              ListTile(
                leading: const Icon(Icons.money_off_csred),
                contentPadding: const EdgeInsets.only(left: 32.0),
                title: const Text('Loan'),
                onTap: () {
                  context.go('/finance/list-loan');
                },
              ),
              ListTile(
                leading: const Icon(Icons.price_change),
                contentPadding: const EdgeInsets.only(left: 32.0),
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
                leading: const Icon(Icons.people),
                contentPadding: const EdgeInsets.only(left: 32.0),
                title: const Text('User'),
                onTap: () {
                  context.go('/setting/list-user');
                },
              ),
              ListTile(
                leading: const Icon(Icons.admin_panel_settings),
                contentPadding: const EdgeInsets.only(left: 32.0),
                title: const Text('Role'),
                onTap: () {
                  context.go('/setting/list-role');
                },
              ),
              ListTile(
                leading: const Icon(Icons.store_mall_directory),
                contentPadding: const EdgeInsets.only(left: 32.0),
                title: const Text('Branch'),
                onTap: () {
                  context.go('/setting/branches');
                },
              ),
              ListTile(
                leading: const Icon(Icons.percent),
                contentPadding: const EdgeInsets.only(left: 32.0),
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
