import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renthub_app/screens/home_rent_screen.dart';

class UpdateProductScreen extends StatelessWidget {
  static const routeId = '/update_product_screen';

  String? docProduct;
  String? docName;
  int? docStock;
  UpdateProductScreen(this.docProduct);
  TextEditingController _name = new TextEditingController();
  TextEditingController _stock = new TextEditingController();
  CollectionReference _products = FirebaseFirestore.instance.collection('Products');
                      
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Ubah produk"), 
      ),
      body: 
          Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:<Widget>[
             Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 50),
                  Text(
                    "Nama produk",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _name,
                    
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Isi nama terbaru"
                      
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Stok produk",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _stock,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Isi stok terbaru"
                    ),
                  ),
                  
                  SizedBox(
                    height: 30,
                  ),
                  
                ],
              ),
              SizedBox(height: 30),
              MaterialButton(
                minWidth: 500,
                child: Text(
                  'Simpan perubahan',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                ),
                color: Theme.of(context).primaryColor,
                textTheme: ButtonTextTheme.primary,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                onPressed: () {
                  _products.doc(docProduct).update({
                    'name': _name.text, 
                    'stock': int.parse(_stock.text)
                    });
                  Navigator.pop(context);
                }),
              
          ]
        )
      )
    );
  }
}
