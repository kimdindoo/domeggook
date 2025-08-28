import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({required Domeggook domeggook}) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}

@freezed
class Domeggook with _$Domeggook {
  const factory Domeggook({required Map<String, CategoryNode> items}) =
      _Domeggook;

  factory Domeggook.fromJson(Map<String, dynamic> json) =>
      _$DomeggookFromJson(json);
}

@freezed
class CategoryNode with _$CategoryNode {
  const factory CategoryNode({
    required String code,
    required String name,
    String? locked,
    @JsonKey(name: 'int') String? intValue, // JSON 필드명이 'int'여도 안전
    Map<String, CategoryNode>? child,
  }) = _CategoryNode;

  factory CategoryNode.fromJson(Map<String, dynamic> json) =>
      _$CategoryNodeFromJson(json);
}
