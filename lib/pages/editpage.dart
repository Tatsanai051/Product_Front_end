import 'package:flutter/material.dart';
import 'package:flutter_lab1/controller/product_service.dart';
import 'package:flutter_lab1/models/product_model.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key, required this.product}) : super(key: key);
  final ProductModel product;

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();

  late String productName;
  late String productType;
  late int price;
  late String unit;

  @override
  void initState() {
    super.initState();
    productName = widget.product.productName;
    productType = widget.product.productType;
    price = widget.product.price;
    unit = widget.product.unit;
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedProduct = ProductModel(
        id: widget.product.id,
        productName: productName,
        productType: productType,
        price: price,
        unit: unit,
      );

      final success =
          await ProductService().updateProduct(updatedProduct, context);
      if (success) {
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to update product.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        backgroundColor: const Color.fromARGB(255, 0, 110, 20),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _updateProduct,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: productName,
                decoration: InputDecoration(
                  labelText: "Product Name",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) => productName = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter product name' : null,
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: productType,
                decoration: InputDecoration(
                  labelText: "Product Type",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) => productType = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter product type' : null,
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: price.toString(),
                decoration: InputDecoration(
                  labelText: "Price",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => price = int.tryParse(value) ?? 0,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter price' : null,
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: unit,
                decoration: InputDecoration(
                  labelText: "Unit",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) => unit = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter unit' : null,
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _updateProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 42, 208, 0),
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  child: Text(
                    "Update Product",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
