import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ListOrderScreen extends StatelessWidget {
  static const routeId = '/list_order_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesanan baru")
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Rent').where('status',isEqualTo: 'confirmation').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData
                ? ListView(
                    children: snapshot.data!.docs.map((document) {
                      return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 6.0),
                          child: Card(
                            color: Color(0xFFf2f2f2),
                            elevation: 0.0,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 8.0,top:8.0),
                                          child:  ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: CachedNetworkImage(
                                              height: 70,
                                              width: 70,
                                              fit: BoxFit.cover,
                                              imageUrl: document['urlPhotos'],
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.hide_image),
                                            ),
                                        ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(height: 8,),
                                              Text(
                                                document['product'],
                                                style: TextStyle(
                                                  fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                document['customerName'].toString(),
                                                style: TextStyle(
                                                  fontSize: 11,
                                                ),
                                              ),
                                              Text(
                                                  "${document['dateRent'].toString()} - ${document['dateReturn'].toString()}",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                  ),),
                                              Text("Total: Rp. " +
                                                  document['cost'].toString(),
                                                   style: TextStyle(
                                                    fontSize: 11,
                                                  ))
                                            ]),
                                        SizedBox(
                                          width: 30,
                                        ),
                                      ]),
                                    ],
                                  ),
                                  SizedBox(height:10),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Divider(color: Colors.grey),
                                  ),
                                  Row(
                                    mainAxisAlignment:MainAxisAlignment.center,
                                    children: <Widget>[
                                    MaterialButton(
                                        child: Text(
                                          'Terima', 
                                        ),
                                        color: Colors.green,
                                        textTheme: ButtonTextTheme.primary,
                                        height: 30,
                                        minWidth: 220,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        onPressed: () {
                                          CollectionReference _rentStatus =
                                                  FirebaseFirestore.instance
                                                      .collection('Rent');
                                         _rentStatus.doc(document.id).update({

                                                "status": "accepted"
                                              });
                                        }),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    MaterialButton(
                                        child: Text('Tolak',),
                                        color: Colors.red,
                                        textTheme: ButtonTextTheme.primary,
                                        height: 30,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        onPressed: () {
                                          CollectionReference _rentStatus =
                                                  FirebaseFirestore.instance
                                                      .collection('Rent');
                                              _rentStatus
                                                  .doc(document.id)
                                                  .delete();
                                        }),
                                  ]) 
                                    ],
                                  )
                                )
                              );
                    }).toList(),
                  )
                : Center(child: CircularProgressIndicator());
          },
        )
    );
  }
}
