import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_provider.dart';

class Details_Product extends StatelessWidget {
  final String id;
  Details_Product(this.id);
  @override
  Widget build(BuildContext context) {
    List<Product_model> productsList =
        Provider
            .of<Product_Provider>(context, listen: true)
            .productsList;
    var filteredItem =
    productsList.firstWhere((element) => element.id == id, orElse: null);
    return Scaffold(body: Column(
      children: [
        Stack(children: [
          Container(
            width: MediaQuery
        .of(context)
        .size
        .width,
            height: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(offset: Offset(0.0, 0.2),
                    blurRadius: 6.0,
                    color: Colors.black26),
              ],
            ),
            child: Hero(
              tag: id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.network(
                  filteredItem.imageUrl, fit: BoxFit.cover,),),
            ),
          ),
        ],
        ),
      ],
    ),);
  }
}
