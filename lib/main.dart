import 'package:domeggook/common/view/root_tab.dart';
import 'package:domeggook/observer/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future main() async {
  await dotenv.load(fileName: ".env"); // .env 파일 로드
  runApp(
    ProviderScope(observers: [Logger()], child: const MyApp()),
  ); // providers를 읽을 수 있게, 로깅 하기 위해 logger 추가
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'domeggook',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const RootTab(),
    );
  }
}
