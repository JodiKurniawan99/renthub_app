import 'package:flutter/material.dart';

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

class ListOrderScreen extends StatelessWidget {
  static const routeId = '/list_order_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesanan baru")
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
    title: Padding(
      padding:EdgeInsets.only(top: 10) ,
      child:Text(arr[index]) ,),
     
    subtitle: Row(
      children: <Widget>[
        MaterialButton(
            child: Text('Terima'),
            color: Colors.greenAccent,
            textTheme: ButtonTextTheme.primary,
            height: 25,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onPressed: () {
              
            }),
            SizedBox(width: 10,),

            MaterialButton(
            child: Text('Tolak'),
            color: Colors.redAccent,
            textTheme: ButtonTextTheme.primary,
            height: 26,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onPressed: () {
              
            }),
      ]
    )
    
  );
}
