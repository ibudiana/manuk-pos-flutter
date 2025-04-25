import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/features/product/presentation/bloc/product_bloc.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetAllProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Manuk POS"),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(labelText: 'Search Product'),
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductStateLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductStateLoaded) {
                  final filteredProducts = state.products.where((product) {
                    return selectedCategory == null ||
                        product.name == selectedCategory;
                  }).toList();

                  if (filteredProducts.isEmpty) {
                    return Center(child: Text('No products found'));
                  }

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              product.imageUrl.isEmpty
                                  ? Image.asset(
                                      'assets/images/default-product.png',
                                      height: 100,
                                    )
                                  : Image.network(
                                      product.imageUrl,
                                      height: 100,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/default-product.png',
                                          height: 100,
                                        );
                                      },
                                    ),
                              Text(
                                product.name,
                                style: AppTheme.bodyText,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Rp ${NumberFormat('#,##0', 'id_ID').format(product.sellingPrice)}',
                                style: AppTheme.subHeadingText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('Failed to load products'));
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}
