import 'package:flutter/material.dart';
import 'package:myapp/ui/cart/cart_screen.dart';
import 'products_grid.dart';
import '../shared/app_drawer.dart';

enum FilerOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: <Widget>[
          buildProductFilterMenu(),
          buildShoppingCartIcon(),
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }

  Widget buildShoppingCartIcon() {
    return IconButton(
        icon: const Icon(
          Icons.shopping_cart,
        ),
        onPressed: (() {
          Navigator.of(context).pushNamed(CartScreen.routeName);
        }));
  }

  Widget buildProductFilterMenu() {
    return PopupMenuButton(
        onSelected: (FilerOptions selectedValue) {
          setState(() {
            if (selectedValue == FilerOptions.favorites) {
              _showOnlyFavorites = true;
            } else {
              _showOnlyFavorites = false;
            }
          });
        },
        icon: const Icon(
          Icons.more_vert,
        ),
        itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: FilerOptions.favorites,
                child: Text("Only favorites"),
              ),
              const PopupMenuItem(
                value: FilerOptions.all,
                child: Text('Show All'),
              )
            ]);
  }
}
