import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cache_manager_dio/flutter_cache_manager_dio.dart';

class AppCacheManager {
  static CacheManager create(Dio dio) {
    return CacheManager(
      Config(
        'image_cache_key',
        stalePeriod: const Duration(days: 7),
        maxNrOfCacheObjects: 500,
        fileService: DioHttpFileService(dio),
      ),
    );
  }
}
