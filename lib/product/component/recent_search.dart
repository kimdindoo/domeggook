import 'package:domeggook/product/provider/recent_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/router/route_names.dart';

class RecentSearchWidget extends ConsumerWidget {
  const RecentSearchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searches = ref.watch(recentSearcheProvider);

    if (searches.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Text(
            '최근 검색어',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('최근 검색어가 없습니다', style: const TextStyle(fontSize: 12)),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '최근 검색어',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                ref.read(recentSearcheProvider.notifier).clearAll();
              },

              child: const Text(
                '전체삭제',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Wrap(
                spacing: 8,
                children: [
                  for (var search in searches)
                    GestureDetector(
                      onTap: () {
                        // 검색 결과 페이지로 이동
                        GoRouter.of(context).pushNamed(
                          RouteNames.keywordProduct,
                          queryParameters: {'keyword': search},
                        );
                      },
                      child: Chip(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ), // 원하는 둥글기 값으로 조절
                        ),
                        label: Text(search),
                        onDeleted: () {
                          ref
                              .read(recentSearcheProvider.notifier)
                              .removeSearch(search);
                        },
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
