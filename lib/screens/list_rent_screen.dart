import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:renthub_app/screens/add_product_screen.dart';
import 'package:renthub_app/screens/update_product_screen.dart';

class ListRentScreen extends StatelessWidget{
  static const routeId = '/list_rent_screen';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("produk"),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, AddProductScreen.routeId);
            }, 
            icon: Icon(
              Icons.add,
            
            ) )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData? 
          ListView(
            children: snapshot.data!.docs.map((document) {
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                document['urlPhotos'],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(document['name']),
                                  Text("Stok: " + document['stock'].toString()),
                                  Text("Harga: " + document['price'].toString())
                                ]),
                            SizedBox(
                              width: 30,
                            ),
                          ])

                    ,
                    IconButton(
                    onPressed:(){},
                    icon: Icon(Icons.delete, color:Colors.redAccent)
                  )   

                  ],
                )             
              );
            }).toList(),
          ):
          Center(
            child: CircularProgressIndicator()
          );
        },
      ));
  }
}
