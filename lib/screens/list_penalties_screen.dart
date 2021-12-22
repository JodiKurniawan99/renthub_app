import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class ListPenaltiesScreen extends StatelessWidget {
  static const routeId = '/list_penalties_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Barang dalam sewaan"),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Rent')
              .where('status', isEqualTo: 'penalty')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData
                ? ListView(
                    children: snapshot.data!.docs.map((document) {
                      DateTime now = DateTime.now();
                      String formatDateNow = DateFormat('yyyy-MM-dd').format(now);
                      final dayCounter = DateTime.parse(formatDateNow).difference(DateTime.parse(document['dateReturn'])).inDays;
                      final cost = (dayCounter * document['penalty']);
                      return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 6.0),
                          child: Card(
                              color: Color(0xFFf2f2f2),
                              elevation: 0.0,
                              child: Column(children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0, top: 8.0),
                                        child: ClipRRect(
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
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              document['product'],
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              document['customerName']
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 11,
                                              ),
                                            ),
                                            Text(
                                              "Tanggal kembali: ${document['dateReturn'].toString()}",
                                              style: TextStyle(
                                                fontSize: 11,
                                              ),
                                            ),
                                            Text(
                                                "Denda: Rp. " +
                                                    cost.toString(),
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
                                SizedBox(height: 10),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Divider(color: Colors.grey),
                                ),
                                MaterialButton(
                                    child: Text(
                                      'Konfirmasi pembayaran denda',
                                    ),
                                    color: Colors.red,
                                    textTheme: ButtonTextTheme.primary,
                                    height: 30,
                                    minWidth: 320,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    onPressed: () {
                                      CollectionReference _rentStatus =
                                          FirebaseFirestore.instance
                                              .collection('Rent');
                                      _rentStatus.doc(document.id).delete();
                                    }),
                                SizedBox(
                                  width: 10,
                                ),
                              ])));
                    }).toList(),
                  )
                : Center(child: CircularProgressIndicator());
          },
        ));
  }
}
