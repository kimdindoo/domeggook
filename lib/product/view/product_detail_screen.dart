import 'package:domeggook/common/layout/defalut_layout.dart';
import 'package:domeggook/product/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key, required this.productNo});

  final String productNo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productDetail = ref.watch(productDetailProvider(productNo));
    return DefaultLayout(
      title: '상품 상세',
      child: Center(
        child: Column(
          children: [
            productDetail.when(
              data: (data) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 이미지 추가
                    Image.network(data.domeggook.thumb.large!),
                    const SizedBox(height: 16),
                    Text('${data.domeggook.basis.title}'),
                    // Text('가격: ${formatDomePrice(data.domeggook.price.dome)}'),
                    // Text('최소구매수량: ${data.domeggook.qty.domeMoq}개'),
                    // Text('배송비: ${data.domeggook.deli.feeExtra}원'),
                  ],
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (err, _) => Text('Error: $err'),
            ),
          ],
        ),
      ),
    );
  }
}
