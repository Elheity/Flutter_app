import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'products.dart';

class ProductDetails extends StatelessWidget {
  final String id;

  ProductDetails(this.id);

  @override
  Widget build(BuildContext context) {
    List<Product> prodList =
        Provider.of<Products>(context, listen: true).productsList;

    var filteredItem =
        prodList.firstWhere((element) => element.id == id, orElse: () => null);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: filteredItem == null ? null : Text(filteredItem.title),
        actions: [
          FlatButton(
              onPressed: () =>
                  Provider.of<Products>(context, listen: false).updateData(id),
              child: Text("Update Data"))
        ],
      ),
      body: filteredItem == null
          ? null
          : ListView(
              children: [
                SizedBox(height: 10),
                buildContainer(filteredItem.imageUrl, filteredItem.id),
                SizedBox(height: 10),
                buildCard(
                  filteredItem.title,
                  filteredItem.description,
                  filteredItem.price,
                  filteredItem.url,
                )
              ],
            ),
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.pop(context, filteredItem.id);
        },
        child: Icon(Icons.delete, color: Colors.black),
      ),*/
    );
  }

  Container buildContainer(String image, String id) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Hero(
          tag: id,
          child: Image.network(image),
        ),
      ),
    );
  }

  Card buildCard(String title, String desc, double price, String url) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(7),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(color: Colors.red[900]),
            Text(desc,
                style: TextStyle(fontSize: 22), textAlign: TextAlign.justify),
            SizedBox(
              height: 10,
            ),
            Divider(color: Colors.red[900]),
            Column(
              children: [
                Text(
                  "\$$price",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(color: Colors.red[900]),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: RaisedButton(
                  onPressed: () async => await canLaunch(url)
                      ? await launch(url)
                      : throw 'Could not launch url',
                  child: Text(
                    'Get',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
