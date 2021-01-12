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
    final QuerySnapshot snapProducts =
        await firestore.collection('produtos').getDocuments();

    allProducts =
        snapProducts.documents.map((d) => Product.fromDocument(d)).toList();
    notifyListeners();
  }
}
