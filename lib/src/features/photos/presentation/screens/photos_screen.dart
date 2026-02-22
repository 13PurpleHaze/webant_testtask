import 'package:flutter/material.dart';
import 'package:webant_testtask/src/features/photos/domain/photo_category.dart';
import 'package:webant_testtask/src/features/photos/presentation/widgets/photo_grid.dart';
import 'package:webant_testtask/src/features/photos/presentation/widgets/photos_app_bar.dart';

const tabs = [Tab(text: 'New'), Tab(text: 'Popular')];

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        appBar: PhotosAppBar(tabs: tabs),
        body: TabBarView(
          children: [
            PhotoGrid(category: PhotoCategory.newPhotos),
            PhotoGrid(category: PhotoCategory.popularPhotos),
          ],
        ),
      ),
    );
  }
}
