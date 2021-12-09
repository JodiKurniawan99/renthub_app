import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DetailClothesScreen extends StatefulWidget {
  static const String routeId = 'detail_clothes_screen';
  @override
  _DetailClothesScreen createState() => _DetailClothesScreen();
}

class _DetailClothesScreen extends State<DetailClothesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail Clothes"),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 400.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: const DecorationImage(
                      image: NetworkImage(
                        "https://images.unsplash.com/photo-1594938328870-9623159c8c99?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80",
                      ),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Setelan Jas Navy',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                'RP. 100.000',
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
            const Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
              child: Text(
                'Bahan terbuat dari kain pilihan terbaik sehingga nyaman dipakai. Cocok untuk menghadiri acara formal.',
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
