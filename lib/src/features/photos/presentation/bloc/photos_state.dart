part of 'photos_bloc.dart';

@immutable
sealed class PhotosState {}

final class PhotosInitial extends PhotosState {}

final class PhotosLoading extends PhotosState {}

final class PhotosLoaded extends PhotosState {
  final List<Photo> photos;
  final bool hasMore;

  PhotosLoaded({required this.photos, required this.hasMore});
}

final class PhotosFails extends PhotosState {
  final String message;

  PhotosFails({required this.message});
}

final class LostConnection extends PhotosState {}
