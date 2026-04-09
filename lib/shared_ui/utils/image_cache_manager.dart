import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Custom cache manager that uses JSON metadata repository instead of sqflite.
/// This avoids runtime issues on environments where sqflite plugin is missing.
class ImageCacheManager {
  ImageCacheManager._();

  static const String _cacheKey = 'meal_image_cache';

  static final BaseCacheManager instance = CacheManager(
    Config(
      _cacheKey,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 200,
      repo: JsonCacheInfoRepository(databaseName: _cacheKey),
      fileService: HttpFileService(),
    ),
  );
}
