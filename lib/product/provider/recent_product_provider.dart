import 'package:domeggook/product/model/recent_product_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive/hive.dart';

part 'recent_product_provider.g.dart';

@riverpod
class RecentProducts extends _$RecentProducts {
  late final Box<RecentProduct> _box;

  @override
  List<RecentProduct> build() {
    _box = Hive.box<RecentProduct>('recent_product');
    // 최근 본 순서대로 반환
    return _box.values.toList().reversed.toList();
  }

  /// 상품 추가
  void addProduct(RecentProduct product) {
    // 중복 제거
    final duplicates = _box.values.where((p) => p.id == product.id).toList();
    for (var p in duplicates) {
      p.delete();
    }

    _box.add(product);
    _refreshState();
  }

  /// 특정 상품 삭제
  void removeProduct(String id) {
    final target = _box.values.where((p) => p.id == id).toList();
    for (var p in target) {
      p.delete();
    }
    _refreshState();
  }

  /// 전체 삭제
  void clearAll() {
    _box.clear();
    _refreshState();
  }

  /// 상태 갱신
  void _refreshState() {
    state = _box.values.toList().reversed.toList();
  }
}
