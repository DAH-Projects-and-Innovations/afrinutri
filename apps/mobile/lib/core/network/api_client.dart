// lib/core/network/api_client.dart
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/app_config.dart';

class ApiClient {
  late final Dio _dio;
  final _storage = const FlutterSecureStorage();

  static const _tokenKey = 'jwt_token';

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: appConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ));

    // Intercepteur : ajoute le token JWT à chaque requête
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: _tokenKey);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        // Token expiré → déconnexion automatique
        if (error.response?.statusCode == 401) {
          await _storage.delete(key: _tokenKey);
        }
        handler.next(error);
      },
    ));
  }

  // Sauvegarder le token après connexion
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // Supprimer le token à la déconnexion
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  // Vérifier si l'utilisateur est connecté
  Future<bool> hasToken() async {
    final token = await _storage.read(key: _tokenKey);
    return token != null;
  }

  // Méthodes HTTP exposées
  Future<Response> get(String path, {Map<String, dynamic>? params}) =>
      _dio.get(path, queryParameters: params);

  Future<Response> post(String path, {dynamic data}) =>
      _dio.post(path, data: data);

  Future<Response> put(String path, {dynamic data}) =>
      _dio.put(path, data: data);

  Future<Response> delete(String path) => _dio.delete(path);
}

// Instance globale partagée dans toute l'app
final apiClient = ApiClient();