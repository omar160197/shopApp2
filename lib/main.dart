import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/product_provider.dart';
import 'add.dart';
import 'details.dart';

void main() => runApp(
      ChangeNotifierProvider<Product_Provider>(
        create: (_) => Product_Provider(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.orange,
          canvasColor: Color.fromRGBO(255, 238, 219, 1)),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget buildText(title, desc, double price) {
      return Positioned(
        bottom: 7,
        right: 20,
        child: Container(
          width: 70,
          height: 70,
          color: Colors.black54,
          margin: EdgeInsets.only(left: 100, top: 20),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
          child: Text(
            "$title\n$desc\n\$$price",
            style: TextStyle(fontSize: 15, color: Colors.white),
            softWrap: true,
            overflow: TextOverflow.fade,
            maxLines: 4,
          ),
        ),
      );
    }

    List<Product_model> prodList =
        Provider.of<Product_Provider>(context).productsList;

    return Scaffold(
      appBar: AppBar(title: Text('My Products')),
      body: prodList.isEmpty
          ? Center(
              child: Text('No Products Added.', style: TextStyle(fontSize: 22)))
          : GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                maxCrossAxisExtent: 355,
                childAspectRatio: 1.5,
              ),
              children: prodList
                  .map(
                    (item) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Details_Product(item.id),
                          ),
                        ).then((id) =>
                            Provider.of<Product_Provider>(context, listen: false).delete(id));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 6,
                        margin: EdgeInsets.all(7),
                        child: Stack(
                          children: [
                            Hero(
                              tag: item.id,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                child: Image.network(item.imageUrl),
                              ),
                            ),
                            buildText(item.title, item.description, item.price),
                            Positioned(
                              right: 4,
                              bottom: 4,
                              child: Container(
                                width: 40,
                                height: 40,
                                child: FloatingActionButton(
                                  heroTag: item.title,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  onPressed: () =>
                                      Provider.of<Product_Provider>(context,
                                              listen: false)
                                          .delete(item.description),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
      floatingActionButton: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Theme.of(context).primaryColor,
        ),
        child: FlatButton.icon(
          label: Text("Add Product",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
          icon: Icon(Icons.add),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddProduct(),))
        ),
      ),
    );
  }
}
