import 'package:flutter/material.dart';
import 'package:rest_api_crud_app/utils/custom_app_bar.dart';
import 'package:rest_api_crud_app/utils/custom_text_field.dart';

class UpdateView extends StatefulWidget {
  const UpdateView({super.key});

  @override
  State<UpdateView> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  @override
  Widget build(BuildContext context) {
    final productNameController = TextEditingController();
    final productCodeController = TextEditingController();
    final imgController = TextEditingController();
    final unitPriceController = TextEditingController();
    final qtyController = TextEditingController();
    final totalPriceController = TextEditingController();
    return Scaffold(
      appBar: customAppBar(
        context,
        "Update Product",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            customTextField(productNameController, "Product Name"),
            SizedBox(height: 20),
            customTextField(productCodeController, "Product Code"),
            SizedBox(height: 20),
            customTextField(imgController, "Product Image"),
            SizedBox(height: 20),
            customTextField(unitPriceController, "Product Unit Price"),
            SizedBox(height: 20),
            customTextField(qtyController, "Product Quantity"),
            SizedBox(height: 20),
            customTextField(totalPriceController, "Product Total Price"),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text("Update Product")),
          ],
        ),
      ),
    );
  }
}
