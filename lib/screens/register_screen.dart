import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:renthub_app/data/model/cust_model.dart';
import 'package:renthub_app/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  final _tlp = TextEditingController();
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  bool _hiddenText = true;
  bool _isLoading = false;

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
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColor,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(),
                const SizedBox(height: 16.0),
                Text(
                  'Daftar akun baru',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 8.0),
                Text('Buat sebuah akun baru',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(height: 30.0),
                // Center(
                //   child:
                //       CircleAvatar(
                //         backgroundColor: Theme.of(context).primaryColor,
                //         radius: 40,
                //         child: ClipOval(
                //           child: imageFile == null
                //               ? Center(child: IconButton(
                //                 onPressed: (){pickFromGallery();},
                //                 icon: Icon(Icons.add_a_photo,size: 25),
                                
                //                 color: Colors.white,))
                //               : Image.file(
                //                   imageFile!,
                //                   height: 150,
                //                   width: 150,
                //                   fit: BoxFit.cover,
                //                 ),
                //         ),
                //       ),
                      // Positioned(
                      //     bottom: 1,
                      //     right: 1,
                      //     child: Container(
                      //       height: 40,
                      //       width: 40,
                      //       child: IconButton(
                      //         onPressed: () {
                      //           showModalBottomSheet(
                      //             isScrollControlled: true,
                      //             context: context,
                      //             builder: (BuildContext c) {
                      //               return Padding(
                      //                 padding: const EdgeInsets.all(20.0),
                      //                 child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.center,
                      //                   children: [
                      //                     Column(
                      //                       mainAxisSize: MainAxisSize.min,
                      //                       children: [
                      //                         ClipRRect(
                      //                             borderRadius:
                      //                                 BorderRadius.circular(
                      //                                     30.0),
                      //                             child: Container(
                      //                               height: 60,
                      //                               width: 60,
                      //                               color: Theme.of(context)
                      //                                   .primaryColor,
                      //                               child: IconButton(
                      //                                 onPressed: () {
                      //                                   pickFromGallery();
                      //                                 },
                      //                                 icon: Icon(Icons.camera),
                      //                                 color: Colors.white,
                      //                               ),
                      //                             )),
                      //                         const SizedBox(height: 10),
                      //                         const Text("Galeri")
                      //                       ],
                      //                     ),
                      //                   ],
                      //                 ),
                      //               );
                      //             },
                      //           );
                      //         },
                      //         icon: Icon(Icons.add),
                      //         color: Colors.black,
                      //       ),
                      //       decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           border: Border.all(color: Colors.black),
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(20))),
                      //     ))
                    
                
                const SizedBox(height: 30.0),
                TextField(
                  controller: _name,
                  autofocus: true,
                  
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 2, color: Colors.black),
                    ),
                    
                    focusColor: Color(0xFFf2f2f2),
                    filled: true,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person, color: Colors.black),
                    hintText: 'Nama Lengkap',
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _email,
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 2, color: Colors.black),
                    ),
                    focusColor: Color(0xFFf2f2f2),
                    filled: true,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.alternate_email, color: Colors.black),
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _tlp,
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 2, color: Colors.black),
                    ),
                    focusColor: Color(0xFFf2f2f2),
                    filled: true,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone, color: Colors.black),
                    hintText: 'Nomor Telepon',
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _password,
                  cursorColor: Colors.black,
                  obscureText: _hiddenText,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 2, color: Colors.black),
                    ),
                    focusColor: Color(0xFFf2f2f2),
                    filled: true,
                    border: const OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock, color: Colors.black),
                    suffixIcon: IconButton(
                      icon: Icon(_hiddenText
                          ? Icons.visibility
                          : Icons.visibility_off, color: Colors.black),
                      onPressed: () {
                        setState(() {
                          _hiddenText = !_hiddenText;
                        });
                      },
                    ),
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(height: 8.0),
                SizedBox(height: 20.0),
                MaterialButton(
                  child: Text('Register'),
                  color: Theme.of(context).primaryColor,
                  textTheme: ButtonTextTheme.primary,
                  height: 45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      final name = _name.text;
                      final email = _email.text;
                      final tlp = _tlp.text;
                      final password = _password.text;

                      UserCredential result =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);

                      CustModel _user = CustModel(
                        name: name,
                        email: email,
                        userid: result.user!.uid,
                        role: 'customer',
                        tlp: tlp,
                        urlPhotos: urlImage,
                      );

                      await _firebaseFirestore
                          .collection("Users")
                          .doc(_user.userid)
                          .set({
                        'name': _user.name!.trim(),
                        'email': _user.email!.trim(),
                        'role': _user.role,
                        'tlp': _user.tlp!.trim(),
                        'urlPhotos': _user.urlPhotos,
                      });

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Regristrasi berhasil!',
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            actions: <Widget>[
                              MaterialButton(
                                child: Text('Login'),
                                color: Theme.of(context).primaryColor,
                                textTheme: ButtonTextTheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                onPressed: () {
                                  Navigator.pop(
                                      context,
                                      );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Register gagal!'),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            actions: <Widget>[
                              MaterialButton(
                                child: Text('Tutup'),
                                color: Theme.of(context).primaryColor,
                                textTheme: ButtonTextTheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Sudah punya akun? '),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(
                              context,
                              );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              
                              fontWeight: FontWeight.bold,
                              ),
                        ))
                  ],
                ),
                SizedBox(height: 50.0),
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
