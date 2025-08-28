import 'package:domeggook/common/utils/number_utils.dart';
import 'package:domeggook/product/provider/recent_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/router/route_names.dart';

class RecentViewdProduct extends ConsumerWidget {
  const RecentViewdProduct({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentProducts = ref.watch(recentProductsProvider);

    if (recentProducts.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '최근 본 상품',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('최근 본 상품이 없습니다.', style: const TextStyle(fontSize: 12)),
        ],
      );
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '최근 검색어',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // 가로 스크롤
              itemCount: recentProducts.length,
              itemBuilder: (context, index) {
                final product = recentProducts[index];

                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () {
                      // 상품 상세 페이지로 이동
                      GoRouter.of(context).pushNamed(
                        RouteNames.productDetail,
                        pathParameters: {'productNo': product.no},
                        queryParameters: {'code': product.no},
                      );
                    },
                    child: SizedBox(
                      width: 140, // 카드 크기
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 이미지
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              product.thumbnailUrl,
                              width: 140,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${NumberUtils.formatPrice(int.parse(product.price))}원',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '최소 ${product.minNumber}개',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
