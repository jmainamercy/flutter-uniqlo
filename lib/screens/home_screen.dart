import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniqlo/model/cart.dart';
import 'package:uniqlo/model/product.dart';
import 'package:uniqlo/model/product_card.dart';
import 'package:uniqlo/model/cart_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _tabTitle = "Home";
  final List<Widget> _tabs = [
    _HomeTab(),
    _CartTab(),
    _OrdersTab(),
    _ProfileTab(),
  ];
  final List<String> _titles = ["Home", "Cart", "Orders", "Profile"];

  void _onTabClicked(int index) {
    setState(() {
      _selectedIndex = index;
      _tabTitle = _titles[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(_tabTitle),
            Row(
              children: [
                Spacer(flex: 1),
                Consumer<CartModel>(
                  builder: (context, cart, child) {
                    return Text('KES ${cart.getItemTotal()}');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: _tabs),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onTabClicked,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Cart",
            activeIcon: Icon(Icons.shopping_cart),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Orders",
            activeIcon: Icon(Icons.shopping_bag),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "Profile",
            activeIcon: Icon(Icons.person_2),
          ),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      itemCount: dummyProducts.length,
      itemBuilder: (context, index) {
        final currentProduct = dummyProducts[index];
        return ProductCard(product: currentProduct);
      },
    );
  }
}

class _CartTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        if (cart.items.isEmpty) {
          return Center(child: Text("Your Cart is empty"));
        }
        return ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (context, index) {
            final item = cart.items[index];
            return CartCard(
              cartitem: item,
              increment: () {
                cart.increment(item.product);
              },
              decrement: () {
                cart.decrement(item.product);
              },
            );
          },
        );
      },
    );
  }
}

class _OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Orders"));
  }
}

class _ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Profile"));
  }
}
