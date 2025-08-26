import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(Ref ref) {
  final options = BaseOptions(baseUrl: 'https://domeggook.com/ssl/api/');

  final dio = Dio(options);

  // 여기서 CustomInterceptor 추가
  dio.interceptors.add(CustomInterceptor(accessToken: null));

  return dio;
}

class CustomInterceptor extends Interceptor {
  final String? accessToken;

  CustomInterceptor({this.accessToken});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('[REQ] [${options.method}] ${options.uri}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');
    super.onError(err, handler);
  }
}
