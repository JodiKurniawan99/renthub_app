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
                                          child: Image.network(
                                            document['urlPhotos'],
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover,
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
                                      // IconButton(
                                      //     onPressed: () async {
                                      //       FirebaseFirestore.instance
                                      //           .collection('Products')
                                      //           .doc(document.id)
                                      //           .delete();
                                      //       Reference refer = FirebaseStorage
                                      //           .instance
                                      //           .refFromURL(
                                      //               document['urlPhotos']);
                                      //       await refer.delete();
                                      //     },
                                      //     icon: Icon(Icons.delete,
                                      //         color: Colors.redAccent))
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

// Widget _buildListItem(BuildContext context, int index) {
//   return ListTile(
//     contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    
//     leading: ClipRRect(
//       borderRadius: BorderRadius.circular(8.0),
//       child: Image.network(
//         "https://cf.shopee.co.id/file/206c055c74c174b02717ef73f791fb3c",
//         width: 80,
//         fit: BoxFit.cover,
//       ),
//     ),
//     title: Padding(
//       padding:EdgeInsets.only(top: 10) ,
//       child:Text(arr[index]) ,),
     
//     subtitle: Row(
//       children: <Widget>[
//         MaterialButton(
//             child: Text('Terima'),
//             color: Colors.greenAccent,
//             textTheme: ButtonTextTheme.primary,
//             height: 25,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             onPressed: () {
              
//             }),
//             SizedBox(width: 10,),

//             MaterialButton(
//             child: Text('Tolak'),
//             color: Colors.redAccent,
//             textTheme: ButtonTextTheme.primary,
//             height: 26,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             onPressed: () {
              
//             }),
//       ]
//     )
    
//   );
// }
