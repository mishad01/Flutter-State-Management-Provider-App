import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_crud_app/model/rest_api_crud/product_model.dart';
import 'package:rest_api_crud_app/utils/custom_app_bar.dart';
import 'package:rest_api_crud_app/utils/navigation_utils.dart';
import 'package:rest_api_crud_app/view/rest_api_crud/update_view.dart';
import 'package:rest_api_crud_app/view_model/rest_api_crud/add_product_view_model.dart';
import 'package:rest_api_crud_app/view_model/rest_api_crud/delete_product_view_model.dart';
import 'package:rest_api_crud_app/view_model/rest_api_crud/get_product_view_model.dart';

class RestApiHomePage extends StatefulWidget {
  const RestApiHomePage({super.key});

  @override
  State<RestApiHomePage> createState() => _RestApiHomePageState();
}

class _RestApiHomePageState extends State<RestApiHomePage> {
  final titleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // ✅ Safe way to call ViewModel in initState:
    Future.microtask(() {
      if (!mounted) return;
      context.read<GetProductViewModel>().getProductOnce();
    });
  }

  void addProduct(String title) async {
    final product = ProductModel(
      productName: title,
      img: "No Image Test",
      productCode: '111',
      qty: "10",
      totalPrice: "1000",
      unitPrice: "100",
      createdDate: DateTime.now().toString(),
    );

    bool isAdded =
        await context.read<AddProductViewModel>().addProduct(product);
    if (!mounted) return;

    if (isAdded) {
      titleController.clear();
      await context.read<GetProductViewModel>().getProduct();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Product Has Been Added",
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.greenAccent,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error Not added"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void deleteProduct(String id) async {
    final isDeleted =
        await context.read<DeleteProductViewModel>().deleteProduct(id);

    if (isDeleted) {
      if (!mounted) return;
      await context.read<GetProductViewModel>().getProduct();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Product Has Been Deleted",
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.greenAccent,
        ),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Can't Delete"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final getProductProvider = context.watch<GetProductViewModel>();
    final deleteProductProvider = context.watch<DeleteProductViewModel>();
    final productLists = getProductProvider.productList;

    return Scaffold(
      appBar: customAppBar(
        context,
        "Rest Api Crud App",
        icon: Icons.add,
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
                      label: Text("Enter Title"),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    addProduct(titleController.text);
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: Visibility(
                visible: !getProductProvider.inProgress,
                replacement: Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await context.read<GetProductViewModel>().getProduct();
                  },
                  child: ListView.builder(
                    itemCount: productLists.length,
                    itemBuilder: (context, index) {
                      final product = productLists[index];
                      return ListTile(
                        title: Text(product.productName ?? "No Name"),
                        subtitle: Text(product.createdDate ?? "No Date"),
                        trailing: Wrap(
                          children: [
                            Visibility(
                              visible: !(deleteProductProvider.inProgress &&
                                  deleteProductProvider.deletingId ==
                                      product.sId),
                              replacement: SizedBox(
                                height: 24,
                                width: 24,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  deleteProduct(product.sId ?? "");
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                NavigationUtils.pushTo(
                                  context,
                                  UpdateView(
                                    sId: product.sId ?? "",
                                    productName: product.productName ?? "",
                                    productCode: product.productCode ?? "",
                                    img: product.img ?? "",
                                    unitPrice: product.unitPrice ?? "",
                                    qty: product.qty ?? "",
                                    totalPrice: product.totalPrice ?? "",
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
