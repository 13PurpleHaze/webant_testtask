import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';
import 'package:webant_testtask/src/core/widgets/error_view.dart';
import 'package:webant_testtask/src/core/widgets/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:webant_testtask/src/features/photos_detail/presentation/bloc/photo_detail_bloc.dart';

class PhotoDetailScreen extends StatefulWidget {
  final int id;
  const PhotoDetailScreen({super.key, required this.id});

  @override
  State<PhotoDetailScreen> createState() => _PhotoDetailScreenState();
}

class _PhotoDetailScreenState extends State<PhotoDetailScreen> {
  @override
  void initState() {
    context.read<PhotoDetailBloc>().add(LoadPhotoDetail(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cacheManager = context.read<CacheManager>();

    return Scaffold(
      appBar: const CupertinoNavigationBar(previousPageTitle: 'Back'),
      body: BlocBuilder<PhotoDetailBloc, PhotoDetailState>(
        builder: (context, state) {
          if (state is PhotoDetailLoading) {
            return Center(child: Loader());
          }
          if (state is PhotoDetailFails) {
            return Center(
              child: ErrorView(title: 'Sorry!', message: state.message),
            );
          }
          if (state is PhotoDetailLoaded) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: state.photo.filePath,
                      cacheManager: cacheManager,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.photo.name ?? '',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.photo.user?.name ?? '',
                                style: Theme.of(context).textTheme.labelMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                              ),
                              Text(
                                DateFormat('dd.MM.yyyy').format(
                                  state.photo.createdAt ?? DateTime.now(),
                                ),
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.photo.description ?? 'Нет описания',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
