import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recent_search_provider.g.dart';

@riverpod
class RecentSearche extends _$RecentSearche {
  late final Box<String> _box;

  @override
  List<String> build() {
    _box = Hive.box<String>('recent_search');
    return _box.values.toList().reversed.toList();
  }

  void addSearch(String query) {
    if (query.trim().isEmpty) return;

    // 중복 제거 + 최신순
    if (state.contains(query)) {
      state = [query, ...state.where((s) => s != query)];
    } else {
      state = [query, ...state];
    }

    // 최대 10개까지만 저장
    if (state.length > 10) state = state.sublist(0, 10);

    _box.clear();
    for (var i = 0; i < state.length; i++) {
      _box.put(i, state[i]);
    }
  }

  void removeSearch(String query) {
    state = state.where((s) => s != query).toList();
    _box.clear();
    for (var i = 0; i < state.length; i++) {
      _box.put(i, state[i]);
    }
  }

  void clearAll() {
    _box.clear();
    state = [];
  }
}
