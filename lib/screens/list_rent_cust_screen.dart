import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:renthub_app/data/model/cust_model.dart';

class ListRentCustScreen extends StatefulWidget {
  static const routeId = 'list_rent_cust_screen';

  @override
  _ListRentCustScreen createState() => _ListRentCustScreen();
}

class _ListRentCustScreen extends State<ListRentCustScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  CustModel _user = CustModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
      _user = CustModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 70,
          title: Text("Sewa"),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Theme.of(context).primaryColor),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Rent')
              .where('customerEmail', isEqualTo: '${_user.email}')
              .snapshots(),
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
                                            Text(
                                              "Sewa : ${document['dateRent'].toString()}",
                                              style: TextStyle(
                                                fontSize: 11,
                                              ),
                                            ),
                                            Text(
                                              "Kembali : ${document['dateReturn'].toString()}",
                                              style: TextStyle(
                                                fontSize: 11,
                                              ),
                                            ),
                                            Text(
                                                "Rp. " +
                                                    document['cost'].toString(),
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ]),
                                      SizedBox(
                                        width: 30,
                                      ),
                                    ]),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Divider(color: Colors.grey),
                                ),
                                Container(
                                    padding: EdgeInsets.only(
                                        right: 10.0, bottom: 5.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text('Status : ' +
                                          document['status'].toString()),
                                    ))
                              ])));
                    }).toList(),
                  )
                : Center(child: CircularProgressIndicator());
          },
        ));
  }
}
