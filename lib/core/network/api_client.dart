import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class ApiClient {
  static String get baseUrl {
    // For Web (Chrome)
    if (kIsWeb) {
      return 'http://localhost:3000';
    }

    // For Android Phone (USB Debugging with adb reverse)
    if (Platform.isAndroid) {
      // adb reverse tcp:3000 tcp:3000 makes localhost work!
      return 'http://localhost:3000';
    }

    // For iOS Simulator
    if (Platform.isIOS) {
      return 'http://localhost:3000';
    }

    return 'http://localhost:3000';
  }

  late final Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  void setAuthToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthToken() {
    dio.options.headers.remove('Authorization');
  }
}
