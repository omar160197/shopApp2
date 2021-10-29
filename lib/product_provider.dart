import 'package:flutter/cupertino.dart';

class Product_model {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  Product_model({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class Product_Provider with ChangeNotifier {
  List<Product_model> productsList = [];

  void delete(String Des) {
    productsList.removeWhere((element) => element.description == Des);
    notifyListeners();
  }

  void add_items({
    required String Title,
    required String Id,
    required String Description,
    required double Price,
    required String ImageUrl,
  }) {
    productsList.add(
      Product_model(
          id: Id,
          title: Title,
          description: Description,
          price: Price,
          imageUrl: ImageUrl),
    );
    notifyListeners();
  }
}
