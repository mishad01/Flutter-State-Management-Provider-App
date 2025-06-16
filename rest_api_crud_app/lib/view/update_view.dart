import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_crud_app/model/product_model.dart';
import 'package:rest_api_crud_app/utils/custom_app_bar.dart';
import 'package:rest_api_crud_app/utils/custom_text_field.dart';
import 'package:rest_api_crud_app/view_model/get_product_view_model.dart';
import 'package:rest_api_crud_app/view_model/update_product_view_model.dart';

class UpdateView extends StatefulWidget {
  const UpdateView({
    super.key,
    required this.productName,
    required this.productCode,
    required this.img,
    required this.unitPrice,
    required this.qty,
    required this.totalPrice,
    required this.sId,
  });
  final String sId;
  final String productName;
  final String productCode;
  final String img;
  final String unitPrice;
  final String qty;
  final String totalPrice;

  @override
  State<UpdateView> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  late TextEditingController productNameController;
  late TextEditingController productCodeController;
  late TextEditingController imgController;
  late TextEditingController unitPriceController;
  late TextEditingController qtyController;
  late TextEditingController totalPriceController;

  @override
  void initState() {
    super.initState();
    productNameController = TextEditingController(text: widget.productName);
    productCodeController = TextEditingController(text: widget.productCode);
    imgController = TextEditingController(text: widget.img);
    unitPriceController = TextEditingController(text: widget.unitPrice);
    qtyController = TextEditingController(text: widget.qty);
    totalPriceController = TextEditingController(text: widget.totalPrice);
  }

  void updateProduct() async {
    ProductModel updatedProduct = ProductModel(
      sId: widget.sId,
      productName: productNameController.text,
      productCode: productCodeController.text,
      img: imgController.text,
      unitPrice: unitPriceController.text,
      qty: qtyController.text,
      totalPrice: totalPriceController.text,
      createdDate: DateTime.now().toString(),
    );

    final isUpdated = await Provider.of<UpdateProductViewModel>(
      context,
      listen: false,
    ).updateProduct(widget.sId, updatedProduct);

    if (isUpdated) {
      await Provider.of<GetProductViewModel>(context, listen: false)
          .getProduct();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Product Has Been Updated",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.greenAccent,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error Not added",
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
            ElevatedButton(
              onPressed: () {
                updateProduct();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              child: Text(
                "Update Product",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
