import 'package:domeggook/common/layout/defalut_layout.dart';
import 'package:domeggook/common/utils/number_utils.dart';
import 'package:domeggook/product/model/product_model.dart';
import 'package:domeggook/product/repository/product_repository.dart';
import 'package:flutter/material.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Future<ProductModel>? _futureProducts;

  void _search(String query) {
    if (query.isEmpty) return;
    setState(() {
      _futureProducts = getProductByKeyword(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '상품 검색',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.search,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '검색어를 입력하세요',
                        isDense: true,
                      ),
                      onSubmitted: _search,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _search(_controller.text),
                    child: const Icon(Icons.search, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _futureProducts == null
                ? const Center(child: Text('검색어를 입력하세요'))
                : FutureBuilder<ProductModel>(
                    future: _futureProducts,
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
        ],
      ),
    );
  }
}
