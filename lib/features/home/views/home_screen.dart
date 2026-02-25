import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/home/cubit/prodcut_cubit.dart';
import 'package:store_app/features/home/cubit/product_states.dart';
import 'package:store_app/features/home/widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProdcutCubit()..getAllProducts(),
      child: Scaffold(
        body: BlocConsumer<ProdcutCubit, ProductStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  state is ProductSuccessState
                      ? Expanded(
                          child: GridView.builder(
                            itemCount: state.products.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 5,
                                  mainAxisExtent: 240,
                                ),
                            itemBuilder: (context, index) =>
                                ProductItem(prodcut: state.products[index]),
                          ),
                        )
                      : state is ProductLoadingState
                      ? Center(child: CircularProgressIndicator())
                      : state is ProductFailedState
                      ? Center(child: Text(state.errmsg))
                      : SizedBox.shrink(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
