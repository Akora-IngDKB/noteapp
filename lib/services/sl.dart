import 'package:get_it/get_it.dart';
import 'package:note/services/FileService.dart';

GetIt sl = GetIt.instance;

setupServiceLocator() {
  sl.registerLazySingleton<FileService>(() => FileService());
}
