import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webant_testtask/src/core/widgets/error_view.dart';
import 'package:webant_testtask/src/core/widgets/loader.dart';
import 'package:webant_testtask/src/features/photos/domain/photo_category.dart';
import 'package:webant_testtask/src/features/photos/presentation/bloc/photos_bloc.dart';
import 'package:webant_testtask/src/features/photos_detail/presentation/screens/photo_detail_screen.dart';
import 'package:webant_testtask/src/features/photos/presentation/widgets/photo_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoGrid extends StatefulWidget {
  final PhotoCategory category;

  const PhotoGrid({super.key, required this.category});

  @override
  State<PhotoGrid> createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  @override
  void initState() {
    context.read<PhotosBloc>().add(LoadPhotos(category: widget.category));
    super.initState();
  }

  Future<void> _onRefresh() async {
    final completer = Completer();
    context.read<PhotosBloc>().add(
      RefreshPhotos(completer: completer, category: widget.category),
    );
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosBloc, PhotosState>(
      builder: (context, state) {
        if (state is LostConnection) {
          return ErrorView(
            message: 'Lost internet connection',
            title: 'Sorry!',
            onRetry: () {
              context.read<PhotosBloc>().add(
                LoadPhotos(category: widget.category),
              );
            },
          );
        }
        if (state is PhotosLoading) {
          return Center(child: Loader());
        }
        if (state is PhotosFails) {
          return Center(
            child: ErrorView(title: 'Sorry!', message: state.message),
          );
        }
        if (state is PhotosLoaded) {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1,
                          ),
                      itemCount: state.photos.length,
                      itemBuilder: (context, index) {
                        if (index == state.photos.length - 1) {
                          context.read<PhotosBloc>().add(
                            LoadMorePhotos(category: widget.category),
                          );
                        }
                        final photo = state.photos[index];
                        return PhotoCard(
                          photo: photo,
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) =>
                                    PhotoDetailScreen(id: photo.id),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  if (state.hasMore)
                    SliverPadding(
                      padding: EdgeInsets.all(16),
                      sliver: SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
