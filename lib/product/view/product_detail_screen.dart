import 'package:domeggook/common/layout/defalut_layout.dart';
import 'package:flutter/widgets.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.productNo});

  final String productNo;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '상품 상세',
      child: Center(child: Text('상품 번호: $productNo')),
    );
  }
}
