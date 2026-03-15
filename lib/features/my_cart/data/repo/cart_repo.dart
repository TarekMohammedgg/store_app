import 'package:store_app/features/home/data/models/product_model.dart';

class CartRepo {
  static final CartRepo _instance = CartRepo._();
  factory CartRepo() => _instance;
  CartRepo._();

  final List<ProductModel> _items = [];

  List<ProductModel> get items => List.unmodifiable(_items);

  bool containsItem(int productId) {
    return _items.any((item) => item.id == productId);
  }

  void addItem(ProductModel product) {
    _items.add(product);
  }

  void removeItem(int index) {
    _items.removeAt(index);
  }

  void clear() {
    _items.clear();
  }

  double get totalPrice {
    return _items.fold(0, (sum, item) => sum + (double.tryParse(item.price) ?? 0));
  }
}
