import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:renthub_app/data/model/cust_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:renthub_app/data/model/product_model.dart';
import 'package:renthub_app/data/model/rent_model.dart';
import 'package:renthub_app/screens/list_clothes_screen.dart';

class DetailClothesScreen extends StatefulWidget {
  static const String routeId = 'detail_clothes_screen';

  final ProductModel product;
  const DetailClothesScreen({required this.product});
  @override
  _DetailClothesScreen createState() => _DetailClothesScreen();
}

class _DetailClothesScreen extends State<DetailClothesScreen> {
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

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final _price = TextEditingController();
  final _denda = TextEditingController();
  final _dateRent = TextEditingController();
  final _dateReturn = TextEditingController();

  String date = "";
  DateTime selectedDate = DateTime.now();
  String daysBefore = '';
  String daysAfter = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
        body: SingleChildScrollView(
          
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Stack(
              children: <Widget>[
                ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36.0),
                    bottomRight: Radius.circular(36.0)),
                child: Image.network(
                  widget.product.urlPhotos!,
                  height: 400,
                  width: 400,
                  fit: BoxFit.cover,
                ),
              ),
            
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left:10) ,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(32.0),
                    child: Material(
                      color: Colors.white,
                      child:  IconButton(
                          onPressed: () {Navigator.pop(context);},
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 20,
                            color: Colors.black,
                          )
                      ),                      
                    )
                  ),
              )
            ),]),

            
                Padding(
                      padding: EdgeInsets.only(top: 16.0,left: 16.0),
                      child: 
                         Text(
                          widget.product.name,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      
                    ),
             SizedBox(
                height: 15,
              ),
   
                      Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0),
                child: Text(
                  "Harga sewa",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
                     Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0),
                child: Text(
                  "${widget.product.price.toString()} /hari",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
                    Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0),
                child: Text(
                  "Denda",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0),
                child: Text(
                  "${widget.product.denda.toString()} /hari",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0),
                child: Text(
                  "Deskripsi",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0),
                child: Text(
                  "${widget.product.description}",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              SizedBox(height: 10,),
              Divider(color: Colors.grey,),
                   Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0),
                child: Text(
                  "Tanggal sewa",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                      child: TextField(
                        controller: _dateRent,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () {
                              _selectDateRent(context);
                            },
                          ),
                          hintText: 'Pilih tanggal',
                        ),
                      ),
                    ),
                    Padding(
                padding: EdgeInsets.only(top: 8.0, left: 16.0),
                child: Text(
                  "Tanggal kembali",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: TextField(
                        controller: _dateReturn,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () {
                              _selectDateReturn(context);
                            },
                          ),
                          hintText: 'Pilih tanggal',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 24.0),
                      child: SizedBox(
                        height: 40,
                        child: MaterialButton(
                          child: const Text('Sewa'),
                          color: Theme.of(context).primaryColor,
                          textTheme: ButtonTextTheme.primary,
                          height: 40,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          onPressed: () async {
                             final dayCounter = DateTime.parse(daysAfter)
                                .difference(DateTime.parse(daysBefore)).inDays;
                             final cost = (dayCounter * widget.product.price);

                            RentModel _rent = RentModel(
                              product: widget.product.name,
                              price: widget.product.price,
                              penalty: widget.product.denda,
                              dateRent: daysBefore,
                              dateReturn: daysAfter,
                              day: dayCounter,
                              total: cost,
                              status: 'confirmation',
                              customer: _user.name,
                              emailCust: _user.email,
                              urlPhotos: widget.product.urlPhotos,
                              
                            );

                            await _firebaseFirestore.collection("Rent").add(
                              {
                                'product': _rent.product,
                                'price': _rent.price,
                                'penalty': _rent.penalty,
                                'dateRent': _rent.dateRent,
                                'dateReturn': _rent.dateReturn,
                                'day': _rent.day,
                                'cost': _rent.total,
                                'status': _rent.status,
                                'customerName': _rent.customer,
                                'customerEmail': _rent.emailCust,
                                'urlPhotos': _rent.urlPhotos,
                                
                              },
                            );

                            Navigator.pushReplacementNamed(
                                context, ListClothesScreen.routeId);
                          },
                        ),
                      ),
                    )
                  ]),
            ),
          
        ));
  }

  _selectDateRent(BuildContext context) async {
    DateFormat formatter = DateFormat('dd MMMM yyyy');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 7)));
        print(picked.toString());
    if (picked != null && picked != selectedDate)
      setState(() {    
        daysBefore = DateFormat('yyyy-MM-dd').format(picked);    
        selectedDate = picked;
        _dateRent.text =  formatter.format(picked);
      });
  }

  _selectDateReturn(BuildContext context) async {
    DateFormat formatter = DateFormat('dd MMMM yyyy');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 7)));
    if (picked != null && picked != selectedDate)
      setState(() {
        daysAfter =  DateFormat('yyyy-MM-dd').format(picked);
        selectedDate = picked;
        _dateReturn.text = formatter.format(picked);
      });
  }
}
