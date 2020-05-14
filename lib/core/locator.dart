import 'package:covid19tracker/core/services/all_services.dart';
import 'package:covid19tracker/core/viewmodels/all_viewmodels.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator
    ..registerLazySingleton(() => Api())
    ..registerFactory(() => HomeViewModel());
}
