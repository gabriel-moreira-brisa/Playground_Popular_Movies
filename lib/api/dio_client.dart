import 'package:dio/dio.dart';
import '../services/auth_service.dart';

class DioClient {
  final Dio _dio;
  
  // O construtor agora NÃO depende mais do AuthService
  DioClient._() : _dio = Dio() {
    _dio.options.baseUrl = 'https://api.themoviedb.org/3';
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  void setupAuthInterceptor(AuthService authService) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {

          final sessionId = await authService.getSessionId();
          if (sessionId != null) {
            options.queryParameters['session_id'] = sessionId;
          }
          return handler.next(options);
        },
      ),
    );
  }

  static final DioClient _instance = DioClient._();

  static Dio get instance => _instance._dio;

  static DioClient get client => _instance;
}