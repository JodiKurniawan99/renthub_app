import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:renthub_app/data/model/product_model.dart';
import 'package:renthub_app/screens/list_rent_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  static const routeId = '/add_product_screen';

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _stock = TextEditingController();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final TextEditingController _price = TextEditingController();
  final TextEditingController _denda = TextEditingController();
  final TextEditingController _description = TextEditingController();

  File? imageFile;
  final imagePick = ImagePicker();
  String? urlImage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
              )),
          title: const Text("Tambah Produk"),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all()),
                          child: imageFile == null
                              ? const Center(child: Text('No image selected.'))
                              : Image.file(imageFile!)),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: MaterialButton(
                        minWidth: 50,
                        child:
                            const Icon(Icons.add_a_photo, color: Colors.white),
                        color: Theme.of(context).primaryColor,
                        height: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        onPressed: () {
                           pickFromGallery();
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Nama produk",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Stok produk",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _stock,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Harga sewa",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _price,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Denda",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _denda,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Deskripsi produk",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _description,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                MaterialButton(
                  minWidth: 500,
                  child: const Text(
                    'Simpan',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                      price: int.parse(_price.text),
                      denda: int.parse(_denda.text),
                      description: _description.text,
                     
                    );

                    await _firebaseFirestore.collection("Products").add(
                      {
                        'name': _product.name.trim(),
                        'stock': _product.stock,
                        'urlPhotos': _product.urlPhotos,
                        'price': _product.price,
                        'denda': _product.denda,
                        'description': _product.description
                      },
                    );
                    Navigator.pop(context);     
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickFromGallery() async {
    final selectedImage =
        await imagePick.pickImage(source: ImageSource.gallery);
    setState(() {
      if (selectedImage != null) {
        imageFile = File(selectedImage.path);
        uploadToStorage();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Tidak ada file terpilih")));
      }
    });
  }

  Future uploadToStorage() async {
    Reference refer = FirebaseStorage.instance
        .ref()
        .child("photos")
        .child("photos_" + DateTime.now().millisecondsSinceEpoch.toString());
    await refer.putFile(imageFile!);
    urlImage = await refer.getDownloadURL();
  }
}
