import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/product.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProduct();
  }
  final Firestore firestore = Firestore.instance;
  List<Product> allProducts = [];

  String _search = '';
  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Product> get filtredProducts {
    final List<Product> filtredProducts = [];

    if (search.isEmpty) {
      filtredProducts.addAll(allProducts);
    } else {
      filtredProducts.addAll(allProducts
          .where((p) => p.name.toLowerCase().contains(search.toLowerCase())));
    }
    return filtredProducts;
  }

  Future<void> _loadAllProduct() async {
    final QuerySnapshot snapProducts = await firestore
        .collection('produtos')
        .where('deleted', isEqualTo: false)
        .getDocuments();

    allProducts =
        snapProducts.documents.map((d) => Product.fromDocument(d)).toList();
    notifyListeners();
  }

  Product findProductById(String id) {
    try {
      return allProducts.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void update(Product product) {
    allProducts.removeWhere((p) => p.id == product.id);
    allProducts.add(product);
    notifyListeners();
  }

  void delete(Product product) {
    product.delete();
    allProducts.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }
}
