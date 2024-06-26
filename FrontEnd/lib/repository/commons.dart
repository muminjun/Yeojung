import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../providers/store.dart';

// 기본
class ApiClient {
  late Dio dio;
  var userManager = UserManager();

  ApiClient() {
    dio = Dio();
    userManager.loadUserInfo();
    print("간다간다api요청~~~");
    dio.options.baseUrl = dotenv.env['BASE_URL']!;
    // dio.options.baseUrl = "http://10.0.2.2:8080/api/v1";
    dio.options.headers['Content-Type'] = 'application/json';
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      final jwtToken = await userManager.jwtToken;

      if (jwtToken != null) {
        options.headers["Authorization"] = "$jwtToken";
      }
      return handler.next(options);
    }));
  }

// GET 요청
  Future<Response> get(String path, {dynamic queryParameters}) async {
    return dio.get(path, queryParameters: queryParameters);
  }

  // POST 요청
  Future<Response> post(String path, {dynamic data}) async {
    return dio.post(path, data: data);
  }

  // PUT 요청
  Future<Response> put(String path, {dynamic data, Options? options}) async {
    return dio.put(path, data: data, options: options);
  }

  // DELETE 요청
  Future<Response> delete(String path, {dynamic data}) async {
    return dio.delete(path, data: data);
  }
}

// 사진 or 파일 전용
class ApiFileClient {
  late Dio dio;
  var userManager = UserManager();

  ApiFileClient() {
    dio = Dio();
    userManager.loadUserInfo();
    print("간다간다apiFile요청~~~");
    dio.options.baseUrl = dotenv.env['BASE_URL']!;
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      final jwtToken = await userManager.jwtToken;

      if (jwtToken != null) {
        options.headers["Authorization"] = "$jwtToken";
      }
      return handler.next(options);
    }));
  }

  // GET 요청
  Future<Response> get(String path, {dynamic queryParameters}) async {
    return dio.get(path, queryParameters: queryParameters);
  }

  // POST 요청
  Future<Response> post(String path, {dynamic data}) async {
    return dio.post(path, data: data);
  }

  // PUT 요청
  Future<Response> put(String path, {dynamic data}) async {
    return dio.put(path, data: data);
  }

  // DELETE 요청
  Future<Response> delete(String path, {dynamic data}) async {
    return dio.delete(path, data: data);
  }
}
