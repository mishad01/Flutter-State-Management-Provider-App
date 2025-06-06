import 'package:crud_app_using_provider/model/product_model.dart';
import 'package:crud_app_using_provider/provider/product_list_provider_way.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _imgController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  final TextEditingController _createdDateController = TextEditingController();

  void saveProduct(ProductListProvider productProvider) async {
    if (_formKey.currentState!.validate()) {
      /* final product = ProductModel(
        productName: _nameController.text.trim(),
        productCode: _codeController.text.trim(),
        img: _imgController.text.trim(),
        unitPrice: _unitPriceController.text.trim(),
        qty: _qtyController.text.trim(),
        totalPrice: _totalPriceController.text.trim(),
        createdDate: _createdDateController.text.trim(),
      );

      // For demo purposes, print product as JSON
      print(product.toJson());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Product saved successfully")),
      );*/
      final product = ProductModel(
        productName: _nameController.text.trim(),
        productCode: _codeController.text.trim(),
        img: _imgController.text.trim(),
        unitPrice: _unitPriceController.text.trim(),
        qty: _qtyController.text.trim(),
        totalPrice: _totalPriceController.text.trim(),
        createdDate: _createdDateController.text.trim(),
      );
      final isSuccess = await productProvider.addProductList(product);
      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Product saved successfully")),
        );
        Navigator.pop(context); // go back to home
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save product")),
        );
      }
    }
  }

  Widget _buildTextField(
      {required String label, required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Enter $label' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                  label: 'Product Name', controller: _nameController),
              SizedBox(height: 12),
              _buildTextField(
                  label: 'Product Code', controller: _codeController),
              SizedBox(height: 12),
              _buildTextField(label: 'Image URL', controller: _imgController),
              SizedBox(height: 12),
              _buildTextField(
                  label: 'Unit Price', controller: _unitPriceController),
              SizedBox(height: 12),
              _buildTextField(label: 'Quantity', controller: _qtyController),
              SizedBox(height: 12),
              _buildTextField(
                  label: 'Total Price', controller: _totalPriceController),
              SizedBox(height: 12),
              _buildTextField(
                  label: 'Created Date', controller: _createdDateController),
              SizedBox(height: 20),
              Consumer<ProductListProvider>(
                builder: (context, value, child) {
                  return ElevatedButton(
                    onPressed:
                        value.apiInProgress ? null : () => saveProduct(value),
                    child: value.apiInProgress
                        ? CircularProgressIndicator(strokeWidth: 2)
                        : Text('Save Product'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _imgController.dispose();
    _unitPriceController.dispose();
    _qtyController.dispose();
    _totalPriceController.dispose();
    _createdDateController.dispose();
    super.dispose();
  }
}
