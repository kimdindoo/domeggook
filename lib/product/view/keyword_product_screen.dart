import 'package:domeggook/common/layout/default_layout.dart';
import 'package:domeggook/product/component/product_list.dart';
import 'package:domeggook/product/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeywordProductScreen extends ConsumerWidget {
  const KeywordProductScreen({super.key, required this.keyword});

  final String keyword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: '"$keyword" 검색결과',
      child: ProductList(
        fetchPage: (pageKey) async {
          // 키워드별 제품 요청
          return ref
              .read(productRepositoryProvider)
              .getProductByKeyword(pageKey, keyword);
        },
      ),
    );
  }
}
