import 'package:domeggook/common/layout/defalut_layout.dart';
import 'package:domeggook/common/utils/number_utils.dart';
import 'package:domeggook/product/model/product_model.dart';
import 'package:domeggook/product/repository/product_repository.dart';
import 'package:flutter/material.dart';

class KeywordProductScreen extends StatelessWidget {
  const KeywordProductScreen({super.key, required this.keyword});

  final String keyword;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: keyword,
      child: SingleChildScrollView(
        child: FutureBuilder<ProductModel>(
          future: getProductByKeyword(keyword),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData ||
                snapshot.data!.domeggook.list.item.isEmpty) {
              return const Center(child: Text('No products found'));
            }

            final products = snapshot.data!.domeggook.list.item;

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: Image.network(
                    product.thumb,
                    width: 100,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.title),
                  subtitle: Text(
                    '${NumberUtils.formatPrice(int.parse(product.price))}원',
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
