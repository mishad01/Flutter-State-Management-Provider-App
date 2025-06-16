import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_crud_app/utils/custom_app_bar.dart';
import 'package:rest_api_crud_app/view_model/search_app/search_product_view_model.dart';

class SearchItemAppHome extends StatefulWidget {
  const SearchItemAppHome({super.key});

  @override
  State<SearchItemAppHome> createState() => _SearchItemAppHomeState();
}

class _SearchItemAppHomeState extends State<SearchItemAppHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProductViewModel>(context);
    final allProducts = provider.getSearchedProduct();
    return Scaffold(
      appBar: customAppBar(context, "Vote Candidate App"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                label: Text("Search"),
              ),
              onChanged: (value) {
                provider.updatedSearchItem(value);
              },
            ),
            DropdownButton<String>(
              value: provider.allCategory.contains(provider.selectedCategory)
                  ? provider.selectedCategory
                  : 'All',
              items: provider.allCategory.map(
                (e) {
                  return DropdownMenuItem(child: Text(e), value: e);
                },
              ).toList(),
              onChanged: (value) {
                if (value != null) {
                  provider.updateCategory(value);
                }
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allProducts.length,
                itemBuilder: (context, index) {
                  final product = allProducts[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text(product.category),
                    trailing: Text(product.price.toString()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
