import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:webant_testtask/src/features/photos/domain/photo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoCard extends StatelessWidget {
  final Photo photo;
  final void Function() onTap;

  const PhotoCard({super.key, required this.photo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final imageUrl = photo.filePath;
    final cacheManager = context.read<CacheManager>();

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          cacheManager: cacheManager,
          placeholder: (context, url) => Container(
            color: Colors.grey[200],
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[100],
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image_not_supported_outlined, color: Colors.grey),
                SizedBox(height: 4),
                Text(
                  'Error',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
