import 'package:domeggook/config/router/router_provider.dart';
import 'package:domeggook/observer/logger.dart';
import 'package:domeggook/product/model/recent_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(RecentProductAdapter());

  await Hive.openBox<RecentProduct>('recent_product'); // 최근 본 상품 저장용

  await Hive.openBox<String>('recent_search'); // 최근 검색어 저장용

  await dotenv.load(fileName: ".env"); // .env 파일 로드

  runApp(
    ProviderScope(observers: [Logger()], child: const MyApp()),
  ); // providers를 읽을 수 있게, 로깅 하기 위해 logger 추가
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'domeggook',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: router,
    );
  }
}
