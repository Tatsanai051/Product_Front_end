import 'package:flutter/material.dart';
import 'package:flutter_lab1/providers/user_providers.dart';
import 'package:flutter_lab1/variables.dart';
import 'package:flutter_lab1/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class ProductService {
  Future<List<ProductModel>> fetchProducts(BuildContext context) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final response = await http.get(
        Uri.parse('$apiURL/api/products'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${userProvider.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((product) => ProductModel.fromJson(product))
            .toList();
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Caught error: $e');
      throw Exception('Failed to load products: $e');
    }
  }

  Future<bool> addProduct(BuildContext context, ProductModel product) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final response = await http.post(
        Uri.parse('$apiURL/api/product'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${userProvider.accessToken}',
        },
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        print('Failed to add product: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error adding product: $e');
      return false;
    }
  }

  Future<bool> deleteProduct(BuildContext context, String productId) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final response = await http.delete(
        Uri.parse('$apiURL/api/product/$productId'),
        headers: <String, String>{
          'Authorization':
              'Bearer ${userProvider.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to delete product: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error deleting product: $e');
      return false;
    }
  }

  Future<bool> updateProduct(ProductModel product, BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final response = await http.put(
        Uri.parse(
            '$apiURL/api/product/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userProvider.accessToken}',
        },
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to update product: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error updating product: $e');
      return false;
    }
  }
}
