import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:myapp/ui/cart/cart_manager.dart';
import 'package:myapp/ui/cart/cart_screen.dart';
import 'package:myapp/ui/products/products_manager.dart';
import 'package:myapp/ui/products/top_right_badge.dart';
import 'products_grid.dart';
import '../shared/app_drawer.dart';
import '../cart/cart_manager.dart';
import 'top_right_badge.dart';
import 'package:provider/provider.dart';

enum FilerOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;

  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
  }

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
      body: FutureBuilder(
          future: _fetchProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ValueListenableBuilder<bool>(
                  valueListenable: _showOnlyFavorites,
                  builder: (context, onlyFavorites, child) {
                    return ProductsGrid(onlyFavorites);
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(
      builder: (ctx, cartManager, child) {
        return TopRightBadge(
          data: cartManager.productCount,
          child: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.of(ctx).pushNamed(CartScreen.routeName);
            },
          ),
        );
      },
    );
  }

  // Widget buildProductFilterMenu() {
  //   return PopupMenuButton(
  //     onSelected: (FilerOptions selectedValue) {
  //       if (selectedValue == FilerOptions.favorites) {
  //         _showOnlyFavorites.value = true;
  //       } else {
  //         _showOnlyFavorites.value = false;
  //       }
  //     },
  //   );
  // }

  Widget buildProductFilterMenu() {
    return PopupMenuButton(
        onSelected: (FilerOptions selectedValue) {
          setState(() {
            if (selectedValue == FilerOptions.favorites) {
              _showOnlyFavorites.value = true;
            } else {
              _showOnlyFavorites.value = false;
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
