import 'package:domeggook/common/layout/defalut_layout.dart';
import 'package:domeggook/config/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  final TextEditingController _controller = TextEditingController();

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
                      onSubmitted: (String value) {
                        if (value.isEmpty) return;

                        GoRouter.of(context).pushNamed(
                          RouteNames.keywordProduct,
                          queryParameters: {'keyword': value},
                        );
                      },
                    ),
                  ),
                  const Icon(Icons.search, color: Colors.grey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
