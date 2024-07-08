import 'package:flutter/material.dart';
import 'package:jarllan/Services/product.dart';

class Selectedproduct extends StatefulWidget {
  final Product product;
  const Selectedproduct({super.key, required this.product});

  @override
  State<Selectedproduct> createState() => _SelectedproductState();
}

class _SelectedproductState extends State<Selectedproduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      appBar: AppBar(
      title: Text(
      'User Profile',
      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
    ),
    backgroundColor: Colors.limeAccent,
    centerTitle: true,
    ),
    body: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
    children: [
      Text (widget.product.productName),
      Text (widget.product.description),
    ],
    ),
    Row(
    children: [
      Text(widget.product.price.toString()),
    ],
    ),
    ],

    ),
    );
}
}
