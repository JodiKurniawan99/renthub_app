import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:renthub_app/data/model/product_model.dart';
import 'package:renthub_app/screens/detail_clothes_screen.dart';

class ListClothesScreen extends StatefulWidget {
  static const String routeId = 'list_clothes_screen';
  @override
  _ListClothesScreen createState() => _ListClothesScreen();
}

class _ListClothesScreen extends State<ListClothesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 60,
        title: Text("RentHub"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(22),
                  bottomRight: Radius.circular(22)),
              color: Theme.of(context).primaryColor),
        ),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Products').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Loading. . .'));
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: (1 / 1.5),
              ),
              itemBuilder: (BuildContext context, int index) {
                return Scaffold(
                    body: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              ProductModel product = ProductModel(
                                name: snapshot.data.docs[index].get('name'),
                                stock: snapshot.data.docs[index].get('price'),
                                urlPhotos:
                                    snapshot.data.docs[index].get('urlPhotos'),
                                price: snapshot.data.docs[index].get('price'),
                                denda: snapshot.data.docs[index].get('denda'),
                                description: snapshot.data.docs[index]
                                    .get('description'),
                              );

                              Navigator.pushNamed(
                                  context, DetailClothesScreen.routeId,
                                  arguments: product);
                            },
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                    child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: CachedNetworkImage(
                                            // height: 80,
                                            width: 200,
                                            fit: BoxFit.cover,
                                            imageUrl: snapshot.data.docs[index].get('urlPhotos'),
                                            errorWidget: (context, url, error) => Icon(Icons.hide_image),
                                           ),
                                  
                                )),
                                const SizedBox(height: 8.0),
                                Text(
                                  snapshot.data.docs[index].get('name'),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 12.0),
                                ),
                                Text(
                                  "Rp. " +
                                      snapshot.data.docs[index]
                                          .get('price')
                                          .toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        )));
              },
              itemCount: snapshot.data.docs.length,
            );
          }),
    );
  }
}
