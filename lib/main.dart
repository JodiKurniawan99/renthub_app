import 'package:flutter/material.dart';
import 'package:renthub_app/screens/home_rent_screen.dart';
import 'package:renthub_app/screens/home_cust_screen.dart';
import 'package:renthub_app/screens/list_clothes_screen.dart';
import 'package:renthub_app/screens/list_cust_order.dart';
import 'package:renthub_app/screens/list_order_screen.dart';
import 'package:renthub_app/screens/list_rent_screen.dart';
import 'package:renthub_app/screens/list_return_screen.dart';
import 'package:renthub_app/screens/login_screen.dart';
import 'package:renthub_app/screens/splash_screen.dart';
import 'package:renthub_app/screens/update_product_screen.dart';
import 'package:renthub_app/screens/detail_clothes_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Renthub App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      initialRoute: SplashScreen.routeId,
      routes: {
        SplashScreen.routeId: (context) => SplashScreen(),
        LoginScreen.routeId: (context) => LoginScreen(),
        HomeRentScreen.routeId: (context) => HomeRentScreen(),
        HomeCustcreen.routeId: (context) => HomeCustcreen(),
        ListClothesScreen.routeId: (context) => ListClothesScreen(),
        ListRentScreen.routeId: (context) => ListRentScreen(),
        UpdateProductScreen.routeId: (context) => UpdateProductScreen(),
        ListOrderScreen.routeId: (context) => ListOrderScreen(),
        ListCustOrder.routeId: (context) => ListCustOrder(),
        ListReturnScreen.routeId: (context) => ListReturnScreen(),
        DetailClothesScreen.routeId: (context) => DetailClothesScreen(),
      },
    );
  }
}
