import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/home/data/models/product_model.dart';
import 'package:store_app/features/my_cart/data/repo/cart_repo.dart';
import 'package:store_app/features/my_cart/presentation/cubit/cart_states.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit(this._cartRepo) : super(CartInitial());

  final CartRepo _cartRepo;

  void loadCart() {
    _emitUpdated();
  }

  void addToCart(ProductModel product) {
    _cartRepo.addItem(product);
    _emitUpdated();
  }

  void removeFromCart(int index) {
    _cartRepo.removeItem(index);
    _emitUpdated();
  }

  void clearCart() {
    _cartRepo.clear();
    _emitUpdated();
  }

  void _emitUpdated() {
    emit(CartUpdated(
      items: _cartRepo.items,
      totalPrice: _cartRepo.totalPrice,
    ));
  }
}
