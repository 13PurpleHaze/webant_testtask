part of 'photo_detail_bloc.dart';

@immutable
sealed class PhotoDetailState {}

final class PhotoDetailInitial extends PhotoDetailState {}

final class PhotoDetailLoading extends PhotoDetailState {}

final class PhotoDetailLoaded extends PhotoDetailState {
  final Photo photo;

  PhotoDetailLoaded({required this.photo});
}

final class PhotoDetailFails extends PhotoDetailState {
  final String message;

  PhotoDetailFails({required this.message});
}

final class LostConnection extends PhotoDetailState {}
