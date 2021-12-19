import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renthub_app/screens/home_rent_screen.dart';

class UpdateProductScreen extends StatelessWidget {
  static const routeId = '/update_product_screen';

  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = 'baju adat';

    return Scaffold(
      appBar: AppBar(
        title: Text("Ubah produk"), 
      ),
      body: Padding(
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
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
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
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Status produk",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Ubah status produk"),
                        Switch.adaptive(value: true, onChanged: (value) {})
                      ]),
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
                  Navigator.pushReplacementNamed(
                    context, HomeRentScreen.routeId);
                }),
              
          ]
        )
      )
    );
  }
}
