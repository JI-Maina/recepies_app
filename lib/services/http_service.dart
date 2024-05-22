import 'package:dio/dio.dart';
import 'package:recepies_app/constants.dart';

class HTTPService {
  // Ensure only a single service is running in our app
  static final HTTPService _singleton = HTTPService._internal();

  final _dio = Dio(); // initialize dio object

  factory HTTPService() {
    return _singleton;
  }

  HTTPService._internal() {
    setup();
  }

  // setup dio object
  Future<void> setup({String? bearerToken}) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    if (bearerToken != null) {
      headers['Authorization'] = 'Bearer $bearerToken';
    }

    final options = BaseOptions(
      baseUrl: API_BASE_URL,
      headers: headers,
      validateStatus: (status) {
        if (status == null) return false;
        return status < 500;
      },
    );

    _dio.options = options;
  }

  // Post method
  Future<Response?> post(String path, Map data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } catch (e) {
      print(e);
    }
  }
}
