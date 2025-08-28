import 'package:domeggook/common/layout/default_layout.dart';
import 'package:domeggook/product/component/product_list.dart';
import 'package:domeggook/product/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryProductScreen extends ConsumerWidget {
  const CategoryProductScreen({
    super.key,
    required this.categoryName,
    required this.categoryCode,
  });

  final String categoryName;
  final String categoryCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: categoryName,
      child: ProductListWidget(
        fetchPage: (pageKey) async {
          // 카테고리별 제품 요청
          return ref
              .read(productRepositoryProvider)
              .getProductByCategory(pageKey, categoryCode);
        },
      ),
    );
  }
}
