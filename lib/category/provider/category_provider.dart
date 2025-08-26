import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/category_repository.dart';
import '../model/category_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../product/provider/category_provider.g.dart';

@Riverpod(keepAlive: true)
Future<CategoryModel> category(Ref ref) async {
  final repo = ref.watch(categoryRepositoryProvider);
  return repo.getCategory();
}
