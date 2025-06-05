import 'package:crud_app_using_provider/provider/product_list_provider_way.dart';
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
              Icon(
                Icons.add,
                color: Colors.white,
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              final product = productList[index];
              return ListTile(
                title: Text(product.productName ?? 'No name'),
              );
            },
          ),
        );
      },
    );
  }
}
