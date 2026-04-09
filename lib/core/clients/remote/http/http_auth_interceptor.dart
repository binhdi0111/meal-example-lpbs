part of 'http_client.dart';

/// Lightweight auth interceptor for meal-only flow.
/// Reads access token from persisted `userData` JSON if present.
@LazySingleton()
interface class HttpAuthInterceptor extends Interceptor {
  HttpAuthInterceptor();

  LocalStorageClient get _localStorageClient => GetIt.I<LocalStorageClient>();

  String? get _accessToken {
    final stored = _localStorageClient.getString(LocalDbKeys.userData);
    if (stored == null || stored.isEmpty) {
      return null;
    }

    try {
      final map = jsonDecode(stored);
      if (map is! Map<String, dynamic>) {
        return null;
      }

      // Support both flat and nested payload styles.
      final flatToken = map['accessToken'];
      if (flatToken is String && flatToken.isNotEmpty) {
        return flatToken;
      }

      final data = map['data'];
      if (data is Map<String, dynamic>) {
        final nestedToken = data['accessToken'];
        if (nestedToken is String && nestedToken.isNotEmpty) {
          return nestedToken;
        }
      }
    } catch (_) {
      return null;
    }

    return null;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
