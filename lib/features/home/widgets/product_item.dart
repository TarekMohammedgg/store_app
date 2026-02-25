import 'package:flutter/material.dart';
import 'package:store_app/features/home/model/product_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.prodcut});
  final ProductModel prodcut;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      clipBehavior: Clip.antiAlias,

      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 3 , color: Colors.black54, offset: Offset(0, 2) , spreadRadius: 0.5) ],
        color: Colors.purple.shade400,

        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Image.network(
            height: 100,
            width: 200,
            fit: BoxFit.contain,
            prodcut.thumbnail,
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prodcut.title,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  maxLines: 2,
                  prodcut.description,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black45,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '\$'
                  "${prodcut.price}",
                  style: TextStyle(color: Colors.blue.shade800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
