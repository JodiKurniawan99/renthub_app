import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:renthub_app/data/model/product_model.dart';
import 'package:renthub_app/screens/list_rent_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddProductScreen extends StatefulWidget{
  const AddProductScreen({Key? key}) : super(key:key);
  static const routeId = '/add_product_screen';

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen>{

  TextEditingController _name = new TextEditingController();
  TextEditingController _stock = new TextEditingController();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController _price = new TextEditingController();

  File? imageFile;
  final imagePick = ImagePicker();
  String? urlImage;

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
        appBar: AppBar(
          title: Text("Tambahkan Produk"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 50),
                      Container(
                        width: 350,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.lightBlueAccent)
                        ),
                        child: imageFile == null
                        ? const Center(
                          child: Text('No image selected'))
                        :Image.file(imageFile!)

                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                          minWidth: 500,
                          child: Text(
                            'Tambahkan foto produk',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          color: Theme.of(context).primaryColor,
                          textTheme: ButtonTextTheme.primary,
                          height: 50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context, 
                              builder: (BuildContext c){
                                return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(30.0),
                                          child: Container(
                                          height: 60,
                                          width: 60,
                                          color: Colors.lightBlueAccent,
                                          child:  IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.camera_alt_rounded),
                                          ),
                                          )
                                        ),
                                        SizedBox(height: 10,),
                                        Text("Take photo")
                                      ]
                                    ),
                                    SizedBox(width: 100,),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                          borderRadius:BorderRadius.circular(30.0),
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            color: Colors.lightBlueAccent,
                                            child: IconButton(
                                               onPressed: () {pickFromGallery();},
                                               icon: Icon(Icons.camera),
                                            ),
                                          )
                                        ),
                                        SizedBox(height: 10,),
                                        Text("Pick photo")
                                    ]),            
                               ],
                               ),
                              );
                              }
                            );
                            
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Nama produk",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Stok produk",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _stock,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Harga produk",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _price,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      
                    ],
                  ),
                  SizedBox(height: 30),
                  MaterialButton(
                      minWidth: 500,
                      child: Text(
                        'Tambahkan produk',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      color: Theme.of(context).primaryColor,
                      textTheme: ButtonTextTheme.primary,
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      onPressed: () async {
                        ProductModel _product = ProductModel(
                          name: _name.text, 
                          stock: int.parse(_stock.text),
                          urlPhotos: urlImage,
                          price: int.parse(_price.text)
                        );
                        
                        await _firebaseFirestore
                          .collection("Products")
                          .add({
                            'name': _product.name.trim(),
                            'stock': _product.stock,
                            'urlPhotos': _product.urlPhotos,
                            'price': _product.price
                          });   
                       Navigator.pop(context);
                      }),
                ])));
  }

  Future pickFromGallery() async {
    final selectedImage = await imagePick.pickImage(source: ImageSource.gallery);
    setState(() {
      if(selectedImage != null){
        imageFile = File(selectedImage.path);
        uploadToStorage();
      }
      else{
        ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          content: Text("Tidak ada file terpilih"))
        );
      }
    });
  } 

  Future uploadToStorage() async{
    Reference refer = FirebaseStorage.instance.ref()
    .child("photos")
    .child("photos_"+ DateTime.now().millisecondsSinceEpoch.toString());
    await refer.putFile(imageFile!);
    urlImage = await refer.getDownloadURL();
  }
}
