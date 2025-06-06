import 'package:crud_app_using_provider/model/product_model.dart';
import 'package:crud_app_using_provider/provider/product_list_provider_way.dart';
import 'package:crud_app_using_provider/view/add_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ProductListProvider>(context, listen: false)
            .getProductList());
  }

  void onUpdate(BuildContext context, ProductModel product,
      ProductListProvider productListProvider) {
    final nameController = TextEditingController(text: product.productName);
    final codeController = TextEditingController(text: product.productCode);
    final qtyController = TextEditingController(text: product.qty);
    final unitPriceController = TextEditingController(text: product.unitPrice);
    final imageController = TextEditingController(text: product.img);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Product'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                ),
                TextField(
                  controller: codeController,
                  decoration: const InputDecoration(labelText: 'Product Code'),
                ),
                TextField(
                  controller: qtyController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: unitPriceController,
                  decoration: const InputDecoration(labelText: 'Unit Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: imageController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty ||
                    codeController.text.isEmpty ||
                    qtyController.text.isEmpty ||
                    unitPriceController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please fill all required fields')),
                  );
                  return;
                }

                final updatedProduct = ProductModel(
                  sId: product.sId, // Preserve the original ID
                  productName: nameController.text,
                  productCode: codeController.text,
                  qty: qtyController.text,
                  unitPrice: unitPriceController.text,
                  img: imageController.text,
                );

                final success = await productListProvider.updateProduct(
                    updatedProduct, product.sId!);

                if (success) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Product updated successfully')),
                    );
                    Navigator.pop(context);
                  }
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to update product')),
                    );
                  }
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductListProvider>(
      builder: (context, productProvider, child) {
        final productList = productProvider.productList;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text(
              "Crud App Using Provider",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProductScreen(),
                    ),
                  );
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: Visibility(
            visible: !productProvider.apiInProgress,
            replacement: Center(child: CircularProgressIndicator()),
            child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return ListTile(
                  leading: product.img != null
                      ? Image.network(
                          product.img!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.broken_image),
                        )
                      : Icon(Icons.image_not_supported),
                  title: Text(product.productName ?? 'No name'),
                  subtitle: Text(
                    'Code: ${product.productCode ?? 'N/A'}\n'
                    'Qty: ${product.qty ?? '0'} x Price: ${product.unitPrice ?? '0'}'
                    'id: ${product.sId}',
                  ),
                  trailing: SizedBox(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        /* Text(
                          '৳${product.totalPrice ?? '0'}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),*/
                        IconButton(
                          onPressed: () async {
                            productProvider.deleteProduct(
                                product, product.sId!);
                            await productProvider
                                .getProductList(); // Refresh the list
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            onUpdate(context, product, productProvider);
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
