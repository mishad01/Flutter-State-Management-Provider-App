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
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '৳${product.totalPrice ?? '0'}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
                        )
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
