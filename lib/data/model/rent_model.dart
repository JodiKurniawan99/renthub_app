import 'package:cloud_firestore/cloud_firestore.dart';

class RentModel {
  String product;
  int price;
  int denda;
  Timestamp dateRent;
  Timestamp dateReturn;
  int day;
  int total;
  String status;
  //String? customer;
  //String? emailCust;

  RentModel({
    required this.product,
    required this.price,
    required this.denda,
    required this.dateRent,
    required this.dateReturn,
    required this.day,
    required this.total,
    required this.status,
    //required this.customer,
    //required this.emailCust
  });
}
