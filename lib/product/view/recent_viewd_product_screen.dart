import 'package:domeggook/common/layout/default_layout.dart';
import 'package:domeggook/common/utils/number_utils.dart';
import 'package:domeggook/product/provider/recent_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/router/route_names.dart';

class RecentViewedProductScreen extends ConsumerWidget {
  const RecentViewedProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentProducts = ref.watch(recentProductsProvider);

    return DefaultLayout(
      title: '최근 본 상품',
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recentProducts.length,
        itemBuilder: (context, index) {
          final product = recentProducts[index];

          return GestureDetector(
            onTap: () {
              // 상품 상세 페이지로 이동
              GoRouter.of(context).pushNamed(
                RouteNames.productDetail,
                pathParameters: {'productNo': product.no},
                queryParameters: {'code': product.no},
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 이미지 더 크게
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.thumbnailUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              '${NumberUtils.formatPrice(int.parse(product.price))}원',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),

                            Text(
                              '최소 ${product.minNumber}개',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: () {
                            ref
                                .read(recentProductsProvider.notifier)
                                .removeProduct(product.no);
                          },
                          style: OutlinedButton.styleFrom(
                            // side: const BorderSide(color: Colors.red),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: const Text(
                            '삭제',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        // 삭제 버튼
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
