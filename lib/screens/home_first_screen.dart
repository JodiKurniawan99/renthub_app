import 'package:flutter/material.dart';
import 'package:renthub_app/screens/list_cust_order.dart';
import 'package:renthub_app/screens/list_order_screen.dart';
import 'package:renthub_app/screens/list_penalties_screen.dart';
class HomeFirstScreen extends StatelessWidget {
  static const routeId = '/home_first_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Beranda")),
        body:  Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, ListOrderScreen.routeId);
                  },
                  child: Center(
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget> [
                        Row(
                      children: <Widget>[
                        Icon(Icons.circle_notifications_rounded),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Pesanan baru"),
                        SizedBox(
                          width: 30,
                        ),
                        
                      ],
                    ),
                    Icon(Icons.navigate_next_rounded)
                    ],
                    )     
                ), 
              ),
              ),
              SizedBox(height:16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ListCustOrder.routeId);
                },
                child: Center(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.dry_cleaning),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Barang yang sedang disewa"),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                    Icon(Icons.navigate_next_rounded)
                  ],
                )),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ListPenaltiesScreen.routeId);
                },
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.warning_amber_rounded),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Barang telat pengembalian"),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                    Icon(Icons.navigate_next_rounded)
                  ],
                )),
              ),
            ),    
          ],
        )
     );
  }
}
