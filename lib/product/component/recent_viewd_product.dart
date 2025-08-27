import 'package:domeggook/common/utils/number_utils.dart';
import 'package:domeggook/product/provider/recent_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentViewdProduct extends ConsumerWidget {
  const RecentViewdProduct({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentProducts = ref.watch(recentProductsProvider);

    if (recentProducts.isEmpty) {
      return const Center(child: Text("최근 본 상품이 없습니다."));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '최근 본 상품',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 500,
            child: ListView.builder(
              // padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal, // 가로 스크롤
              itemCount: recentProducts.length,
              itemBuilder: (context, index) {
                final product = recentProducts[index];

                return Padding(
                  padding: const EdgeInsets.only(right: 16),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
