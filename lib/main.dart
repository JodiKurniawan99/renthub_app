import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:renthub_app/commons/styles.dart';
import 'package:renthub_app/data/model/product_model.dart';
import 'package:renthub_app/screens/add_product_screen.dart';
import 'package:renthub_app/screens/home_first_screen.dart';
import 'package:renthub_app/screens/home_rent_screen.dart';
import 'package:renthub_app/screens/home_cust_screen.dart';
import 'package:renthub_app/screens/list_clothes_screen.dart';
import 'package:renthub_app/screens/list_cust_order.dart';
import 'package:renthub_app/screens/list_order_screen.dart';
import 'package:renthub_app/screens/list_penalties_screen.dart';
import 'package:renthub_app/screens/list_rent_screen.dart';
import 'package:renthub_app/screens/login_screen.dart';
import 'package:renthub_app/screens/splash_screen.dart';
import 'package:renthub_app/screens/update_product_screen.dart';
import 'package:renthub_app/screens/detail_clothes_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        textTheme: myTextTheme,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
        
      ),
      initialRoute: 
      
       FirebaseAuth.instance.currentUser == null? SplashScreen.routeId :
       FirebaseAuth.instance.currentUser?.email == 'renthub@gmail.com'?
         HomeRentScreen.routeId: HomeCustcreen.routeId,
      routes: {
        SplashScreen.routeId: (context) => const SplashScreen(),
        LoginScreen.routeId: (context) => LoginScreen(),
        HomeRentScreen.routeId: (context) => HomeRentScreen(),
        HomeCustcreen.routeId: (context) => HomeCustcreen(),
        ListClothesScreen.routeId: (context) => ListClothesScreen(),
        ListRentScreen.routeId: (context) => ListRentScreen(),
        UpdateProductScreen.routeId: (context) => UpdateProductScreen(
            ModalRoute.of(context)?.settings.arguments as dynamic),
        ListOrderScreen.routeId: (context) => ListOrderScreen(),
        ListCustOrder.routeId: (context) => ListCustOrder(),
        DetailClothesScreen.routeId: (context) => DetailClothesScreen(
              product:
                  ModalRoute.of(context)?.settings.arguments as ProductModel,
            ),
        AddProductScreen.routeId: (context) => const AddProductScreen(),
        HomeFirstScreen.routeId: (context) => HomeFirstScreen(),
        ListPenaltiesScreen.routeId: (context) => ListPenaltiesScreen()
      },
    );
  }
}
