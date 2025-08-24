import 'package:domeggook/product/view/category_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:domeggook/common/layout/defalut_layout.dart';
import 'package:domeggook/product/model/category_model.dart';
import 'package:domeggook/product/repository/product_repository.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '카테고리',
      child: FutureBuilder<CategoryModel>(
        future: getCategory(), // API 호출
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data!.domeggook.items.isEmpty) {
            return const Center(child: Text('No categories found'));
          }

          final rootCategories = snapshot.data!.domeggook.items.values.toList();

          return ListView(
            children: rootCategories
                .map((category) => TopLevelExpansionTile(category: category))
                .toList(),
          );
        },
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
          debugPrint(
            "선택된 카테고리: ${category.name}, intValue: ${category.intValue}",
          );
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
                debugPrint(
                  "선택된 카테고리: ${node.name}, intValue: ${node.intValue}",
                );
                // 페이지 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryProductScreen(
                      categoryName: node.name,
                      categoryNumber: node.code,
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
