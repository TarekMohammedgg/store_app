import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/home/data/repo/home_repo.dart';
import 'package:store_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:store_app/features/home/presentation/cubit/home_states.dart';
import 'package:store_app/core/routing/routes.dart';
import 'package:store_app/features/home/presentation/screens/widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeRepo())..getAllProducts(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Store"),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
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
              return GridView.builder(
                padding: EdgeInsets.all(10),
                itemCount: state.products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 240,
                ),
                itemBuilder: (context, index) =>
                    ProductItem(product: state.products[index]),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
