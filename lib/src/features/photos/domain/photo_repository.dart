import './photo.dart';

abstract interface class PhotoRepository {
  Future<List<Photo>> getPhotos({
    required int page,
    required int itemsPerPage,
    bool? isNew,
    bool? isPopular,
  });
  Future<Photo> getPhotoById({required int id});
}
