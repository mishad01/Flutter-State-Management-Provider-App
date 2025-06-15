import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_apk/model/product_model.dart';
import 'package:test_apk/provider/delete_product_provider.dart';
import 'package:test_apk/provider/get_product_provider.dart';
import 'package:test_apk/provider/post_product_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final titleController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
      () {
        Provider.of<GetProductProvider>(context, listen: false).getProduct();
      },
    );
  }

  void addProduct(String title) async {
    if (title.trim().isEmpty) return;
    final product = ProductModel(
      createdDate: DateTime.now().toString(),
      productName: title,
      img: "none",
      unitPrice: "0",
      qty: "1",
      totalPrice: "0",
      productCode: "001",
    );
    final postProvider =
        Provider.of<PostProductProvider>(context, listen: false);
    final isPosted = await postProvider.postRequest(product);

    if (isPosted) {
      titleController.clear();
      Provider.of<GetProductProvider>(context, listen: false).getProduct();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Product Added")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to add product")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final getProductProvider = Provider.of<GetProductProvider>(context);
    final deleteProductProvider = Provider.of<DeleteProductProvider>(context);
    final products = getProductProvider.productList;
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest Api Integration "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      label: Text("Input Name"),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    addProduct(titleController.text);
                  },
                  icon: Icon(Icons.add),
                ),
                /* IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                )*/
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.productName!),
                    subtitle: Text(product.createdDate!),
                    trailing: Wrap(
                      children: [
                        Visibility(
                          visible: !(deleteProductProvider.inProgress &&
                              deleteProductProvider.deletingId == product.sId),
                          replacement: CircularProgressIndicator(),
                          child: IconButton(
                            onPressed: () async {
                              final isDeleted = await deleteProductProvider
                                  .deleteProduct(product.sId!);
                              if (isDeleted) {
                                Provider.of<GetProductProvider>(context,
                                        listen: false)
                                    .getProduct();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Product deleted')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Failed to delete product')),
                                );
                              }
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
