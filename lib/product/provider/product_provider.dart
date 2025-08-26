import 'package:domeggook/product/model/product_detail_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repository/product_repository.dart';

part 'product_provider.g.dart';

@riverpod
Future<ProductDetailModel> productDetail(Ref ref, String productNo) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProductDetail(productNo);
}
