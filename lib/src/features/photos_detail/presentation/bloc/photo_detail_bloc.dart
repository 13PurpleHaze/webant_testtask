import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:webant_testtask/src/core/network/connectivly_service.dart';
import 'package:webant_testtask/src/features/photos/domain/photo.dart';
import 'package:webant_testtask/src/features/photos/domain/photo_repository.dart';

part 'photo_detail_event.dart';
part 'photo_detail_state.dart';

class PhotoDetailBloc extends Bloc<PhotoDetailEvent, PhotoDetailState> {
  final PhotoRepository _photoRepository;
  final ConnectivityService _connectivityService;
  late final StreamSubscription<bool> _connectivitySubscription;

  PhotoDetailBloc({
    required PhotoRepository photoRepository,
    required ConnectivityService connectivityService,
  }) : _photoRepository = photoRepository,
       _connectivityService = connectivityService,
       super(PhotoDetailInitial()) {
    on<LoadPhotoDetail>(_load);
    on<ChangeConnection>(_changeConnection);
    _connectivitySubscription = _connectivityService.connectivityStream.listen((
      isConnected,
    ) {
      add(ChangeConnection(isConnected: isConnected));
    });
  }

  void _changeConnection(
    ChangeConnection event,
    Emitter<PhotoDetailState> emit,
  ) {
    if (!event.isConnected) {
      emit(LostConnection());
    }
  }

  Future<void> _load(
    LoadPhotoDetail event,
    Emitter<PhotoDetailState> emit,
  ) async {
    try {
      emit(PhotoDetailLoading());
      final photo = await _photoRepository.getPhotoById(id: event.id);
      emit(PhotoDetailLoaded(photo: photo));
    } catch (e) {
      emit(PhotoDetailFails(message: e.toString()));
    }
  }
}
