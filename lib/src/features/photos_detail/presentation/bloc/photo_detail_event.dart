part of 'photo_detail_bloc.dart';

@immutable
sealed class PhotoDetailEvent {}

final class LoadPhotoDetail extends PhotoDetailEvent {
  final int id;

  LoadPhotoDetail({required this.id});
}

final class ChangeConnection extends PhotoDetailEvent {
  final bool isConnected;

  ChangeConnection({required this.isConnected});
}
