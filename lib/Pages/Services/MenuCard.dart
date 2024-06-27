import 'package:flutter/material.dart';
import 'package:jarllan/Pages/Services/product.dart';
import 'product.dart';



class Menucard extends StatelessWidget {
  final Product product;
  Menucard({required this.product});


  @override
  Widget build(BuildContext context) {
    return Card(
    color: Colors.green[900],
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              product.productName,
              style:TextStyle(
                color: Colors.black87, fontWeight: FontWeight.bold,
                fontSize: 20.0,

              ),
            ),
            Text(
              '${product.price}',
              style:TextStyle(
                fontSize: 15.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}