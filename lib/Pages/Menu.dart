import 'package:flutter/material.dart';
import 'package:jarllan/Services/MenuCard.dart';
import 'package:jarllan/Services/product.dart';



class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}
List products = <Product>[
Product(productName:"Pares", price: 109.99),
Product(productName:"Spatetti", price: 79.99),
Product(productName:"Chimken", price: 99.99),
Product(productName:"Float", price: 50.99),
Product(productName:"Sundae", price: 39.99),
];



class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.lime,
        title: Text(
          'Menu',
          style: TextStyle(
            letterSpacing: 3.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
  padding: EdgeInsets.all(7.0),
  child:Column(
    children: products.map((product)=> Menucard(product: product)).toList(),
) ,
),
    );
  }
}
