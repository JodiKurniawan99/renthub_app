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

class ListCustOrder extends StatelessWidget {
  static const routeId = '/list_cust_order';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barang dalam sewaan"),
      ),
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
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        "https://cf.shopee.co.id/file/206c055c74c174b02717ef73f791fb3c",
        width: 80,
        fit: BoxFit.cover,
      ),
    ),
    title: Row(
      
      children: <Widget>[
        Text(arr[index]),
        SizedBox(width: 100,),
        Text("Asep"),
      ],
    ),
    
    subtitle: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text("dikembalikan: Rabu,15-12-2021"),
        
      ],
    ),   
  );
}
