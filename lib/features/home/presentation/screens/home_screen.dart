import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/home/data/repo/home_repo.dart';
import 'package:store_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:store_app/features/home/presentation/cubit/home_states.dart';
import 'package:store_app/core/routing/routes.dart';
import 'package:store_app/features/home/presentation/screens/widgets/product_item.dart';
import 'package:store_app/features/my_cart/presentation/cubit/cart_cubit.dart';
import 'package:store_app/features/my_cart/presentation/cubit/cart_states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeRepo())..getAllProducts(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: Text(
            "Store",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Navigator.pushNamed(context, Routes.myCartScreen);
              },
            ),
            IconButton(
              icon: Icon(Icons.person_outline),
              onPressed: () {
                Navigator.pushNamed(context, Routes.profileScreen);
              },
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeStates>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is HomeError) {
              return Center(child: Text(state.message));
            }
            if (state is HomeSuccess) {
              return BlocBuilder<CartCubit, CartStates>(
                builder: (context, cartState) {
                  final cartItems = cartState is CartUpdated
                      ? cartState.items
                      : [];
                  return GridView.builder(
                    padding: EdgeInsets.all(14),
                    itemCount: state.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      mainAxisExtent: 260,
                    ),
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      final isInCart = cartItems.any((p) => p.id == product.id);
                      return ProductItem(
                        product: product,
                        isInCart: isInCart,
                        onAddToCart: () {
                          context.read<CartCubit>().addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${product.title} added to cart"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
