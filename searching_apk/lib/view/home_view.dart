import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searching_apk/provider/product_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final products = provider.getSearchedProduct(); // <- fixed

    return Scaffold(
      appBar: AppBar(title: Text('Product Browser')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Search', border: OutlineInputBorder()),
              onChanged: (value) {
                provider.updateSearchItem(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: provider.categories.contains(provider.selectCategory)
                  ? provider.selectCategory
                  : 'All',
              items: provider.categories.map(
                (e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                },
              ).toList(),
              onChanged: (value) {
                if (value != null) {
                  provider.updateSelectedCategory(value);
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
