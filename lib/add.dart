import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/product_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}
class _AddProductState extends State<AddProduct> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var priceController = TextEditingController();
  var imageUrlCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            TextField(
              decoration:
              InputDecoration(labelText: "Title", hintText: "Add title"),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Description", hintText: "Add description"),
              controller: descController,
            ),
            TextField(
              decoration:
              InputDecoration(labelText: "Price", hintText: "Add price"),
              controller: priceController,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                  labelText: "Image Url",
                  hintText: "Paste your image url here"),
              controller: imageUrlCont,
            ),
            SizedBox(height: 30),
            Consumer<Product_Provider>(
              builder: (ctx, value, _) => RaisedButton(
                color: Colors.orangeAccent,
                textColor: Colors.black,
                child: Text("Add Product"),
                onPressed: () {
                  if (titleController.text.isEmpty ||
                      descController.text.isEmpty ||
                      priceController.text.isEmpty ||
                      imageUrlCont.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please enter all Fields",
                        );
                  } else {
                    try {
                      value.add_items(
                        Id: DateTime.now().toString(),
                        Title: titleController.text,
                        Description: descController.text,
                        Price: double.parse(priceController.text),
                        ImageUrl: imageUrlCont.text,
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      Fluttertoast.showToast(msg: "Please enter valid price",
                      );
                      print(e);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}