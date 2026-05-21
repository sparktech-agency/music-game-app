import 'package:get/get.dart';
import 'package:music_game_app/config/app_config.dart';


class BaseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = AppConfig.baseUrl;
    httpClient.timeout = const Duration(seconds: 30);

    // Default headers
    httpClient.defaultContentType = "application/json";

    // Request interceptor
    httpClient.addRequestModifier<dynamic>((request) {
      print('REQUEST => ${request.method} ${request.url}');
      print('Body: ${request.bodyBytes}');
      return request;
    });

    // Response interceptor
    httpClient.addResponseModifier((request, response) {
      print('RESPONSE => ${response.statusCode} ${response.body}');
      return response;
    });
  }
}