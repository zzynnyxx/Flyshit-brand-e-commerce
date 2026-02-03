// providers/cart_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_files/models/product.dart';

part 'cart_provider.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  // initial Value
  @override
  Set<Product> build() {
    return const {};
  }

// Methos to update State
// add prodcut to cut
  void addProduct(Product product) {
    if (!state.contains(product)) {
      state = {...state, product};
    }
  }

// remove item from cart
  void removeProduct(Product prodcut) {
    if (state.contains(prodcut)) {
      state = state.where((p) => p.id != prodcut.id).toSet();
    }
  }
}
// totals in the cart
@riverpod
int cartTotal(ref){
final cartProducts = ref.watch(cartProvider);

int total =0;
for(Product product in cartProducts){
total +=product.price;
}
return total;
}