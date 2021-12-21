import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:renthub_app/data/model/product_model.dart';
import 'package:renthub_app/screens/home_cust_screen.dart';

class DetailClothesScreen extends StatefulWidget {
  static const String routeId = 'detail_clothes_screen';
  
  final ProductModel product;
  const DetailClothesScreen({required this.product});
  @override
  _DetailClothesScreen createState() => _DetailClothesScreen();
  
}

class _DetailClothesScreen extends State<DetailClothesScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail Clothes"),
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, HomeCustcreen.routeId);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 400.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image:  DecorationImage(
                      image: NetworkImage(
                        widget.product.urlPhotos!,
                      ),
                      fit: BoxFit.cover),
                ),
              ),
            ),
             Padding(
              padding: EdgeInsets.all(10.0),

              child: Text(
                widget.product.name,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                'RP. ${widget.product.price}',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            const SizedBox(height: 30.0),
            const Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 5.0),
              child: Text(
                'Descriptions :',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
              child: Text(
                widget.product.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: SizedBox(
                height: 30,
                child: MaterialButton(
                    child: const Text('Rent'),
                    color: Theme.of(context).primaryColor,
                    textTheme: ButtonTextTheme.primary,
                    height: 40,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    onPressed: () {}),
              ),
            ),
          ]),
        ));
  }
}
