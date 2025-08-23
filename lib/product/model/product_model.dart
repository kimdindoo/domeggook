import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({required Domeggook domeggook}) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

@freezed
abstract class Domeggook with _$Domeggook {
  const factory Domeggook({required Header header, required ItemList list}) =
      _Domeggook;

  factory Domeggook.fromJson(Map<String, dynamic> json) =>
      _$DomeggookFromJson(json);
}

@freezed
abstract class Header with _$Header {
  const factory Header({
    required int numberOfItems,
    required int firstItem,
    required int lastItem,
    required int currentPage,
    required int itemsPerPage,
    required int numberOfPages,
    required String sort,
  }) = _Header;

  factory Header.fromJson(Map<String, dynamic> json) => _$HeaderFromJson(json);
}

@freezed
abstract class ItemList with _$ItemList {
  const factory ItemList({required List<Product> item}) = _ItemList;

  factory ItemList.fromJson(Map<String, dynamic> json) =>
      _$ItemListFromJson(json);
}

@freezed
abstract class Product with _$Product {
  const factory Product({
    required String no,
    required String title,
    required String thumb,
    required String idxCOM,
    required String id,
    required String price,
    required String unitQty,
    required String comOnly,
    required String adultOnly,
    required String lwp,
    required Delivery deli,
    required String url,
    required Market market,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@freezed
abstract class Delivery with _$Delivery {
  const factory Delivery({
    required String who,
    required String fee,
    required String add,
    required String fromOversea,
  }) = _Delivery;

  factory Delivery.fromJson(Map<String, dynamic> json) =>
      _$DeliveryFromJson(json);
}

@freezed
abstract class Market with _$Market {
  const factory Market({required String domeggook, required String supply}) =
      _Market;

  factory Market.fromJson(Map<String, dynamic> json) => _$MarketFromJson(json);
}
