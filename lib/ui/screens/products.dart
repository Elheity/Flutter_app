import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product {
  final String id;
  final String title;
  final String description;
  final String url;
  final double price;
  final String imageUrl;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.url,
  });
}

class Products with ChangeNotifier {
  List<Product> productsList = [];

  Future<void> fetchData() async {
    final urls =
        "https://fir-flutter-c9345-default-rtdb.firebaseio.com/product.json";
    try {
      final http.Response res = await http.get(Uri.parse(urls));
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      extractedData.forEach((prodId, prodData) {
        final prodIndex =
            productsList.indexWhere((element) => element.id == prodId);
        if (prodIndex >= 0) {
          productsList[prodIndex] = Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            url: prodData['url'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
          );
        } else {
          productsList.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            url: prodData['url'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
          ));
        }
      });

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateData(String id) async {
    final urls =
        "https://fir-flutter-c9345-default-rtdb.firebaseio.com/product/$id.json";

    final prodIndex = productsList.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      await http.patch(Uri.parse(urls),
          body: json.encode({
            "title": "new title 4",
            "description": "new description 2",
            "url": "alexandria",
            "price": 199.8,
            "imageUrl":
                "https://cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297__340.jpg",
          }));

      notifyListeners();
    } else {
      print("...");
    }
  }

  Future<void> add(
      {String id,
      String title,
      String description,
      double price,
      String imageUrl,
      String url}) async {
    const urls =
        "https://fir-flutter-c9345-default-rtdb.firebaseio.com/product.json";
    try {
      http.Response res = await http.post(Uri.parse(urls),
          body: json.encode({
            "title": title,
            "description": description,
            "url": url,
            "price": price,
            "imageUrl": imageUrl,
          }));
      print(json.decode(res.body));

      productsList.add(Product(
        id: json.decode(res.body)['name'],
        title: title,
        description: description,
        url: url,
        price: price,
        imageUrl: imageUrl,
      ));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> delete(String id) async {
    final urls =
        "https://fir-flutter-c9345-default-rtdb.firebaseio.com/product/$id.json";

    final prodIndex = productsList.indexWhere((element) => element.id == id);
    var prodItem = productsList[prodIndex];
    productsList.removeAt(prodIndex);
    notifyListeners();

    var res = await http.delete(Uri.parse(urls));
    if (res.statusCode >= 400) {
      productsList.insert(prodIndex, prodItem);
      notifyListeners();
      print("Could not deleted item");
    } else {
      prodItem = null;
      print("Item deleted");
    }
  }
}
