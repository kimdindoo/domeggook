import 'package:domeggook/common/layout/default_layout.dart';
import 'package:domeggook/config/router/route_names.dart';
import 'package:domeggook/product/component/recent_search.dart';
import 'package:domeggook/product/component/recent_viewd_product.dart';
import 'package:domeggook/product/provider/recent_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductSearchScreen extends ConsumerStatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  ConsumerState<ProductSearchScreen> createState() =>
      _ProductSearchScreenState();
}

class _ProductSearchScreenState extends ConsumerState<ProductSearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '상품 검색',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Container(
              height: 40,
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

                        ref
                            .read(recentSearcheProvider.notifier)
                            .addSearch(value); // 최근 검색어에 추가

                        // 검색 결과 페이지로 이동
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
            const SizedBox(height: 16),
            RecentSearch(),
            const SizedBox(height: 16),
            RecentViewdProduct(),
          ],
        ),
      ),
    );
  }
}
