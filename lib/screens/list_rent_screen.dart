import 'package:flutter/material.dart';
import 'package:renthub_app/screens/update_product_screen.dart';
var arr = [
    "baju adat",
    "baju adat",
    "baju adat",
    "baju adat",
    "baju adat",
    "baju adat",
    "baju adat",
    "baju adat",
    "baju adat",
    "baju adat",  
  ];
class ListRentScreen extends StatelessWidget{
  static const routeId = '/list_rent_screen';
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
    itemCount: arr.length,
    itemBuilder: (context, index) {
      return _buildListItem(context, index);
    },
   ),
    );
  }

}
Widget _buildListItem(BuildContext context, int index) {
  return ListTile(
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading:ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                "https://cf.shopee.co.id/file/206c055c74c174b02717ef73f791fb3c",
                width: 80,
                fit: BoxFit.cover,
              ),
            ),     
    title: Text(arr[index]),
    subtitle: Text("Stok barang: 1"),
    onTap: () {Navigator.pushReplacementNamed(
                      context, UpdateProductScreen.routeId);
                },
  );
}