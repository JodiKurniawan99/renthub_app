import 'package:flutter/material.dart';

class ListRentCustScreen extends StatelessWidget {
  static const routeId = 'list_rent_cust_screen';

  @override
  Widget build(BuildContext context) {
    final titles = ['Setelan Jas Navy', 'Setelan Jas Navy', 'Setelan Jas Navy'];

    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                "https://images.unsplash.com/photo-1594938328870-9623159c8c99?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80",
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              titles[index],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            subtitle: Text("Return date : 23 Desember 2021"),
            trailing: IconButton(
                icon: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                ),
                onPressed: () {}),
          ),
        );
      },
    );
  }
}
