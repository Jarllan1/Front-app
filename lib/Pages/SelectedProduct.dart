import 'package:flutter/material.dart';
import 'package:jarllan/Services/product.dart';

class Selectedproduct extends StatefulWidget {
  final Product product;
  const Selectedproduct({super.key, required this.product});

  @override
  State<Selectedproduct> createState() => _SelectedproductState(product: product);
}

class _SelectedproductState extends State<Selectedproduct> {
 final Product product;
 late double totalAmount;
 int numberOfOrders = 1;
 _SelectedproductState({required this.product});

  @override
  void initState(){
   super.initState();
   totalAmount = product.price;
  }
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        '${totalAmount.toStringAsFixed(2)}',
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      Row(
        children: [
          IconButton(
              onPressed: (){
                setState(() {
                  if(numberOfOrders > 1){
                    numberOfOrders -= 1;
                    totalAmount = product.price * numberOfOrders;
                  }
                });
              },
              icon: Icon(Icons.remove)
          ),
          Text(
            numberOfOrders.toString(),
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          IconButton(
              onPressed:(){
                setState(() {
                  numberOfOrders += 1;
                  totalAmount = product.price * numberOfOrders;
                });
              },
               icon: Icon(Icons.add)
    ),
        ],
      ),
    ],
    ),
    ],

    ),
    );
}
}
