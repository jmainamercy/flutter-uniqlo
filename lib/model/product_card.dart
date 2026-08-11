import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniqlo/model/cart.dart';
import 'package:uniqlo/model/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(product.imageUrl, width: 120, height: 120),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name),
                  SizedBox(height: 8),
                  Text(product.description),
                  SizedBox(height: 8),

                  Row(
                    children: [
                      Text("KES ${product.price}"),
                      Spacer(flex: 1),
                      IconButton(
                        onPressed: () {
                          Provider.of<CartModel>(
                            context,
                            listen: false,
                          ).addItem(product);
                        },
                        icon: Icon(
                          Icons.shopping_cart_checkout_outlined,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
