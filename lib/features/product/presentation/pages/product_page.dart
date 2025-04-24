import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/text_field.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/product/domain/entities/product.dart';
import 'package:manuk_pos/features/product/presentation/bloc/product_bloc.dart';

class AddProductPage extends StatefulWidget {
  final Product? product;

  const AddProductPage({super.key, this.product});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController skuController;
  late TextEditingController barcodeController;
  late TextEditingController buyingPriceController;
  late TextEditingController sellingPriceController;
  late TextEditingController tagsController;
  late TextEditingController minStockController;
  late TextEditingController imageUrlController;
  String? imageUrl;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.product?.name ?? '');
    descriptionController =
        TextEditingController(text: widget.product?.description ?? '');
    skuController = TextEditingController(text: widget.product?.sku ?? '');
    barcodeController =
        TextEditingController(text: widget.product?.barcode ?? '');
    buyingPriceController = TextEditingController(
        text: widget.product?.buyingPrice.toString() ?? '');
    sellingPriceController = TextEditingController(
        text: widget.product?.sellingPrice.toString() ?? '');
    tagsController = TextEditingController(text: widget.product?.tags ?? '');
    minStockController =
        TextEditingController(text: widget.product?.minStock.toString() ?? '');
    imageUrlController =
        TextEditingController(text: widget.product?.imageUrl ?? '');
    imageUrl = widget.product?.imageUrl;
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    skuController.dispose();
    barcodeController.dispose();
    buyingPriceController.dispose();
    sellingPriceController.dispose();
    tagsController.dispose();
    minStockController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageUrl = pickedFile.path;
        imageUrlController.text = imageUrl!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.product != null;

    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Manuk POS"),
      drawer: const AppDrawer(),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.pushReplacement('/inventory/product/list-product');
            context.read<ProductBloc>().add(GetAllProductEvent());
          } else if (state is ProductOperationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  isEditMode ? 'Edit Product' : 'Add New Product',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _pickImage,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: imageUrl == null || imageUrl!.isEmpty
                            ? Center(child: Text("Tap to pick an image"))
                            : Image.file(
                                File(imageUrl!),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/default-product.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                CommonTextField(
                  label: 'Product Name',
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Name is required';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'Description',
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'SKU',
                  controller: skuController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'SKU is required';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'Barcode',
                  controller: barcodeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Barcode is required';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'Buying Price',
                  controller: buyingPriceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Buying Price is required';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'Selling Price',
                  controller: sellingPriceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Selling Price is required';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'Tags',
                  controller: tagsController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tags are required';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'Minimum Stock',
                  controller: minStockController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Minimum Stock is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final product = Product(
                        id: widget.product?.id ?? 0,
                        name: nameController.text,
                        description: descriptionController.text,
                        sku: skuController.text,
                        barcode: barcodeController.text,
                        buyingPrice: double.parse(buyingPriceController.text),
                        sellingPrice: double.parse(sellingPriceController.text),
                        tags: tagsController.text,
                        minStock: int.parse(minStockController.text),
                        imageUrl: imageUrl ?? '',
                        productCategoryId:
                            1, // Example category ID, replace with the actual value
                        isService:
                            false, // Example boolean flag, replace with actual value
                        isActive:
                            true, // Example boolean flag, replace with actual value
                        isFeatured:
                            false, // Example boolean flag, replace with actual value
                        allowFractions:
                            0, // Example value, replace with actual value
                        createdAt: DateTime.now().toIso8601String(),
                        updatedAt: DateTime.now().toIso8601String(),
                        // Example current date, replace with actual value
                      );

                      final bloc = context.read<ProductBloc>();
                      if (isEditMode) {
                        bloc.add(UpdateProductEvent(product.id, product));
                      } else {
                        bloc.add(AddProductEvent(product));
                      }
                    }
                  },
                  child: Text(isEditMode ? 'Update Product' : 'Create Product'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: -1),
    );
  }
}
