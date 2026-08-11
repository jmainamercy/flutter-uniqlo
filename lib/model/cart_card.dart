import 'package:flutter/material.dart';
import 'package:uniqlo/model/cart_item.dart';

class CartCard extends StatelessWidget {
  final CartItem cartitem;
  final VoidCallback increment;
  final VoidCallback decrement;

  const CartCard({
    super.key,
    required this.cartitem,
    required this.increment,
    required this.decrement,
  });

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
              child: Image.network(
                cartitem.product.imageUrl,
                width: 120,
                height: 120,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartitem.product.name),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text("KES ${cartitem.itemTotal}"),
                      Spacer(flex: 1),
                      Row(
                        children: [
                          IconButton(
                            onPressed: decrement,
                            icon: Icon(Icons.remove),
                          ),
                          Text(cartitem.quantity.toString()),
                          IconButton(
                            onPressed: increment,
                            icon: Icon(Icons.add),
                          ),
                        ],
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
