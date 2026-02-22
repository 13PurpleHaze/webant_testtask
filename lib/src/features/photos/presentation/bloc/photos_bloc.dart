import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:webant_testtask/src/core/network/connectivly_service.dart';
import 'package:webant_testtask/src/features/photos/domain/photo.dart';
import 'package:webant_testtask/src/features/photos/domain/photo_category.dart';
import 'package:webant_testtask/src/features/photos/domain/photo_repository.dart';

part 'photos_event.dart';
part 'photos_state.dart';

const ITEMS_PER_PAGE = 10;

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final PhotoRepository _photoRepository;
  final ConnectivityService _connectivityService;
  late final StreamSubscription<bool> _connectivitySubscription;

  PhotosBloc({
    required PhotoRepository photoRepository,
    required ConnectivityService connectivityService,
  }) : _photoRepository = photoRepository,
       _connectivityService = connectivityService,
       super(PhotosInitial()) {
    on<LoadPhotos>(_load);
    on<RefreshPhotos>(_refresh);
    on<LoadMorePhotos>(_loadMore);
    on<ChangeConnection>(_changeConnection);
    _connectivitySubscription = _connectivityService.connectivityStream.listen((
      isConnected,
    ) {
      add(ChangeConnection(isConnected: isConnected));
    });
  }

  void _changeConnection(ChangeConnection event, Emitter<PhotosState> emit) {
    if (!event.isConnected) {
      emit(LostConnection());
    }
  }

  Future<void> _load(LoadPhotos event, Emitter<PhotosState> emit) async {
    try {
      emit(PhotosLoading());
      final photos = await _photoRepository.getPhotos(
        page: 1,
        itemsPerPage: ITEMS_PER_PAGE,
        isNew: event.category == PhotoCategory.newPhotos,
        isPopular: event.category == PhotoCategory.popularPhotos,
      );
      emit(
        PhotosLoaded(photos: photos, hasMore: photos.length == ITEMS_PER_PAGE),
      );
    } catch (e) {
      emit(PhotosFails(message: e.toString()));
    }
  }

  Future<void> _refresh(RefreshPhotos event, Emitter<PhotosState> emit) async {
    try {
      final photos = await _photoRepository.getPhotos(
        page: 1,
        itemsPerPage: ITEMS_PER_PAGE,
        isNew: event.category == PhotoCategory.newPhotos,
        isPopular: event.category == PhotoCategory.popularPhotos,
      );
      emit(
        PhotosLoaded(photos: photos, hasMore: photos.length == ITEMS_PER_PAGE),
      );
    } catch (e) {
      emit(PhotosFails(message: e.toString()));
    } finally {
      event.completer.complete();
    }
  }

  Future<void> _loadMore(
    LoadMorePhotos event,
    Emitter<PhotosState> emit,
  ) async {
    if (state is! PhotosLoaded) return;
    final currentState = state as PhotosLoaded;
    if (!currentState.hasMore) return;

    try {
      final nextPage = (currentState.photos.length / ITEMS_PER_PAGE).ceil() + 1;

      final photos = await _photoRepository.getPhotos(
        page: nextPage,
        itemsPerPage: ITEMS_PER_PAGE,
      );
      emit(
        PhotosLoaded(
          photos: [...currentState.photos, ...photos],
          hasMore: photos.length == ITEMS_PER_PAGE,
        ),
      );
    } catch (e) {
      emit(PhotosFails(message: e.toString()));
    }
  }
}
