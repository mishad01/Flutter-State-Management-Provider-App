import 'package:crud_app_using_provider/provider/product_list_provider_way.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProductListProvider>(context, listen: false).getProductList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductListProvider>(context);
    final productList = productProvider.productList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Crud App Using Provider",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Icon(
            Icons.add,
            color: Colors.white,
          ),
        ],
      ),
      body: productProvider.apiInProgress
          ? const Center(child: CircularProgressIndicator())
          : productList.isEmpty
              ? const Center(child: Text("No products found."))
              : ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    final product = productList[index];
                    return ListTile(
                      title: Text(product.productName ?? 'Unnamed'),
                      subtitle: Text("Price: ${product.unitPrice ?? 'N/A'}"),
                    );
                  },
                ),
    );
  }
}
