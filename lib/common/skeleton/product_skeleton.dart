import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: List.generate(7, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Row(
              children: [
                // 이미지 자리
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 16),
                // 텍스트 자리
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 상품 제목 자리
                      Container(
                        width: double.infinity,
                        height: 20,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8),
                      // 가격 자리
                      Container(width: 80, height: 20, color: Colors.grey[300]),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
