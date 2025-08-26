import 'package:domeggook/common/layout/defalut_layout.dart';
import 'package:domeggook/config/router/route_names.dart';
import 'package:domeggook/product/model/category_model.dart';
import 'package:domeggook/product/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(categoryProvider); // ← 여기 수정

    return DefaultLayout(
      title: '카테고리',
      child: category.when(
        data: (categoryModel) {
          final rootCategories = categoryModel.domeggook.items.values.toList();

          return ListView(
            children: rootCategories
                .map((category) => TopLevelExpansionTile(category: category))
                .toList(),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class TopLevelExpansionTile extends StatelessWidget {
  final CategoryNode category;

  const TopLevelExpansionTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final children = category.child?.values.toList() ?? [];

    if (children.isEmpty) {
      return ListTile(
        title: Text(
          category.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () {
          debugPrint("선택된 카테고리: ${category.name}, code: ${category.code}");
        },
      );
    }

    return Theme(
      data: Theme.of(
        context,
      ).copyWith(dividerColor: Colors.transparent), // 구분선 제거
      child: ExpansionTile(
        key: PageStorageKey<String>(category.code),
        title: Text(
          category.name,
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
        ),
        children: children.map((node) {
          return Container(
            color: Colors.grey.shade200,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24.0,
              ), // 좌측 padding
              title: Text(
                node.name,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              onTap: () {
                debugPrint("선택된 카테고리: ${node.name}, code: ${node.code}");

                GoRouter.of(context).pushNamed(
                  RouteNames.categoryProduct,
                  queryParameters: {'name': node.name, 'code': node.code},
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
