import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:renthub_app/data/model/product_model.dart';

class DetailClothesScreen extends StatefulWidget {
  static const String routeId = 'detail_clothes_screen';

  final ProductModel product;
  const DetailClothesScreen({required this.product});
  @override
  _DetailClothesScreen createState() => _DetailClothesScreen();
}

class _DetailClothesScreen extends State<DetailClothesScreen> {
  final _price = TextEditingController();
  final _denda = TextEditingController();
  final _dateRent = TextEditingController();
  final _dateReturn = TextEditingController();

  String date = "";
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail Baju"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: 400.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: NetworkImage(
                              widget.product.urlPhotos!,
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          widget.product.name,
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
                      child: Text(
                        'Harga sewa',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: TextField(
                        controller: _price,
                        readOnly: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText:
                                'Rp. ${widget.product.price.toString()} / hari',
                            hintStyle: TextStyle(fontSize: 15.0)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
                      child: Text(
                        'Denda',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: TextField(
                        controller: _denda,
                        readOnly: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText:
                                'Rp. ${widget.product.denda.toString()} / hari',
                            hintStyle: TextStyle(fontSize: 15.0)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
                      child: Text(
                        'Tgl sewa',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
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
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
                      child: Text(
                        'Tgl kembali',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
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
                      padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
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
                            onPressed: () {}),
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }

  _selectDateRent(BuildContext context) async {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 7)));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _dateRent.value = TextEditingValue(text: formatter.format(picked));
      });
  }

  _selectDateReturn(BuildContext context) async {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 7)));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _dateReturn.value = TextEditingValue(text: formatter.format(picked));
      });
  }
}
