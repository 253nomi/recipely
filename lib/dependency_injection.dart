import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:receipe_task/data/data_sources/auth_data_sources.dart';
import 'package:receipe_task/data/data_sources/remote_data_sources.dart';
import 'package:receipe_task/data/repository_imp/repository_imp.dart';
import 'package:receipe_task/domain/repository/repository.dart';
import 'package:receipe_task/domain/usecases/get_category_list.dart';
import 'package:receipe_task/domain/usecases/get_cuisine_list.dart';
import 'package:receipe_task/domain/usecases/get_food_list.dart';
import 'package:receipe_task/domain/usecases/login_with_firebase_usecase.dart';
import 'package:receipe_task/globals/globals.dart';
import 'package:receipe_task/presentation/providers/login_provider.dart';
import 'package:receipe_task/presentation/providers/main_screen_provider.dart';
import 'package:receipe_task/utils/network_info.dart';

Future<void> registerDependencies() async {
  /// Firebase Instance
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  /// Firestore
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  /// Internet Connection Checker
  sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());

  /// Network Info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));

  /// Firebase Auth Data Source
  sl.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImp(firebaseAuth: sl()),
  );

  /// Firebase Remote Data Source
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImp(firestore: sl()),
  );

  /// Repository
  sl.registerLazySingleton<Repository>(
    () => RepositoryImp(networkInfo: sl(), authDataSource: sl(), remoteDataSource: sl()),
  );

  /// Login With Firebase UseCase
  sl.registerLazySingleton(() => LoginWithFirebaseUseCase(sl()));

  /// Get Food List UseCase
  sl.registerLazySingleton(() => GetFoodList(sl()));

  /// Get Category List UseCase
  sl.registerLazySingleton(() => GetCategoryList(sl()));

  /// Get Cuisine List UseCase
  sl.registerLazySingleton(() => GetCuisineList(sl()));

  /// Login Provider
  sl.registerLazySingleton(() => LoginProvider(loginWithFirebaseUseCase: sl()));

  /// Main Screen provider
  sl.registerLazySingleton(() => MainScreenProvider(getFoodList: sl(), getCategoryList: sl(), getCuisineList: sl()));
}
