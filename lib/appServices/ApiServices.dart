import 'package:dio/dio.dart';
import 'package:reclaim/appServices/SharedPrefService.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    // Configure Dio instance
    _dio.options = BaseOptions(
      baseUrl: "https://reclaim.hboxdigital.website/api/",

      // Replace with your base URL
      connectTimeout: const Duration(minutes: 10),
      receiveTimeout: const Duration(minutes: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    // Add interceptors for logging
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print("\n[API Request]");
        print("Endpoint: ${options.baseUrl}${options.path}");
        print("Method: ${options.method}");
        print("Headers: ${options.headers}");
        print("Request Data: ${options.data}");
        handler.next(options);
      },
      onResponse: (response, handler) {
        print("\n[API Response]");
        print("Status Code: ${response.statusCode}");
        print("Data: ${response.data}");
        handler.next(response);
      },
      onError: (DioError error, handler) {
        print("\n[API Error]");
        print("Message: ${error.message}");
        print("Status Code: ${error.response?.statusCode}");
        print("Error Data: ${error.response?.data}");
        if (error.response != null) {}
        handler.next(error);
      },
    ));
  }

  Future<Response?> getRequest(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response;
    } catch (error) {
      print("Error in GET Request: \$error");
      return null;
    }
  }

  Future<Response?> postRequest(String endpoint,
      {Map<String, dynamic> data = const {}}) async {
    try {
      print("\n[API POST Request]");
      print("Endpoint: ${_dio.options.baseUrl}$endpoint");
      // FormData formData = FormData.fromMap(data); // Using FormData for form-data requests
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (error) {
      print("Error in POST Request: $error");
      return null;
    }
  }

  Future<Response?> getRequestwithtoken(String endpoint,
      {bool useAuth = true}) async {
    final dio = Dio();
    const String baseUrl =
        "https://reclaim.hboxdigital.website/api"; // <-- Add your base URL here
    final String url = "$baseUrl/$endpoint"; // <-- Correctly build full URL

    String? token;
    if (useAuth) {
      token = await SharedPrefService.getUserToken();
      print("📦 Bearer Token: $token");
    }

    try {
      print("Endpoint: $url");
      print("Method: GET");

      final response = await dio.get(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            if (token != null) "Authorization": "Bearer $token",
          },
        ),
      );

      print("[API Response]");
      print("Status Code: ${response.statusCode}");
      print("Data: ${response.data}");

      return response;
    } catch (e) {
      print("API GET error: $e");
      return null;
    }
  }

  Future<Response?> postMultipartRequest(String endpoint, FormData formData,
      {Map<String, String>? headers}) async {
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: _dio.options.baseUrl,
          connectTimeout: _dio.options.connectTimeout,
          receiveTimeout: _dio.options.receiveTimeout,
        ),
      );

      if (headers != null) {
        dio.options.headers.addAll(headers);
      }

      // Remove default JSON header for multipart
      dio.options.headers.remove('Content-Type');

      final response = await dio.post(endpoint, data: formData);
      return response;
    } catch (error) {
      print("Error in POST Multipart Request: $error");
      return null;
    }
  }

  // Future<Response?> postRequestWithToken(
  //     String endpoint, Map<String, dynamic> data,
  //     {Map<String, String>? headers}) async {
  //   try {
  //     print("\n[API POST Request]");
  //     print("Endpoint: ${_dio.options.baseUrl}$endpoint");

  //     // Add headers if provided
  //     if (headers != null) {
  //       _dio.options.headers.addAll(headers);
  //     }

  //     final response = await _dio.post(endpoint, data: data);
  //     return response;
  //   } catch (error) {
  //     print("Error in POST Request: $error");
  //     return null;
  //   }
  // }

  Future<Response?> postRequestWithToken(
    String endpoint,
    Map<String, dynamic> data, {
    Map<String, String>? headers,
  }) async {
    try {
      print("\n[API POST Request]");
      print("Endpoint: ${_dio.options.baseUrl}$endpoint");

      // Get token from shared prefs
      String? token = await SharedPrefService.getUserToken();
      print("📦 Bearer Token: $token");

      // Default headers
      final defaultHeaders = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      // Merge any extra headers
      if (headers != null) {
        defaultHeaders.addAll(headers);
      }

      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: defaultHeaders),
      );

      return response;
    } catch (error) {
      print("❌ Error in POST Request with Token: $error");
      return null;
    }
  }

  Future<Response?> deleteRequest(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? headers}) async {
    try {
      print("\n[API GET Request]");
      print("Endpoint: ${_dio.options.baseUrl}$endpoint");

      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }
      final response = await _dio.delete(
        endpoint,
        data: data,
      );
      return response;
    } catch (e) {
      print("Error in DELETE request: $e");
      return null;
    }
  }

  // Future<Response?> getRequestWithToken(String endpoint,
  //     {Map<String, String>? headers}) async {
  //   try {
  //     print("\n[API GET Request]");
  //     print("Endpoint: ${_dio.options.baseUrl}$endpoint");

  //     if (headers != null) {
  //       _dio.options.headers.addAll(headers);
  //     }

  //     final response = await _dio.get(endpoint);
  //     return response;
  //   } catch (error) {
  //     print("Error in GET Request: $error");
  //     return null;
  //   }
  // }
}
