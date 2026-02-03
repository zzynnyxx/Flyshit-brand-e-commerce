// screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/providers/cart_provider.dart';
import 'package:riverpod_files/providers/products_provider.dart';
import 'package:riverpod_files/shared/cart_icon.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProducts = ref.watch(cartProvider);
    final allProducts = ref.watch(productsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flyshit brand'),
        actions: const [CartIcon()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: allProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return Container(
                padding: const EdgeInsets.all(10),
                color: Colors.blueGrey.withOpacity(0.05),
                child: SingleChildScrollView(
                  // <--- Add this wrapper
                  child: Column(
                    children: [
                      Image.asset(
                        allProducts[index].image,
                        width: 60,
                        height: 60,
                      ),
                      Text(allProducts[index].title),
                      Text('£ ${allProducts[index].price}'),
                      if (cartProducts.contains(allProducts[index]))
                        TextButton(
                            onPressed: () {
                              ref.read(cartProvider.notifier)
                              .removeProduct(allProducts[index]);
                            }, child: const Text("Remove")),
                      if (!cartProducts.contains(allProducts[index]))
                        TextButton(
                            onPressed: () {
                              ref.read(cartProvider.notifier)
                              .addProduct(allProducts[index]);
                            }, child: Text("Add To Cart")),
                    ],
                  ),
                )
                );
          },
        ),
      ),
    );
  }
}
