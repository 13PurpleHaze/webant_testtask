import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:webant_testtask/src/core/api/api.dart';
import 'package:webant_testtask/src/core/image_cache/app_cache_manager.dart';
import 'package:webant_testtask/src/core/network/connectivly_service.dart';
import 'package:webant_testtask/src/features/photos/data/remote_photo_repository.dart';
import 'package:webant_testtask/src/features/photos/domain/photo_repository.dart';
import 'package:webant_testtask/src/features/photos/presentation/bloc/photos_bloc.dart';
import 'package:webant_testtask/src/features/photos/presentation/screens/photos_screen.dart';
import 'package:webant_testtask/src/features/photos_detail/presentation/bloc/photo_detail_bloc.dart';
import 'package:webant_testtask/src/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final api = ApiClient();
  runApp(MainApp(api: api));
}

class MainApp extends StatelessWidget {
  final ApiClient api;
  const MainApp({super.key, required this.api});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PhotoRepository>(
          create: (context) {
            return RemotePhotoRepository(dio: api.dio);
          },
        ),
        RepositoryProvider<CacheManager>(
          create: (context) {
            return AppCacheManager.create(api.dio);
          },
        ),
        RepositoryProvider<ConnectivityService>(
          create: (context) {
            return ConnectivityService();
          },
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PhotosBloc>(
            create: (context) {
              return PhotosBloc(
                photoRepository: context.read<PhotoRepository>(),
                connectivityService: context.read<ConnectivityService>(),
              );
            },
          ),
          BlocProvider<PhotoDetailBloc>(
            create: (context) {
              return PhotoDetailBloc(
                photoRepository: context.read<PhotoRepository>(),
                connectivityService: context.read<ConnectivityService>(),
              );
            },
          ),
        ],
        child: MaterialApp(home: PhotosScreen(), theme: appTheme),
      ),
    );
  }
}
