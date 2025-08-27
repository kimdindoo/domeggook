import 'package:domeggook/product/provider/recent_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentSearchWidget extends ConsumerWidget {
  const RecentSearchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searches = ref.watch(recentSearcheProvider);

    if (searches.isEmpty) {
      return const Text("최근 검색어가 없습니다.");
    }

    return Wrap(
      spacing: 8,
      children: [
        for (var search in searches)
          Chip(
            label: Text(search),
            onDeleted: () {
              ref.read(recentSearcheProvider.notifier).removeSearch(search);
            },
          ),
        ActionChip(
          label: const Text("전체 삭제"),
          onPressed: () {
            ref.read(recentSearcheProvider.notifier).clearAll();
          },
        ),
      ],
    );
  }
}
