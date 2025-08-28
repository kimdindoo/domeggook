import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

// 상품 상세 로딩 skeleton
class ProductDetailSkeleton extends StatelessWidget {
  const ProductDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 300,
            child: Image.asset(
              'asset/img/logo/domeggook_logo.png',
              fit: BoxFit.cover, // 화면 꽉 채우기
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.broken_image));
              },
            ),
          ),
          // 상품명
          Text(
            '도매꾹 짱',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // 가격
          const Text(
            '0원',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),

          // 최소 구매 수량
          Text('최소구매수량 0개', style: TextStyle(fontSize: 14)),
          const SizedBox(height: 16),

          // 배송 정보
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('배송정보', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Text('3,500원\n7일 이내 출고(평균 출고일 약 0.5일)\n묶음배송 가능 (동일 출고지 상품만 가능)'),
            ],
          ),

          const SizedBox(height: 8),

          // 재고 수량
          Row(
            children: [
              Text('재고수량', style: TextStyle(fontSize: 16)),
              SizedBox(width: 8),
              Text(' 0개'),
            ],
          ),
          const SizedBox(height: 8),

          // 원산지
          Row(
            children: [
              Text('원산지', style: TextStyle(fontSize: 16)),
              SizedBox(width: 8),
              Text('대한민국'),
            ],
          ),
          const SizedBox(height: 8),
          // 공급사 정보
          Row(
            children: [
              const Text('공급사', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Text('도매꾹'),
            ],
          ),
        ],
      ),
    );
  }
}
