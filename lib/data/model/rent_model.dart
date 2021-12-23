import 'package:cloud_firestore/cloud_firestore.dart';

class RentModel {
  String product;
  int price;
  int penalty;
  String dateRent;
  String dateReturn;
  int day;
  int total;
  String status;
  String? customer;
  String? emailCust;
  String? urlPhotos;

  RentModel({
    required this.product,
    required this.price,
    required this.penalty,
    required this.dateRent,
    required this.dateReturn,
    required this.day,
    required this.total,
    required this.status,
    required this.customer,
    required this.emailCust,
    required this.urlPhotos,
  });
}
