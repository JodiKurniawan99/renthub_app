import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:renthub_app/screens/add_product_screen.dart';
import 'package:renthub_app/screens/update_product_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListRentScreen extends StatelessWidget{
  static const routeId = '/list_rent_screen';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("List Produk"),
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
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical:6.0),
                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, UpdateProductScreen.routeId, arguments: document.id);
                  },
                  child: Card(
                    elevation: 0.0,
                    color: Color(0xFFf2f2f2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child:
                                          CachedNetworkImage(
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover,
                                            imageUrl: document['urlPhotos'],
                                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress),
                                                    errorWidget: (context, url, error) => Icon(Icons.hide_image),
                                           ),                                         
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                document['name'],
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                
                                              ),
                                              SizedBox(height: 10),
                                              Text("Stok: " +
                                                  document['stock'].toString()),
                                              Text("Harga: " +
                                                  document['price'].toString())
                                            ]),
                                        SizedBox(
                                          width: 30,
                                        ),
                                      ]),
                                      IconButton(
                                          onPressed: () async {
                                            FirebaseFirestore.instance
                                                .collection('Products')
                                                .doc(document.id)
                                                .delete();
                                            Reference refer = FirebaseStorage
                                                .instance
                                                .refFromURL(
                                                    document['urlPhotos']);
                                            await refer.delete();
                                          },
                                          icon: Icon(Icons.delete,
                                              color: Colors.redAccent))
                                    ],
                                  ))
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
