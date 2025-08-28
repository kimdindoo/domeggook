import 'dart:async';

import 'package:domeggook/category/provider/category_provider.dart';
import 'package:domeggook/common/layout/default_layout.dart';
import 'package:domeggook/config/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // 카테고리 데이터 미리 로드
      await ref.read(categoryProvider.future);

      // 데이터 로드 후 홈 화면으로 이동
      if (!mounted) return; // 위젯이 여전히 화면에 있을 때만 이동
      GoRouter.of(context).goNamed(RouteNames.home);
    } catch (e) {
      debugPrint('Splash load error: $e');
      // 필요하다면 에러 화면 또는 홈 이동
      if (!mounted) return;

      GoRouter.of(context).goNamed(RouteNames.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/img/logo/domeggook_logo.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
          ],
        ),
      ),
    );
  }
}
