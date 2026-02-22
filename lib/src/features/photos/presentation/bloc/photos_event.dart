part of 'photos_bloc.dart';

@immutable
sealed class PhotosEvent {}

final class LoadPhotos extends PhotosEvent {
  final PhotoCategory category;

  LoadPhotos({required this.category});
}

final class LoadMorePhotos extends PhotosEvent {
  final PhotoCategory category;

  LoadMorePhotos({required this.category});
}

class RefreshPhotos extends PhotosEvent {
  final Completer completer;
  final PhotoCategory category;

  RefreshPhotos({required this.completer, required this.category});
}

final class ChangeConnection extends PhotosEvent {
  final bool isConnected;

  ChangeConnection({required this.isConnected});
}
