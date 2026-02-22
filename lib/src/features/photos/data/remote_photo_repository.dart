import 'package:dio/dio.dart';

import 'package:webant_testtask/src/features/photos/data/photo_model.dart';
import 'package:webant_testtask/src/features/photos/domain/photo.dart';
import 'package:webant_testtask/src/features/photos/domain/photo_repository.dart';

class RemotePhotoRepository implements PhotoRepository {
  final Dio _dio;

  const RemotePhotoRepository({required Dio dio}) : _dio = dio;

  @override
  Future<Photo> getPhotoById({required int id}) async {
    final response = await _dio.get('/photos/$id');
    final data = response.data;
    return PhotoModel.fromJson(data).toEntity();
  }

  @override
  Future<List<Photo>> getPhotos({
    required int page,
    required int itemsPerPage,
    bool? isNew,
    bool? isPopular,
  }) async {
    final Map<String, dynamic> queryParameters = {
      'page': page,
      'itemsPerPage': itemsPerPage,
    };
    if (isNew != null) {
      queryParameters['new'] = isNew;
    }
    if (isPopular != null) {
      queryParameters['popular'] = isPopular;
    }
    final response = await _dio.get(
      '/photos',
      queryParameters: queryParameters,
    );
    final data = response.data['hydra:member'] as List<dynamic>;
    return data.map((json) => PhotoModel.fromJson(json).toEntity()).toList();
  }
}
