import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:renthub_app/screens/detail_clothes_screen.dart';

class ListClothesScreen extends StatefulWidget {
  static const String routeId = 'list_clothes_screen';
  @override
  _ListClothesScreen createState() => _ListClothesScreen();
}

class _ListClothesScreen extends State<ListClothesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.count(
      primary: false,
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      childAspectRatio: (1 / 1.5),
      children: List.generate(
        5,
        (index) {
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, DetailClothesScreen.routeId);
                },
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: const DecorationImage(
                                    image: NetworkImage(
                                      "https://images.unsplash.com/photo-1594938328870-9623159c8c99?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80",
                                    ),
                                    fit: BoxFit.cover)))),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Setelan Jas Navy',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const Text(
                      'RP. 100.000',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5.0),
                  ],
                )),
          );
        },
      ),
    ));
  }
}
