import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../api/dio_client.dart';

class AuthService {
  final _secureStorage = const FlutterSecureStorage();
  final Dio _dio = DioClient.instance;
  

  final String _apiKey = "477239b2bc14b2b0cba8976a65291c75";
  
  static const _keySessionId = 'session_id';

  Future<bool> login(String username, String password) async {
    try {
        
      final requestToken = await _createRequestToken();
      if (requestToken == null) {
        return false;
      }


      final bool isValidated = await _validateWithLogin(requestToken, username, password);
      if (!isValidated) {
        return false;
      }


      final bool isSessionCreated = await _createSession(requestToken);
      return isSessionCreated;

    } on DioException catch (e) {
    
      debugPrint("Falha na autenticação: ${e.response?.data}");
      return false;
    } catch (e) {
      debugPrint("Ocorreu um erro inesperado no login: $e");
      return false;
    }
  }

  Future<String?> _createRequestToken() async {
    final response = await _dio.get(
      '/authentication/token/new',
      queryParameters: {'api_key': _apiKey},
    );
    return response.statusCode == 200 ? response.data['request_token'] : null;
  }

  Future<bool> _validateWithLogin(String requestToken, String username, String password) async {
    final response = await _dio.post(
      '/authentication/token/validate_with_login',
      queryParameters: {'api_key': _apiKey},
      data: {
        'username': username,
        'password': password,
        'request_token': requestToken,
      },
    );
    return response.statusCode == 200 && response.data['success'] == true;
  }

  Future<bool> _createSession(String requestToken) async {
    final response = await _dio.post(
      '/authentication/session/new',
      queryParameters: {'api_key': _apiKey},
      data: {'request_token': requestToken},
    );
    
    if (response.statusCode == 200 && response.data['success'] == true) {
      final sessionId = response.data['session_id'];
      await _secureStorage.write(key: _keySessionId, value: sessionId);
      return true;
    }
    return false;
  }

  Future<String?> getSessionId() async {
    return await _secureStorage.read(key: _keySessionId);
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: _keySessionId);
  }

  Future<bool> isUserLoggedIn() async {
    final sessionId = await getSessionId();
    return sessionId != null && sessionId.isNotEmpty;
  }
}