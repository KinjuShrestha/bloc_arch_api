import 'package:get_it/get_it.dart';

final di = GetIt.instance;

Future<void> init() async {
  ///lifeline
  // Use cases
  // di.registerLazySingleton(() => GetLifelineUseCase(di()));

  // // Repository
  // di.registerLazySingleton<LifelineRepository>(
  //   () => LifelineRepositoryImpl(
  //     di(),
  //   ),
  // );

  // // Data sources
  // di.registerLazySingleton<GetLifelineDataSource>(
  //   () => GetLifelineDataSourceImpl(),
  // );

  // ///knocked-out 
  // // Use cases
  // di.registerLazySingleton(() => GetKnockedOutUseCase(di()));

  // // Repository
  // di.registerLazySingleton<KnockedOutRepository>(
  //   () => KnockedOutRepositoryImpl(
  //     di(),
  //   ),
  // );

  // // Data sources
  // di.registerLazySingleton<GetKnockedOutDataSource>(
  //   () => GetKnockedOutDataSourceImpl(),
  // );
  
}
