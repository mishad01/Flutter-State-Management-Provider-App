import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_crud_app/view_model/get_product_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
      () {
        Provider.of<GetProductViewModel>(context, listen: false).getProduct();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final getProductProvider = Provider.of<GetProductViewModel>(context);
    final productLists = getProductProvider.productList;
    return Scaffold(
      appBar: buildAppBar(),
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
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: productLists.length,
                itemBuilder: (context, index) {
                  final product = productLists[index];
                  return ListTile(
                    title: Text(product.productName!),
                    subtitle: Text(product.createdDate!),
                    trailing: Wrap(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.delete),
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
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      title: Text(
        "Rest Api Crud App",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
