import 'package:hive/hive.dart';

part 'recent_product_model.g.dart';

@HiveType(typeId: 0) // typeId는 프로젝트 내에서 유일해야 함
class RecentProduct extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String thumbnailUrl;

  @HiveField(3)
  final String price;

  @HiveField(4)
  final String minNumber;

  RecentProduct({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.price,
    required this.minNumber,
  });
}
